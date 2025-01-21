package nl.duckstudios.pintandpillage.entity.travels;

import com.fasterxml.jackson.annotation.JsonIgnore;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import lombok.Getter;
import lombok.Setter;
import nl.duckstudios.pintandpillage.entity.Village;
import nl.duckstudios.pintandpillage.model.UnitType;

@Entity
public class AttackCombatTravel extends CombatTravel {

  @JsonIgnore @Setter @Getter @ManyToOne private Village attackingVillage;

  @JsonIgnore @Setter @Getter @ManyToOne private Village defendingVillage;

  public AttackCombatTravel() {}

  public boolean isJarlAttack() {
    return super.getTravelingUnits().stream()
            .filter(u -> u.getUnit().unitName == UnitType.Jarl && u.getAmount() > 0)
            .findFirst()
            .orElse(null)
        != null;
  }
}
