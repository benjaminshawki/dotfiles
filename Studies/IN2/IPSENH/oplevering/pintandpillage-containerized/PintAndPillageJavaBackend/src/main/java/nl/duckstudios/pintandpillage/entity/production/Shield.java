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
public class Shield extends Unit {

  @Setter @Getter public ResearchType researchRequired = ResearchType.Shield;
  @Setter @Getter private long baseSecondsToProduce = 610;
  @Setter @Getter private UnitType unitName = UnitType.Shield;
  @Setter @Getter private int attack = 5;
  @Setter @Getter private int defence = 50;
  @Setter @Getter private int health = 40;
  @Setter @Getter private int speed = 5;
  @Setter @Getter private int plunderAmount = 0;

  @Setter @Getter
  private String description =
      "Great defensive unit that carries a large rounded shield and a small axe";

  @Setter @Getter private int populationRequiredPerUnit = 1;

  public Shield() {
    LocalTime localTime = LocalTime.of(0, 0, 0);
    localTime = localTime.plusSeconds(this.baseSecondsToProduce);
    super.setBaseTimeToProduce(localTime);
    super.resourcesRequiredToProduce =
        new HashMap<>() {
          {
            put(ResourceType.Wood.name(), 20);
            put(ResourceType.Beer.name(), 50);
            put(ResourceType.Stone.name(), 50);
          }
        };
  }
}
