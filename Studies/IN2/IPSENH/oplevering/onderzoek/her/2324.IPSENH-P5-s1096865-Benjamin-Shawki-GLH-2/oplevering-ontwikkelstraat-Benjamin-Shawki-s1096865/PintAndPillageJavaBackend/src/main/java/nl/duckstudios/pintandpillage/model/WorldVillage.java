package nl.duckstudios.pintandpillage.model;

import nl.duckstudios.pintandpillage.entity.Coord;

public class WorldVillage {
  public long villageId;

  public String villageOwnerName;

  public Coord position;

  public String name;

  public int points;

  public long userId;

  public WorldVillage(
      long villageId,
      String villageOwnerName,
      Coord position,
      String name,
      long userId,
      int points) {
    this.villageId = villageId;
    this.villageOwnerName = villageOwnerName;
    this.position = position;
    this.name = name;
    this.userId = userId;
    this.points = points;
  }
}
