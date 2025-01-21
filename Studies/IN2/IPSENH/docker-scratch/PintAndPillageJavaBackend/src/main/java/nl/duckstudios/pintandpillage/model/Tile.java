package nl.duckstudios.pintandpillage.model;

public class Tile {
  public TileType tileType;
  public int x;
  public int y;

  public Tile(TileType tileType, int x, int y) {
    this.tileType = tileType;
    this.x = x;
    this.y = y;
  }
}
