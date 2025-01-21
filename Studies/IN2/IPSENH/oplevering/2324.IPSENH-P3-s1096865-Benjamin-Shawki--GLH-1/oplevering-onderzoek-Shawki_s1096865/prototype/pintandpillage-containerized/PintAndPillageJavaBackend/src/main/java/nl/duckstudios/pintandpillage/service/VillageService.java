package nl.duckstudios.pintandpillage.service;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.*;
import nl.duckstudios.pintandpillage.Exceptions.SettleConditionsNotMetException;
import nl.duckstudios.pintandpillage.dao.VillageDataMapper;
import nl.duckstudios.pintandpillage.entity.Coord;
import nl.duckstudios.pintandpillage.entity.Village;
import nl.duckstudios.pintandpillage.entity.VillageUnit;
import nl.duckstudios.pintandpillage.entity.WorldMap;
import nl.duckstudios.pintandpillage.entity.buildings.Building;
import nl.duckstudios.pintandpillage.entity.travels.AttackCombatTravel;
import nl.duckstudios.pintandpillage.entity.travels.CombatTravel;
import nl.duckstudios.pintandpillage.entity.travels.ReturningCombatTravel;
import nl.duckstudios.pintandpillage.helper.ResourceManager;
import nl.duckstudios.pintandpillage.model.UnitType;
import nl.duckstudios.pintandpillage.model.WorldVillage;
import org.springframework.stereotype.Service;

@Service
public class VillageService {

  private final VillageDataMapper villageDataMapper;
  private final ResourceManager resourceManager;

  private final WorldService worldService;
  private final DistanceService distanceService;

  public VillageService(
      VillageDataMapper villageDataMapper,
      ResourceManager resourceManager,
      WorldService worldService,
      DistanceService distanceService) {
    this.villageDataMapper = villageDataMapper;
    this.resourceManager = resourceManager;
    this.worldService = worldService;
    this.distanceService = distanceService;
  }

  public Village getVillage(long id) {
    Village village = villageDataMapper.getVillage(id);
    this.updateCombatState(village);
    return village;
  }

  public List<Village> getListOfVillagesFromUser(long id) {
    return villageDataMapper.getVillages(id);
  }

  public Village createBuilding(Village village, Building building) {
    return this.villageDataMapper.createBuilding(village, building);
  }

  public void update(Village village) {
    this.villageDataMapper.update(village);
  }

  public List<WorldVillage> getWorldVillages() {
    return this.villageDataMapper.getWorldVillages();
  }

  public void checkIsValidCreatingSpot(Village village, Coord newPosition) {
    if (village.getUnitInVillage(UnitType.Jarl).getAmount() < 1) {
      throw new SettleConditionsNotMetException("To create a new village you need a jarl");
    }

    if (!this.isValidCreateDistance(village, newPosition)) {
      throw new SettleConditionsNotMetException(
          "Too much distance between your village and the new village");
    }

    WorldMap worldMap = this.worldService.getWorldMap();
    if (!worldMap.isValidToBuildNewVillage(newPosition)) {
      throw new SettleConditionsNotMetException("Invalid build spot for a new village");
    }
  }

  private boolean isValidCreateDistance(Village village, Coord newPosition) {
    if (newPosition == null) {
      return false;
    }

    final int maxDistance = 5;
    return this.distanceService.calculateDistance(
            new Coord(village.getPositionX(), village.getPositionY()), newPosition)
        <= maxDistance;
  }

  private void updateCombatState(Village village) {
    List<CombatTravel> travels = new ArrayList<>();
    travels.addAll(village.getIncomingAttacks());
    travels.addAll(village.getOutgoingAttacks());
    travels.addAll(village.getReturningCombatTravels());

    travels.sort(Comparator.comparing(CombatTravel::getTimeOfArrival));

    for (CombatTravel travel : travels) {
      if (LocalDateTime.now().isBefore(travel.getTimeOfArrival())) {
        long secondsBetween =
            ChronoUnit.SECONDS.between(LocalDateTime.now(), travel.getTimeOfArrival());
        travel.setTravelTimeLeft(LocalTime.of(0, 0, 0).plusSeconds(secondsBetween));
        continue;
      }
      if (travel instanceof AttackCombatTravel) {
        this.fight((AttackCombatTravel) travel);
      } else if (travel instanceof ReturningCombatTravel) {
        System.out.println("Returning with the units!");
        this.returnUnits(village, (ReturningCombatTravel) travel);
      }
    }
  }

  private void fight(AttackCombatTravel travel) {
    this.attack(travel);
    Village attackingVillage = travel.getAttackingVillage();
    Village defendingVillage = travel.getDefendingVillage();

    attackingVillage.getOutgoingAttacks().remove(travel);
    defendingVillage.getIncomingAttacks().remove(travel);
    travel.setDefendingVillage(null);
    travel.setAttackingVillage(null);
    this.villageDataMapper.update(attackingVillage);
    this.villageDataMapper.update(defendingVillage);
  }

  private void attack(AttackCombatTravel travel) {
    // this one is fun too!
    int attackingVillageStat =
        travel.getTravelingUnits().stream()
            .mapToInt(
                t ->
                    (int)
                        (t.getUnit().getAttack()
                            * (1
                                + 0.1f
                                    * travel
                                        .getAttackingVillage()
                                        .getResearchLevel(t.getUnit().getResearchRequired()))
                            * t.getAmount()))
            .sum();
    int defendingVillageStat = travel.getDefendingVillage().getTotalDefence();
    int difference = attackingVillageStat - defendingVillageStat;

    System.out.println(attackingVillageStat);
    System.out.println(defendingVillageStat);

    float diffAbs = Math.abs(difference) + 0.0f;

    if (difference > 0) {
      System.out.println("You won!");
      this.winBattle(travel, diffAbs / (attackingVillageStat + 1));
    } else {
      this.loseBattle(travel, diffAbs / (defendingVillageStat + 1));
      System.out.println("-------------------- You lost the battle ---------------------------");
    }
  }

  private void loseBattle(AttackCombatTravel travel, float percentLost) {
    travel.getTravelingUnits().clear();
    for (VillageUnit defendingUnits : travel.getDefendingVillage().getUnitsInVillage()) {
      defendingUnits.setAmount(Math.round(defendingUnits.getAmount() * percentLost));
    }
    travel
        .getAttackingVillage()
        .addToCombatLog(
            LocalDateTime.now(),
            "You have lost the battle against " + travel.getDefendingVillage().getName());
  }

  private void winBattle(AttackCombatTravel travel, float percentLost) {
    travel.getDefendingVillage().getUnitsInVillage().clear();
    for (VillageUnit travelingUnit : travel.getTravelingUnits()) {
      travelingUnit.setAmount(Math.round(travelingUnit.getAmount() * percentLost));
    }

    int totalPillage =
        travel.getTravelingUnits().stream()
            .mapToInt(t -> (int) (t.getUnit().getPlunderAmount() * t.getAmount()))
            .sum();
    Map<String, Integer> pillagedResources = new HashMap<>();
    Map<String, Integer> villageResources = travel.getDefendingVillage().getVillageResources();
    Map<String, Integer> pillagableResources =
        travel.getDefendingVillage().getPillageableResources();

    for (Map.Entry<String, Integer> resource : pillagableResources.entrySet()) {
      int amount = Math.min(totalPillage / villageResources.size(), resource.getValue());
      pillagedResources.put(resource.getKey(), amount);
    }

    this.resourceManager.subtractResources(travel.getDefendingVillage(), pillagableResources);

    ReturningCombatTravel returningCombatTravel = this.createReturnTravel(travel);
    returningCombatTravel.setPillagedResources(pillagedResources);
    returningCombatTravel.setReturningToVillage(travel.getAttackingVillage());
    travel.getAttackingVillage().addReturnTravel(returningCombatTravel);

    travel
        .getAttackingVillage()
        .addToCombatLog(
            LocalDateTime.now(),
            "You have won the battle against " + travel.getDefendingVillage().getName());
    travel
        .getDefendingVillage()
        .addToCombatLog(
            LocalDateTime.now(),
            "You have lost to the invaders from " + travel.getAttackingVillage().getName());
  }

  private ReturningCombatTravel createReturnTravel(AttackCombatTravel travel) {
    ReturningCombatTravel returningCombatTravel = new ReturningCombatTravel();
    List<VillageUnit> travelingUnits = new ArrayList<>();
    for (VillageUnit travelUnits : travel.getTravelingUnits()) {
      VillageUnit villageUnit = new VillageUnit(travelUnits.getUnit(), travelUnits.getAmount());
      villageUnit.setCombatTravel(returningCombatTravel);
      travelingUnits.add(villageUnit);
    }
    returningCombatTravel.setTravelingUnits(travelingUnits);
    returningCombatTravel.setTravelTime(travel.getTravelTime());
    returningCombatTravel.setTimeOfArrival(
        LocalDateTime.now().plusSeconds(travel.getTravelTime().toSecondOfDay()));
    return returningCombatTravel;
  }

  private void returnUnits(Village village, ReturningCombatTravel travel) {
    for (VillageUnit unit : travel.getTravelingUnits()) {
      village.addUnit(unit.getUnit(), unit.getAmount());
    }

    for (Map.Entry<String, Integer> resource : travel.getPillagedResources().entrySet()) {
      this.resourceManager.addResources(village, resource.getValue(), resource.getKey());
    }

    village.getReturningCombatTravels().remove(travel);
    travel.setReturningToVillage(null);
    village.addToCombatLog(LocalDateTime.now(), "Your units have returned!");
    this.villageDataMapper.update(village);
  }
}
