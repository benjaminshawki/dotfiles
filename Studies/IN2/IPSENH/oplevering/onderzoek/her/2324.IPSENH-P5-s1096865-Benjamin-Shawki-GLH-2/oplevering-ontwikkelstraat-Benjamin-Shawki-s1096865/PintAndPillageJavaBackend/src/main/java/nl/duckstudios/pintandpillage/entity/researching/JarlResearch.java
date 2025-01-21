package nl.duckstudios.pintandpillage.entity.researching;

import java.time.LocalTime;
import java.util.HashMap;
import javax.persistence.Entity;
import nl.duckstudios.pintandpillage.model.ResearchType;
import nl.duckstudios.pintandpillage.model.ResourceType;

@Entity
public class JarlResearch extends Research {

  public JarlResearch() {
    super.setResearchName(ResearchType.Jarl);
    super.setBaseSecondsToResearch(5);
    super.setBuildingLevelRequirement(1 + (super.getResearchLevel() * 3));
    super.setResourcesRequiredToResearch(
        new HashMap<>() {
          {
            int level = JarlResearch.super.getResearchLevel();
            put(ResourceType.Wood.name(), 10 * (level + 1));
            put(ResourceType.Stone.name(), 10 * (level + 1));
            put(ResourceType.Beer.name(), 10 * (level + 1));
          }
        });
    super.setSecondsToResearch(LocalTime.of(0, 0, 0).plusSeconds(super.getBaseSecondsToResearch()));
  }
}
