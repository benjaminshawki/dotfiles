package nl.duckstudios.pintandpillage.helper;

import nl.duckstudios.pintandpillage.Exceptions.NotExistingEntityException;
import nl.duckstudios.pintandpillage.entity.production.*;
import org.springframework.stereotype.Component;

@Component
public class UnitFactory {

  public static Unit getUnitStatic(String unitType) {
    return new UnitFactory().getUnit(unitType);
  }

  public Unit getUnit(String unitType) {
    return switch (unitType) {
      case "Spear" -> new Spear();
      case "Axe" -> new Axe();
      case "Bow" -> new Bow();
      case "Shield" -> new Shield();
      case "Jarl" -> new Jarl();
      case "TransportShip" -> new TransportShip();
      case "BattleShip" -> new BattleShip();
      case "DefenceShip" -> new DefenceShip();
      default -> throw new NotExistingEntityException(unitType + " is not an existing unit");
    };
  }
}
