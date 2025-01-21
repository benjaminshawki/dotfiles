package nl.duckstudios.pintandpillage.helper;

import nl.duckstudios.pintandpillage.Exceptions.NotExistingEntityException;
import nl.duckstudios.pintandpillage.entity.researching.*;
import org.springframework.stereotype.Component;

@Component
public class ResearchFactory {

  public Research getResearch(String researchType) {
    return switch (researchType) {
      case "Spear" -> new SpearResearch();
      case "Axe" -> new AxeResearch();
      case "Bow" -> new BowResearch();
      case "BattleShip" -> new BattleShipResearch();
      case "DefenceShip" -> new DefenceShipResearch();
      case "Jarl" -> new JarlResearch();
      default -> throw new NotExistingEntityException("No research for this type");
    };
  }
}
