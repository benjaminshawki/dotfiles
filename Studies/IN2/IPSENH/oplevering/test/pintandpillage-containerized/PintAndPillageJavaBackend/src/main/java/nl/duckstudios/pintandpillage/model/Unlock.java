package nl.duckstudios.pintandpillage.model;

public class Unlock {
  public UnitType unitType;

  public int level;

  public Unlock(UnitType unitType, int level) {
    this.unitType = unitType;
    this.level = level;
  }
}
