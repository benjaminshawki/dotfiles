package nl.duckstudios.pintandpillage.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;
import nl.duckstudios.pintandpillage.entity.production.Unit;
import nl.duckstudios.pintandpillage.entity.travels.CombatTravel;

@Entity
@Table(name = "VillageUnit")
public class VillageUnit {

  @Getter @Setter @Id @GeneratedValue private long id;

  @Getter
  @Setter
  @ManyToOne(cascade = CascadeType.ALL)
  @JsonBackReference
  private Village village;

  @Getter
  @Setter
  @ManyToOne(cascade = CascadeType.ALL)
  @JsonBackReference
  private CombatTravel combatTravel;

  @Getter
  @Setter
  @OneToOne(cascade = CascadeType.ALL)
  private Unit unit;

  @Getter @Setter private int amount;

  public VillageUnit(Unit unit, int amount) {
    this.amount = amount;
    this.unit = unit;
  }

  public VillageUnit() {}
}
