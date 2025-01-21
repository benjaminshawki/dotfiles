package nl.duckstudios.pintandpillage.entity.researching;

import com.fasterxml.jackson.annotation.JsonBackReference;
import java.time.LocalTime;
import java.util.Map;
import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;
import nl.duckstudios.pintandpillage.entity.Village;
import nl.duckstudios.pintandpillage.model.ResearchType;

@Entity
public class Research {

  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private long id;

  @Getter @Setter private ResearchType researchName;

  @Getter @Setter private int researchLevel = 0;

  @Getter @Setter private long baseSecondsToResearch;

  @Getter @Setter private LocalTime secondsToResearch;

  @Getter @Setter private int buildingLevelRequirement;

  @Getter @Setter @ElementCollection private Map<String, Integer> resourcesRequiredToResearch;

  @Getter
  @Setter
  @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
  @JsonBackReference
  private Village village;

  public Research() {}
}
