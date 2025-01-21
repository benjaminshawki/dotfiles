package nl.duckstudios.pintandpillage.entity.buildings;

import java.util.HashMap;
import javax.persistence.Entity;
import lombok.Getter;
import lombok.Setter;
import nl.duckstudios.pintandpillage.model.ResourceType;

@Entity
public class DefenceTower extends Building implements IDefenceable {

  @Getter @Setter public String name = "DefenceTower";

  @Setter private int defenceBonus;

  public DefenceTower() {
    this.updateBuilding();
    super.setDescription(
        "A tower that will increase your village defence and help detect enemy scouts");
  }

  @Override
  public void updateBuilding() {
    super.setConstructionTimeSeconds(
        12 + ((30 + (super.getLevel() - 1) * 2L) * (long) Math.pow(super.getLevel(), 1.6)));
    this.defenceBonus = 100 + 75 * super.getLevel();
    super.setResourcesRequiredLevelUp(
        new HashMap<>() {
          {
            int level = DefenceTower.super.getLevel();
            put(ResourceType.Wood.name(), 300 + (int) Math.pow(50, level * 0.2));
            put(ResourceType.Stone.name(), 300 + (int) Math.pow(125, level * 0.2));
            put(ResourceType.Beer.name(), 100 + (int) Math.pow(25, level * 0.2));
          }
        });
  }

  @Override
  public int getPopulationRequired(int level) {
    return super.getLevel() == 0 ? 50 : 0;
  }

  @Override
  public int getDefenceBonus() {
    return this.defenceBonus;
  }
}
