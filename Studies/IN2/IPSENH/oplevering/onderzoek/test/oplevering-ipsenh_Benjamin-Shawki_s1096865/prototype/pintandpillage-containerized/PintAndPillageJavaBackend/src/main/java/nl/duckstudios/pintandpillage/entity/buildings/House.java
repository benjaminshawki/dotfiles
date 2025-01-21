package nl.duckstudios.pintandpillage.entity.buildings;

import java.util.HashMap;
import javax.persistence.Entity;
import lombok.Getter;
import lombok.Setter;
import nl.duckstudios.pintandpillage.model.ResourceType;

@Entity
public class House extends Building implements IPopulatable {
  @Getter @Setter public String name = "House";

  @Getter @Setter private int populationRequiredNextLevel = 0;

  @Setter private int populationCapacity = 0;

  public House() {
    this.updateBuilding();
    super.setDescription("A building that increases your village population");
  }

  @Override
  public int getPopulationCapacity() {
    return this.populationCapacity;
  }

  public void updateBuilding() {
    this.populationCapacity =
        super.getLevel() == 0
            ? 0
            : (int)
                (8 * (super.getLevel() * super.getLevel()) + 10 * Math.pow(1.32, super.getLevel()));
    super.setResourcesRequiredLevelUp(
        new HashMap<>() {
          {
            int level = House.super.getLevel();
            put(ResourceType.Wood.name(), 10 + 25 * level + 8 * level * level);
            put(ResourceType.Stone.name(), 8 + 20 * level + 6 * level * level);
          }
        });
    super.setConstructionTimeSeconds(
        12 + ((30 + (super.getLevel() - 1) * 2L) * (long) Math.pow(super.getLevel(), 1.6)));
  }

  @Override
  public int getPopulationRequired(int level) {
    return 0;
  }
}
