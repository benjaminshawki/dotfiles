package nl.duckstudios.pintandpillage.entity.buildings;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.Map;
import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;
import nl.duckstudios.pintandpillage.Exceptions.BuildingConditionsNotMetException;
import nl.duckstudios.pintandpillage.entity.Coord;
import nl.duckstudios.pintandpillage.entity.Village;
import nl.duckstudios.pintandpillage.helper.ResourceManager;

@Entity
@Table(name = "Buildings")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
public class Building {

  @Transient protected final ResourceManager resourceManager;
  @Getter @Setter @Id @GeneratedValue private long buildingId;

  @Getter
  @Setter
  @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
  @JsonBackReference
  private Village village;

  @Getter @Setter private String description;

  @Getter
  @Setter
  @JsonProperty("isUnderConstruction")
  private boolean isUnderConstruction = true;

  @Getter @Setter private int level = 0;
  @Getter @Setter private boolean producesResources = false;

  @Getter @Setter @Transient
  private Map<String, Integer> buildingLevelRequiredToLevelup = new HashMap<>();

  @Setter private LocalTime constructionTimeLeft;
  @Getter @Setter private LocalTime constructionTime;
  @Getter @Setter private LocalDateTime levelupFinishedTime;
  @Getter private long constructionTimeSeconds = 0;

  @Getter
  @Setter
  @OneToOne(cascade = CascadeType.ALL)
  @JoinColumn(name = "position_id", referencedColumnName = "id")
  private Coord position;

  @Getter @Setter @Transient @JsonDeserialize @JsonSerialize
  private Map<String, Integer> resourcesRequiredLevelUp;

  @Setter @Getter private int populationRequiredNextLevel;

  @Setter @Getter private int totalPopulationInUse;

  @Setter @Getter private int points;

  public Building() {
    this.populationRequiredNextLevel = this.getPopulationRequired(1);
    this.resourceManager = new ResourceManager();
  }

  public void setConstructionTime() {
    this.constructionTime = LocalTime.of(0, 0, 0).plusSeconds(this.constructionTimeSeconds);
  }

  public LocalTime getConstructionTimeLeft() {
    if (this.levelupFinishedTime == null) {
      return LocalTime.of(0, 0, 0);
    }
    long secondsTimeLeft =
        LocalTime.now().until(this.levelupFinishedTime.toLocalTime(), ChronoUnit.SECONDS);
    if (secondsTimeLeft <= 0) {
      return LocalTime.of(0, 0, 0);
    }
    LocalTime timeLeft = LocalTime.of(0, 0, 0).plusSeconds(secondsTimeLeft);
    return timeLeft;
  }

  public void setConstructionTimeSeconds(long seconds) {
    this.constructionTimeSeconds = seconds;
    this.setConstructionTime();
  }

  public void levelUp() {
    if (!this.resourceManager.hasEnoughResourcesAvailable(
        this.village, this.resourcesRequiredLevelUp)) {
      throw new BuildingConditionsNotMetException("Not enough resources available");
    }

    if (!this.village.hasEnoughPopulation(this.populationRequiredNextLevel)) {
      throw new BuildingConditionsNotMetException("Not enough population available");
    }

    this.levelupFinishedTime = LocalDateTime.now().plusSeconds(this.constructionTimeSeconds);
    this.isUnderConstruction = true;
    this.resourceManager.subtractResources(this.village, this.resourcesRequiredLevelUp);
  }

  public void updateBuildingState() {
    this.updateVillageState();
    this.checkLevelUpFinished();
    this.points = (int) ((5 + Math.floor((this.level + 1) * 0.2)) * (this.level + 1));
    this.populationRequiredNextLevel =
        this.level == 0
            ? this.getPopulationRequired(1)
            : this.getPopulationRequired(this.level + 1);
    // When the building is under construction the population of the next level needs to be added
    // already.
    this.totalPopulationInUse =
        this.getPopulationRequired(this.level + (this.isUnderConstruction ? 1 : 0));
    this.updateBuilding();
  }

  public int getPopulationRequired(int adjustment) {
    return (3 + (int) Math.pow(10, adjustment * 0.2) + 1) + (adjustment * 2);
  }

  public void updateBuilding() {}
  ;

  private void checkLevelUpFinished() {
    if (this.levelupFinishedTime != null && LocalDateTime.now().isAfter(this.levelupFinishedTime)) {
      this.isUnderConstruction = false;
      this.village.addToVillageLog(
          LocalDateTime.now(), "Finished building " + this.getClass().getSimpleName());
      this.levelupFinishedTime = null;
      this.level++;
    }
  }

  protected void updateVillageState() {}
}
