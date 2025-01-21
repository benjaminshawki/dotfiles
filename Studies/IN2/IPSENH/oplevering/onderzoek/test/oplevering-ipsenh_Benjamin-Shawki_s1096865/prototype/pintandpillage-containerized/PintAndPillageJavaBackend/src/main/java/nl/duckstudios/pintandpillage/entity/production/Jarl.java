package nl.duckstudios.pintandpillage.entity.production;

import java.time.LocalTime;
import java.util.HashMap;
import javax.persistence.Entity;
import lombok.Getter;
import lombok.Setter;
import nl.duckstudios.pintandpillage.model.ResearchType;
import nl.duckstudios.pintandpillage.model.ResourceType;
import nl.duckstudios.pintandpillage.model.UnitType;

@Entity
public class Jarl extends Unit {

  @Setter @Getter public ResearchType researchRequired = ResearchType.Jarl;
  @Setter @Getter private long baseSecondsToProduce = 5;
  @Setter @Getter private UnitType unitName = UnitType.Jarl;
  @Setter @Getter private int attack = 15;
  @Setter @Getter private int defence = 15;
  @Setter @Getter private int health = 20;
  @Setter @Getter private int speed = 10;
  @Setter @Getter private int plunderAmount = 0;
  @Setter @Getter private String description = "A branded leader ready to create new settlements";
  @Setter @Getter private int populationRequiredPerUnit = 1;

  public Jarl() {
    LocalTime localTime = LocalTime.of(0, 0, 0);
    localTime = localTime.plusSeconds(this.baseSecondsToProduce);
    super.setBaseTimeToProduce(localTime);
    super.resourcesRequiredToProduce =
        new HashMap<>() {
          {
            put(ResourceType.Wood.name(), 15);
            put(ResourceType.Beer.name(), 15);
          }
        };
  }
}
