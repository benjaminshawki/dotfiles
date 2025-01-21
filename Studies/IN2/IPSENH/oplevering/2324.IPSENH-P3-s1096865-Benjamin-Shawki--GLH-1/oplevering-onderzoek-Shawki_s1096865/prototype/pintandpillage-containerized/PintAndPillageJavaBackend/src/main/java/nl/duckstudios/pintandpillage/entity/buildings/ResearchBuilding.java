package nl.duckstudios.pintandpillage.entity.buildings;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.OneToOne;
import lombok.Getter;
import lombok.Setter;
import nl.duckstudios.pintandpillage.Exceptions.ResearchConditionsNotMetException;
import nl.duckstudios.pintandpillage.entity.researching.Research;

@Entity
public abstract class ResearchBuilding extends Building {

  @Getter
  @Setter
  @OneToOne(cascade = CascadeType.ALL)
  private Research currentResearch;

  @Getter @Setter private LocalDateTime currentResearchFinishTime = null;

  @Getter @Setter private LocalTime researchTimeLeft = null;

  @Getter
  @Setter
  @JsonProperty("isResearchInProgress")
  private boolean isResearchInProgress;

  public ResearchBuilding() {}

  public void startResearch(Research research) {
    this.checkIsAbaleToStartResearch(research);
    this.currentResearch = research;
    research.setVillage(super.getVillage());
    this.isResearchInProgress = true;
    this.currentResearchFinishTime =
        LocalDateTime.now().plusSeconds(research.getBaseSecondsToResearch());
    long secondsForLocalTimeConversion =
        ChronoUnit.SECONDS.between(LocalDateTime.now(), this.currentResearchFinishTime);
    this.researchTimeLeft = (LocalTime.of(0, 0, 0).plusSeconds(secondsForLocalTimeConversion));
    super.resourceManager.subtractResources(
        super.getVillage(), research.getResourcesRequiredToResearch());
  }

  private void checkIsAbaleToStartResearch(Research research) {
    if (this.isResearchInProgress) {
      throw new ResearchConditionsNotMetException("A research is already in progress");
    }

    if (!super.resourceManager.hasEnoughResourcesAvailable(
        super.getVillage(), research.getResourcesRequiredToResearch())) {
      throw new ResearchConditionsNotMetException("Not enough resources available");
    }

    if (super.getLevel() < research.getBuildingLevelRequirement()) {
      throw new ResearchConditionsNotMetException("Research building level is not high enough");
    }
  }

  @Override
  protected void updateVillageState() {
    if (!this.isResearchInProgress) {
      return;
    }

    if (LocalDateTime.now().isAfter(this.currentResearchFinishTime)) {
      if (this.currentResearch.getResearchLevel() == 0) {
        super.getVillage().addCompleteResearch(this.currentResearch);
      }
      this.isResearchInProgress = false;
      this.currentResearch.setResearchLevel(this.currentResearch.getResearchLevel() + 1);
      this.researchTimeLeft = null;

      super.getVillage()
          .addToVillageLog(
              LocalDateTime.now(),
              "Finished "
                  + this.currentResearch.getResearchName()
                  + " research to level "
                  + this.currentResearch.getResearchLevel());
      this.currentResearch = null;
      this.currentResearchFinishTime = null;
    }
  }
}
