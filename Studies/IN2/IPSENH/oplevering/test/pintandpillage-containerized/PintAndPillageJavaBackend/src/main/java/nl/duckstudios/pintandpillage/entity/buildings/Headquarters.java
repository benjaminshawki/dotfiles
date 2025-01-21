package nl.duckstudios.pintandpillage.entity.buildings;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import javax.persistence.Entity;
import lombok.Getter;
import lombok.Setter;
import nl.duckstudios.pintandpillage.model.ResourceType;

@Entity
public class Headquarters extends Building implements IStorable, IPopulatable {

  @Getter @Setter public String name = "Headquarters";

  @Setter @Getter private int moralePerHour;

  @Setter private int populationCapacity;
  @Setter private int resourceCapacity = 750;
  @Setter @Getter private LocalDateTime lastTimeMoralUpped;

  public Headquarters() {
    this.updateBuilding();
    super.setDescription("The main building of the village");
  }

  @Override
  public void updateBuilding() {
    super.setConstructionTimeSeconds(
        30 + ((45 + (super.getLevel() - 1) * 2L) * (long) Math.pow(super.getLevel(), 1.75)));
    this.populationCapacity = (super.getLevel() * 5) + 40;
    this.moralePerHour = super.getLevel() + 1;
    super.setResourcesRequiredLevelUp(
        new HashMap<>() {
          {
            int level = Headquarters.super.getLevel();
            put(ResourceType.Stone.name(), (level * 25 + 25) * 25);
            put(ResourceType.Wood.name(), (int) ((level * 20 + 20) * level * 0.5));
          }
        });
  }

  @Override
  public int getPopulationCapacity() {
    return this.populationCapacity;
  }

  @Override
  public int getPopulationRequired(int level) {
    return (12 + (int) Math.pow(6, super.getLevel() * 0.2)) * super.getLevel();
  }

  @Override
  public int getResourceCapacity() {
    return resourceCapacity;
  }

  @Override
  protected void updateVillageState() {
    if (super.getVillage().getMorale() == 100) {
      this.lastTimeMoralUpped = LocalDateTime.now();
      return;
    }
    long hoursToCollect = ChronoUnit.MINUTES.between(this.lastTimeMoralUpped, LocalDateTime.now());
    int amountMoraleGained = (int) (hoursToCollect * this.moralePerHour);

    super.getVillage()
        .setMorale(Math.min(100, super.getVillage().getMorale() + amountMoraleGained));
    this.lastTimeMoralUpped = LocalDateTime.now();
  }
}
