package nl.duckstudios.pintandpillage.model;

public class AttackUnitData {

  public UnitType unitType;
  public int amount;

  public AttackUnitData(UnitType unitType, int amount) {
    this.unitType = unitType;
    this.amount = amount;
  }
}
