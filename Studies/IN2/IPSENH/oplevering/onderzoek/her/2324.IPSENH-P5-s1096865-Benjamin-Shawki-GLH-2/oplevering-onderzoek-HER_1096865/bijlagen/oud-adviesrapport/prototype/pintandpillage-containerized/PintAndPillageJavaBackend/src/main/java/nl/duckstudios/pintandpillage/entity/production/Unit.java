package nl.duckstudios.pintandpillage.entity.production;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import java.time.LocalTime;
import java.util.Map;
import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;
import nl.duckstudios.pintandpillage.model.ResearchType;
import nl.duckstudios.pintandpillage.model.UnitType;

@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
public class Unit {
  @Getter public UnitType unitName;
  @Getter public int attack;
  @Getter public int defence;
  @Getter public int health;
  @Getter public int speed;
  @Getter public String description;
  @Getter public int populationRequiredPerUnit;
  @Getter public long baseSecondsToProduce;

  @Getter @Setter public int plunderAmount;

  @Getter @Transient @JsonDeserialize @JsonSerialize
  public Map<String, Integer> resourcesRequiredToProduce;

  @Id @GeneratedValue private long id;
  @Getter @Setter private ResearchType researchRequired;
  @Getter @Setter private LocalTime baseTimeToProduce;
}
