package nl.duckstudios.pintandpillage.entity.buildings;

import java.util.HashMap;
import javax.persistence.Entity;
import lombok.Getter;
import lombok.Setter;
import nl.duckstudios.pintandpillage.model.ResourceType;

@Entity
public class Tavern extends ResourceBuilding {

  @Getter @Setter public String name = "Tavern";

  public Tavern() {
    this.updateBuilding();
    super.setDescription("Produces beer for your village at the cost of hop");
    super.setGeneratesResource(ResourceType.Beer);
    super.setRequiresResources(ResourceType.Hop);
  }

  //    private int updateResourcesPerHour() {
  //        return (int)(10 + 6 * Math.pow(super.getLevel(), 1.15));
  //    }
  private int updateResourcesPerHour() {
    return 300;
  }

  @Override
  public void updateBuilding() {
    super.setConstructionTimeSeconds(
        12 + ((30 + (super.getLevel() - 1) * 2L) * (long) Math.pow(super.getLevel(), 1.6)));
    super.setResourcesPerHour(this.updateResourcesPerHour());
    super.setResourcesRequiredLevelUp(
        new HashMap<>() {
          {
            int level = Tavern.super.getLevel();
            put(ResourceType.Stone.name(), level * 25 + 25);
          }
        });
  }
}
