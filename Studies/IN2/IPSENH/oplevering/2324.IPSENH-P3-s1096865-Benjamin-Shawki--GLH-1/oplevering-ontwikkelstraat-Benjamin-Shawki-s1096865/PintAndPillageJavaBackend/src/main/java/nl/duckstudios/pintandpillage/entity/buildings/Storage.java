package nl.duckstudios.pintandpillage.entity.buildings;

import java.util.HashMap;
import javax.persistence.Entity;
import lombok.Getter;
import lombok.Setter;
import nl.duckstudios.pintandpillage.model.ResourceType;

@Entity
public class Storage extends Building implements IStorable {

  @Getter @Setter public String name = "Storage";

  @Setter private int resourceCapacity = 0;

  public Storage() {
    super.setDescription("A building that increases your storage capacity");
    this.updateBuilding();
  }

  @Override
  public int getResourceCapacity() {
    return this.resourceCapacity;
  }

  @Override
  public void updateBuilding() {
    super.setConstructionTimeSeconds(5 + 30L * super.getLevel() + 1);
    this.resourceCapacity = 600 + 2500 * super.getLevel() + 1;
    super.setResourcesRequiredLevelUp(
        new HashMap<>() {
          {
            int level = Storage.super.getLevel();
            put(ResourceType.Stone.name(), ((level + 1) * 25) * 25);
          }
        });
  }
}
