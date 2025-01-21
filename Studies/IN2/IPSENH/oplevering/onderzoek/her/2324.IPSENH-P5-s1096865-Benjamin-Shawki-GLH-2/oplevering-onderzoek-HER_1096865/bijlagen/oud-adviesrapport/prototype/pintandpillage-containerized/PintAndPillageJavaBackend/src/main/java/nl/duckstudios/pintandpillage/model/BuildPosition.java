package nl.duckstudios.pintandpillage.model;

import nl.duckstudios.pintandpillage.entity.Coord;

public class BuildPosition {

  public String name = "BuildingTile";

  public Coord position;

  public String allowedBuilding = null;

  public BuildPosition(int x, int y, String allowedBuilding) {
    this.position = new Coord(x, y);
    this.allowedBuilding = allowedBuilding;
  }

  public BuildPosition(int x, int y) {
    this.position = new Coord(x, y);
  }
}
