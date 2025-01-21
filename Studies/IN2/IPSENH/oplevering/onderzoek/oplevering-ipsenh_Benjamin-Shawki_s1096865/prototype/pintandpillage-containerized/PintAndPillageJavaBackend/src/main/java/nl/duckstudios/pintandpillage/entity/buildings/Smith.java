package nl.duckstudios.pintandpillage.entity.buildings;

import java.util.HashMap;
import javax.persistence.Entity;
import lombok.Getter;
import lombok.Setter;
import nl.duckstudios.pintandpillage.model.ResourceType;

@Entity
public class Smith extends ResearchBuilding {

  @Getter @Setter public String name = "Smith";

  public Smith() {
    super.setDescription("A building to research new units and ships");
    this.updateBuilding();
  }

  @Override
  public void updateBuilding() {
    super.setConstructionTimeSeconds(5);
    super.setResourcesRequiredLevelUp(
        new HashMap<>() {
          {
            int level = Smith.super.getLevel();
            put(ResourceType.Wood.name(), 1000 + 60 * level);
            put(ResourceType.Stone.name(), 150 + 50 * level);
          }
        });
  }
}
