package nl.duckstudios.pintandpillage.entity.researching;

import java.time.LocalTime;
import java.util.HashMap;
import javax.persistence.Entity;
import nl.duckstudios.pintandpillage.model.ResearchType;
import nl.duckstudios.pintandpillage.model.ResourceType;

@Entity
public class AxeResearch extends Research {

  public AxeResearch() {
    super.setResearchName(ResearchType.Axe);
    super.setBaseSecondsToResearch(7200);
    super.setBuildingLevelRequirement(3 + (super.getResearchLevel() * 2));
    super.setResourcesRequiredToResearch(
        new HashMap<>() {
          {
            int level = AxeResearch.super.getResearchLevel();
            put(ResourceType.Wood.name(), 1200 * (level + 1));
            put(ResourceType.Stone.name(), 1200 * (level + 1));
            put(ResourceType.Beer.name(), 1200 * (level + 1));
          }
        });
    super.setSecondsToResearch(LocalTime.of(0, 0, 0).plusSeconds(super.getBaseSecondsToResearch()));
  }
}
