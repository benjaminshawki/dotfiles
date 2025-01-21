package nl.duckstudios.pintandpillage.entity.researching;

import java.time.LocalTime;
import java.util.HashMap;
import javax.persistence.Entity;
import nl.duckstudios.pintandpillage.model.ResearchType;
import nl.duckstudios.pintandpillage.model.ResourceType;

@Entity
public class BattleShipResearch extends Research {

  public BattleShipResearch() {
    super.setResearchName(ResearchType.BattleShip);
    super.setBaseSecondsToResearch(20000);
    super.setBuildingLevelRequirement(10 + (super.getResearchLevel() * 2));
    super.setResourcesRequiredToResearch(
        new HashMap<>() {
          {
            int level = BattleShipResearch.super.getResearchLevel();
            put(ResourceType.Wood.name(), 8000 * (level + 1));
            put(ResourceType.Stone.name(), 8000 * (level + 1));
            put(ResourceType.Beer.name(), 8000 * (level + 1));
          }
        });
    super.setSecondsToResearch(LocalTime.of(0, 0, 0).plusSeconds(super.getBaseSecondsToResearch()));
  }
}
