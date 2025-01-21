package nl.duckstudios.pintandpillage.entity.buildings;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import javax.persistence.Entity;
import javax.persistence.Transient;
import lombok.Getter;
import lombok.Setter;
import nl.duckstudios.pintandpillage.model.ResourceType;
import nl.duckstudios.pintandpillage.model.UnitType;
import nl.duckstudios.pintandpillage.model.Unlock;

@Entity
public class Harbor extends ProductionBuilding {

  @Getter @Setter public String name = "Harbor";

  @Getter @Setter @Transient
  private Map<String, Integer> buildingLevelRequiredToLevelup =
      new HashMap<>() {
        {
          put("Headquarters", 10);
          put("Lumberyard", 10);
          put("Smith", 8);
        }
      };

  public Harbor() {
    this.createUnitsUnlockedAtLevelList();
    super.updateUnlockedUnitsData();
    super.setDescription("A building used to build new ships");
    this.updateBuilding();
  }

  private void createUnitsUnlockedAtLevelList() {
    super.setUnitsUnlockedAtLevel(
        new ArrayList<>(Arrays.asList(new Unlock(UnitType.TransportShip, 1))));
  }

  @Override
  public void updateBuilding() {
    super.setConstructionTimeSeconds(5);
    //        super.setConstructionTimeSeconds((long) (250 + 100 * Math.pow(super.getLevel(),
    // 1.2)));
    super.setQueueLimit(2);
    super.setResourcesRequiredLevelUp(
        new HashMap<>() {
          {
            int level = Harbor.super.getLevel();
            put(ResourceType.Wood.name(), 200 + 15 * level * level);
            put(ResourceType.Stone.name(), 400 + 12 * level * level);
            put(ResourceType.Beer.name(), 250 + 11 * level * level);
          }
        });
    super.checkProduction();
  }
}
