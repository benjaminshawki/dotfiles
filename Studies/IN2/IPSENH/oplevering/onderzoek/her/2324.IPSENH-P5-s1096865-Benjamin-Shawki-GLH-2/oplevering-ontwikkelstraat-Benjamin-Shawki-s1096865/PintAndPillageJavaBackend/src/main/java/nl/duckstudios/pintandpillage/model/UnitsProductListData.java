package nl.duckstudios.pintandpillage.model;

import nl.duckstudios.pintandpillage.entity.production.Unit;

public class UnitsProductListData {
  public Unit unit;

  public int levelUnlocked;

  public UnitsProductListData(Unit unit, int levelUnlocked) {
    this.unit = unit;
    this.levelUnlocked = levelUnlocked;
  }
}
