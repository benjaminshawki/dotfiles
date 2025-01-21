package nl.duckstudios.pintandpillage.entity.researching;

import java.time.LocalTime;
import java.util.HashMap;
import javax.persistence.Entity;
import nl.duckstudios.pintandpillage.model.ResearchType;
import nl.duckstudios.pintandpillage.model.ResourceType;

@Entity
public class DefenceShipResearch extends Research {

  public DefenceShipResearch() {
    super.setResearchName(ResearchType.DefenceShip);
    super.setBaseSecondsToResearch(18000);
    super.setBuildingLevelRequirement(12 + (super.getResearchLevel() * 3));
    super.setResourcesRequiredToResearch(
        new HashMap<>() {
          {
            int level = DefenceShipResearch.super.getResearchLevel();
            put(ResourceType.Wood.name(), 10000 * (level + 1));
            put(ResourceType.Stone.name(), 7000 * (level + 1));
            put(ResourceType.Beer.name(), 11000 * (level + 1));
          }
        });
    super.setSecondsToResearch(LocalTime.of(0, 0, 0).plusSeconds(super.getBaseSecondsToResearch()));
  }
}
