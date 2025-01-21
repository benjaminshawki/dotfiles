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
public class Barracks extends ProductionBuilding {

  @Getter @Setter public String name = "Barracks";

  @Getter @Setter @Transient
  private Map<String, Integer> buildingLevelRequiredToLevelup =
      new HashMap<>() {
        {
          put("Headquarters", 5);
        }
      };

  public Barracks() {
    this.createUnitsUnlockedAtLevelList();
    super.updateUnlockedUnitsData();
    super.setDescription("A building used to train new units");
    this.updateBuilding();
  }

  private void createUnitsUnlockedAtLevelList() {
    super.setUnitsUnlockedAtLevel(
        new ArrayList<>(
            Arrays.asList(
                new Unlock(UnitType.Spear, 1),
                new Unlock(UnitType.Axe, 4),
                new Unlock(UnitType.Shield, 8),
                new Unlock(UnitType.Bow, 13),
                new Unlock(UnitType.Jarl, 10))));
  }

  public float getProductionSpeed() {
    return 1 + 0.1f * super.getLevel();
  }

  @Override
  public void updateBuilding() {
    super.setConstructionTimeSeconds(
        120 + ((40 + (super.getLevel() - 1) * 2L) * (long) Math.pow(super.getLevel(), 1.7)));
    super.setQueueLimit(5);
    super.setResourcesRequiredLevelUp(
        new HashMap<>() {
          {
            int level = Barracks.super.getLevel();
            put(ResourceType.Wood.name(), 1000 + 25 * level + 8 * level * level);
            put(ResourceType.Stone.name(), 800 + 20 * level + 6 * level * level);
          }
        });
    super.checkProduction();
  }
}
