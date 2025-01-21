package nl.duckstudios.pintandpillage.entity.researching;

import java.time.LocalTime;
import java.util.HashMap;
import javax.persistence.Entity;
import nl.duckstudios.pintandpillage.model.ResearchType;
import nl.duckstudios.pintandpillage.model.ResourceType;

@Entity
public class ShieldResearch extends Research {

  public ShieldResearch() {
    super.setResearchName(ResearchType.Shield);
    super.setBaseSecondsToResearch(11800);
    super.setBuildingLevelRequirement(5 + (super.getResearchLevel() * 2));
    super.setResourcesRequiredToResearch(
        new HashMap<>() {
          {
            int level = ShieldResearch.super.getResearchLevel();
            put(ResourceType.Wood.name(), 2200 * (level + 1));
            put(ResourceType.Stone.name(), 2200 * (level + 1));
            put(ResourceType.Beer.name(), 2200 * (level + 1));
          }
        });
    super.setSecondsToResearch(LocalTime.of(0, 0, 0).plusSeconds(super.getBaseSecondsToResearch()));
  }
}
