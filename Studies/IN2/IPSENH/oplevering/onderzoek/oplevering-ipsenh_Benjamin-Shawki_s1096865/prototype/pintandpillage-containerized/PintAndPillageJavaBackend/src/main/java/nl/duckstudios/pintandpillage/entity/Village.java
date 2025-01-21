package nl.duckstudios.pintandpillage.entity;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import java.time.LocalDateTime;
import java.util.*;
import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;
import nl.duckstudios.pintandpillage.entity.buildings.*;
import nl.duckstudios.pintandpillage.entity.logs.CombatLog;
import nl.duckstudios.pintandpillage.entity.logs.LogLine;
import nl.duckstudios.pintandpillage.entity.logs.VillageLog;
import nl.duckstudios.pintandpillage.entity.production.Unit;
import nl.duckstudios.pintandpillage.entity.researching.*;
import nl.duckstudios.pintandpillage.entity.travels.AttackCombatTravel;
import nl.duckstudios.pintandpillage.entity.travels.ReturningCombatTravel;
import nl.duckstudios.pintandpillage.model.BuildPosition;
import nl.duckstudios.pintandpillage.model.ResearchType;
import nl.duckstudios.pintandpillage.model.ResourceType;
import nl.duckstudios.pintandpillage.model.UnitType;
import org.hibernate.annotations.Where;

@Entity
@Table(name = "Villages")
public class Village {

  @Getter
  @Setter
  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private long villageId;

  @Getter @Setter private String name;

  @Getter @Setter private int positionX;

  @Getter @Setter private int positionY;

  @Getter
  @Setter
  @ManyToOne(fetch = FetchType.EAGER)
  private User user;

  @Getter @Setter private int morale = 100;

  @Getter @Setter @Transient @JsonManagedReference private boolean newLogAvailable;

  @Getter @Setter private int villagePoints = 100;

  @Getter @Setter private int villagePointsCached;

  @Getter @Setter private int population = 0;

  @Getter @Setter private int populationInUse = 0;

  @Getter @Setter private int populationLeft = 0;

  @Getter @Setter private int resourceLimit = 0;

  @Getter
  @Setter
  @OneToMany(mappedBy = "village")
  @JsonManagedReference
  private List<Research> completedResearches = new ArrayList<>();

  @Getter @Setter @Transient @JsonSerialize @JsonDeserialize
  private List<Research> availableResearches;

  @Setter
  @Getter
  @OneToMany(mappedBy = "village", cascade = CascadeType.ALL, orphanRemoval = true)
  @JsonManagedReference
  private Set<VillageUnit> unitsInVillage = new HashSet<>();

  @Getter @Setter @ElementCollection
  private Map<String, Integer> villageResources =
      new HashMap<>() {
        {
          put(ResourceType.Stone.name(), 500);
          put(ResourceType.Wood.name(), 500);
          put(ResourceType.Beer.name(), 500);
        }
      };

  @Getter @Setter @Transient @JsonSerialize @JsonDeserialize
  private Map<String, Integer> resourcesPerHour = new HashMap<>();

  @OneToMany(mappedBy = "village", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
  @JsonManagedReference
  private Set<Building> buildings;

  @Transient @Getter @Setter private BuildPosition[] validBuildPositions;

  @Transient @Getter @Setter private List<Building> buildingsThatCanBeBuild;

  @Getter
  @Setter
  @OneToMany(mappedBy = "defendingVillage", cascade = CascadeType.ALL, orphanRemoval = true)
  @JsonManagedReference
  private List<AttackCombatTravel> incomingAttacks = new ArrayList<>();

  @Getter
  @Setter
  @OneToMany(mappedBy = "attackingVillage", cascade = CascadeType.ALL, orphanRemoval = true)
  @JsonManagedReference
  private List<AttackCombatTravel> outgoingAttacks = new ArrayList<>();

  @Getter
  @Setter
  @OneToMany(mappedBy = "returningToVillage", cascade = CascadeType.ALL, orphanRemoval = true)
  @JsonManagedReference
  private List<ReturningCombatTravel> returningCombatTravels = new ArrayList<>();

  @Getter @Setter private int totalDefence;

  @Getter
  @Setter
  @OneToMany(mappedBy = "village", cascade = CascadeType.ALL, orphanRemoval = true)
  @Where(clause = "type = 'VILLAGE_LOG'")
  @JsonManagedReference
  private List<LogLine> villageLog = new ArrayList<>();

  @Getter
  @Setter
  @OneToMany(mappedBy = "village", cascade = CascadeType.ALL, orphanRemoval = true)
  @Where(clause = "type = 'COMBAT_LOG'")
  @JsonManagedReference
  private List<LogLine> combatLog = new ArrayList<>();

  public Village() {
    this.buildings = new HashSet<>();
    this.createValidBuildingPositions();
    this.createBuildableBuildingsList();
    this.updateVillageState();
    this.unitsInVillage = new HashSet<>();
    this.setAvailableResearches();
  }

  public void createBuilding(Building building) {
    this.buildings.add(building);
    this.updateVillageState();
  }

  public void updateVillageState() {
    for (Building building : this.buildings) {
      building.updateBuildingState();
    }
    this.calculatePopulation();
    this.calculateResourcesPerHour();
    this.setAvailableResearches();
    this.calculateTotalDefence();
    this.calculateResourceLimit();
    this.calculateVillagePoints();
  }

  public boolean hasEnoughPopulation(int population) {
    return this.populationLeft >= population;
  }

  public boolean hasEnoughPopulation(int populationPerItem, int amount) {
    return this.populationLeft >= populationPerItem * amount;
  }

  public void addUnit(Unit unit, int amountOfUnits) {
    if (this.getUnitInVillage(unit.getUnitName()) == null) {
      VillageUnit villageUnit = new VillageUnit(unit, amountOfUnits);
      villageUnit.setVillage(this);
      this.unitsInVillage.add(villageUnit);
      return;
    }

    for (VillageUnit villageUnit : this.unitsInVillage) {
      if (villageUnit.getUnit().getUnitName().equals(unit.getUnitName())) {
        villageUnit.setAmount(villageUnit.getAmount() + amountOfUnits);
      }
    }
  }

  public VillageUnit getUnitInVillage(UnitType unitType) {
    VillageUnit unit =
        this.unitsInVillage.stream()
            .filter(u -> u.getUnit().getUnitName() == unitType)
            .findFirst()
            .orElse(null);
    return unit;
  }

  public int getResearchLevel(ResearchType researchType) {
    for (Research completedResearch : this.completedResearches) {
      if (completedResearch.getResearchName() == researchType) {
        return completedResearch.getResearchLevel();
      }
    }
    return 0;
  }

  public void addCompleteResearch(Research research) {
    this.completedResearches.add(research);
  }

  public Map<String, Integer> getPillageableResources() {
    Map<String, Integer> pillageableResources = new HashMap<>();
    for (Map.Entry<String, Integer> resource : this.villageResources.entrySet()) {
      pillageableResources.put(resource.getKey(), resource.getValue() / 2);
    }
    return pillageableResources;
  }

  public void addReturnTravel(ReturningCombatTravel returningCombatTravel) {
    this.returningCombatTravels.add(returningCombatTravel);
  }

  public void addToVillageLog(LocalDateTime timestamp, String message) {
    this.villageLog.sort(Comparator.comparing(LogLine::getDate));
    if (this.villageLog.size() > 2) {
      this.villageLog.remove(0);
    }
    this.villageLog.add(new VillageLog(timestamp, message, this));
    this.villageLog.sort(Comparator.comparing(LogLine::getDate));
    this.newLogAvailable = true;
  }

  public void addToCombatLog(LocalDateTime timestamp, String message) {
    this.combatLog.sort(Comparator.comparing(LogLine::getDate));
    if (this.combatLog.size() > 2) {
      this.combatLog.remove(0);
    }
    this.combatLog.add(new CombatLog(timestamp, message, this));
    this.combatLog.sort(Comparator.comparing(LogLine::getDate));
    this.newLogAvailable = true;
  }

  private void calculateVillagePoints() {
    this.villagePoints = this.buildings.stream().mapToInt(Building::getPoints).sum();
  }

  private void calculateResourceLimit() {
    this.resourceLimit = 0;
    List<IStorable> storageBuildings =
        this.buildings.stream()
            .filter(x -> x instanceof IStorable)
            .map(n -> (IStorable) n)
            .toList();

    storageBuildings.forEach(
        s -> {
          this.resourceLimit += s.getResourceCapacity();
        });
  }

  private void calculateTotalDefence() {
    this.totalDefence =
        this.unitsInVillage.stream()
            .mapToInt(
                t ->
                    (int)
                        (t.getUnit().getDefence()
                            * (1 + 0.1f * this.getResearchLevel(t.getUnit().getResearchRequired()))
                            * t.getAmount()))
            .sum();
  }

  private void createBuildableBuildingsList() {
    this.buildingsThatCanBeBuild =
        Arrays.asList(
            new Barracks(),
            new House(),
            new Mine(),
            new Farm(),
            new Lumberyard(),
            new Tavern(),
            new Wall(),
            new DefenceTower(),
            new Harbor(),
            new Smith(),
            new Storage());
  }

  private void createValidBuildingPositions() {
    this.validBuildPositions =
        new BuildPosition[] {
          new BuildPosition(2, 2),
          new BuildPosition(9, 4),
          new BuildPosition(3, 7),
          new BuildPosition(1, 4),
          new BuildPosition(6, 6, "Headquarters"),
          new BuildPosition(2, 4),
          new BuildPosition(11, 2),
          new BuildPosition(0, 0, "Wall"),
          new BuildPosition(5, 10),
          new BuildPosition(0, 10),
          new BuildPosition(12, 1),
          new BuildPosition(11, 10, "Harbor"),
          new BuildPosition(9, 7),
          new BuildPosition(14, 7),
          new BuildPosition(9, 13, "Harbor"),
          new BuildPosition(6, 2),
          new BuildPosition(3, 12),
          new BuildPosition(1, 11),
          new BuildPosition(1, 8),
          new BuildPosition(2, 10),
          new BuildPosition(8, 10),
          new BuildPosition(7, 13),
          new BuildPosition(12, 6),
          new BuildPosition(8, 6),
          new BuildPosition(4, 4),
          new BuildPosition(12, 4),
          new BuildPosition(4, 1),
        };
  }

  private void calculatePopulation() {
    this.population = 0;
    this.populationInUse = 0;
    List<IPopulatable> populationBuildings =
        this.buildings.stream()
            .filter(x -> x instanceof IPopulatable)
            .map(n -> (IPopulatable) n)
            .toList();

    populationBuildings.forEach(
        b -> {
          this.population += b.getPopulationCapacity();
        });

    for (Building building : this.buildings) {
      this.populationInUse += building.getTotalPopulationInUse();
    }
    this.populationLeft = this.population - this.populationInUse;
  }

  private void calculateResourcesPerHour() {
    Map<String, Integer> resourcesPerHour = new HashMap<>();

    List<ResourceBuilding> resourceBuildings =
        this.buildings.stream()
            .filter(x -> x instanceof ResourceBuilding)
            .map(n -> (ResourceBuilding) n)
            .toList();

    for (ResourceBuilding building : resourceBuildings) {
      ResourceType currentType = building.getGeneratesResource();
      if (!resourcesPerHour.containsKey(currentType.name())) {
        resourcesPerHour.put(currentType.name(), building.getResourcesPerHour());
        continue;
      }
      resourcesPerHour.put(
          currentType.name(),
          resourcesPerHour.get(currentType.name()) + building.getResourcesPerHour());
    }
    this.resourcesPerHour = resourcesPerHour;
  }

  private void setAvailableResearches() {
    List<Research> researches = new ArrayList<>();
    researches.add(new SpearResearch());
    researches.add(new JarlResearch());
    researches.add(new DefenceShipResearch());
    researches.add(new BattleShipResearch());
    researches.add(new BowResearch());
    researches.add(new AxeResearch());
    researches.add(new ShieldResearch());

    // have fun!
    for (Research completedResearch : this.completedResearches) {
      researches.stream()
          .filter(r -> r.getResearchName().equals(completedResearch.getResearchName()))
          .findFirst()
          .ifPresent(
              matchedResearch ->
                  matchedResearch.setResearchLevel(completedResearch.getResearchLevel()));
    }
    this.availableResearches = researches;
  }
}
