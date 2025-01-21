package nl.duckstudios.pintandpillage.model;

import java.util.ArrayList;
import java.util.List;
import nl.duckstudios.pintandpillage.entity.Coord;

public class SettleableSpots {

  public int amountOfJarlsNeeded;
  public List<Coord> validPositions;

  public SettleableSpots() {
    this.validPositions = new ArrayList<>();
  }
}
