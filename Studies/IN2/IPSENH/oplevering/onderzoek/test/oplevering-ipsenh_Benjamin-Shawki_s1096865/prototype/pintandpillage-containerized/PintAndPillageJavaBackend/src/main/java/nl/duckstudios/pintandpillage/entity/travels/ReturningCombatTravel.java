package nl.duckstudios.pintandpillage.entity.travels;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import java.util.HashMap;
import java.util.Map;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import lombok.Getter;
import lombok.Setter;
import nl.duckstudios.pintandpillage.entity.Village;

@Entity
public class ReturningCombatTravel extends CombatTravel {

  @Getter @Setter @ElementCollection @JsonManagedReference
  private Map<String, Integer> pillagedResources = new HashMap<>();

  @JsonIgnore
  @Setter
  @Getter
  @ManyToOne(fetch = FetchType.EAGER)
  private Village returningToVillage;
}
