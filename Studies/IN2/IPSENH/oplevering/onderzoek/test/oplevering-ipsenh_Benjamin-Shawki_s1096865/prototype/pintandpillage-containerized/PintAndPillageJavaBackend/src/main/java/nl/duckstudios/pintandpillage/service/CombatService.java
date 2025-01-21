package nl.duckstudios.pintandpillage.service;

import java.util.ArrayList;
import java.util.List;
import nl.duckstudios.pintandpillage.Exceptions.AttackingConditionsNotMetException;
import nl.duckstudios.pintandpillage.entity.Village;
import nl.duckstudios.pintandpillage.entity.VillageUnit;
import nl.duckstudios.pintandpillage.entity.production.Scout;
import nl.duckstudios.pintandpillage.entity.production.ShipUnit;
import nl.duckstudios.pintandpillage.helper.UnitFactory;
import nl.duckstudios.pintandpillage.model.AttackUnitData;
import nl.duckstudios.pintandpillage.model.AttackVillageData;
import org.springframework.stereotype.Service;

@Service
public class CombatService {

  public List<VillageUnit> convertToVillageUnits(AttackVillageData data) {
    List<VillageUnit> attackingUnits = new ArrayList<>();

    for (AttackUnitData attackUnitData : data.units) {
      VillageUnit unitIntList =
          attackingUnits.stream()
              .filter(a -> a.getUnit().getUnitName() == attackUnitData.unitType)
              .findFirst()
              .orElse(null);
      if (unitIntList != null) {
        unitIntList.setAmount(unitIntList.getAmount() + attackUnitData.amount);
        continue;
      }

      VillageUnit villageUnit =
          new VillageUnit(
              UnitFactory.getUnitStatic(attackUnitData.unitType.name()), attackUnitData.amount);
      attackingUnits.add(villageUnit);
    }

    if (attackingUnits.size() == 0) {
      throw new AttackingConditionsNotMetException("To attack you need to send at least one unit");
    }

    return attackingUnits;
  }

  public void checkHasEnoughUnitsToAttack(
      List<VillageUnit> attackingUnits, Village attackingVillage) {
    for (VillageUnit attackingUnit : attackingUnits) {
      VillageUnit unitInVillage =
          attackingVillage.getUnitInVillage(attackingUnit.getUnit().getUnitName());
      if (unitInVillage == null
          || attackingUnit.getAmount() <= 0
          || attackingUnit.getAmount() > unitInVillage.getAmount()) {
        throw new AttackingConditionsNotMetException(
            "Not enough " + attackingUnit.getUnit().getUnitName() + " to attack this village");
      }

      attackingVillage
          .getUnitInVillage(attackingUnit.getUnit().getUnitName())
          .setAmount(unitInVillage.getAmount() - attackingUnit.getAmount());
    }
  }

  public void checkHasEnoughShipsToSendUnits(List<VillageUnit> villageUnits) {
    int totalShipCapacity =
        villageUnits.stream()
            .filter(u -> u.getUnit() instanceof ShipUnit)
            .mapToInt(s -> s.getAmount() * ((ShipUnit) s.getUnit()).getShipCapacity())
            .sum();

    int totalUnitCapacity =
        villageUnits.stream()
            .filter(u -> !(u.getUnit() instanceof Scout) && (u.getUnit() instanceof ShipUnit))
            .mapToInt(u -> u.getUnit().getPopulationRequiredPerUnit() * u.getAmount())
            .sum();

    if (totalShipCapacity < totalUnitCapacity) {
      throw new AttackingConditionsNotMetException("Not enough ship capacity for this attack");
    }
  }
}
