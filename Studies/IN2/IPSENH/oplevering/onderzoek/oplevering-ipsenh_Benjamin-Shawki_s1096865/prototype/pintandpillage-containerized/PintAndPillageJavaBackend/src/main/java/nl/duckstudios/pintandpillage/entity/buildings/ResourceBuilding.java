package nl.duckstudios.pintandpillage.entity.buildings;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.Map;
import javax.persistence.Entity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import nl.duckstudios.pintandpillage.model.ResourceType;

@NoArgsConstructor
@Entity
public abstract class ResourceBuilding extends Building {

  @Getter @Setter private LocalDateTime lastCollected;

  @Setter @Getter private int resourcesPerHour;

  @Setter @Getter private ResourceType requiresResources = null;

  @Setter @Getter private ResourceType generatesResource;

  public void collectResources() {
    // This means the building is still under construction, so no resources are produced.
    if (lastCollected.isAfter(LocalDateTime.now())) {
      return;
    }

    int minutesInAHour = 60;
    double hoursToCollect =
        (double) ChronoUnit.MINUTES.between(this.lastCollected, LocalDateTime.now())
            / minutesInAHour;
    int resourcesGenerated = (int) (hoursToCollect * this.resourcesPerHour);

    if (resourcesGenerated == 0) {
      return;
    }

    if (this.requiresResources != null) {
      int resourcesOfRequiredType =
          super.getVillage().getVillageResources().get(this.requiresResources.name());
      resourcesGenerated = Math.min(resourcesOfRequiredType, resourcesGenerated);
      Map<String, Integer> resourcesMap = new HashMap<>();
      resourcesMap.put(this.requiresResources.name(), resourcesGenerated);
      super.resourceManager.subtractResources(super.getVillage(), resourcesMap);
    }

    super.resourceManager.addResources(
        super.getVillage(), resourcesGenerated, this.generatesResource.name());
    this.lastCollected = LocalDateTime.now();
  }

  @Override
  protected void updateVillageState() {
    if (super.getLevelupFinishedTime() != null) {
      this.lastCollected = getLevelupFinishedTime();
    }

    this.collectResources();
  }
}
