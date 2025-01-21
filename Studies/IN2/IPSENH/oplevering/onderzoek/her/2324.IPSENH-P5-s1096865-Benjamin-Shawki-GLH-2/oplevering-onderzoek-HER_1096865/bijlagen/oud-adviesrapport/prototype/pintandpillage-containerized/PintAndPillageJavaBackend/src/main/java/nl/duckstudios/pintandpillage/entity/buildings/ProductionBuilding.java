package nl.duckstudios.pintandpillage.entity.buildings;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;
import nl.duckstudios.pintandpillage.Exceptions.BuildingConditionsNotMetException;
import nl.duckstudios.pintandpillage.Exceptions.ProductionConditionsNotMetException;
import nl.duckstudios.pintandpillage.entity.production.Unit;
import nl.duckstudios.pintandpillage.entity.production.UnitProductionItem;
import nl.duckstudios.pintandpillage.helper.UnitFactory;
import nl.duckstudios.pintandpillage.model.ResearchType;
import nl.duckstudios.pintandpillage.model.UnitsProductListData;
import nl.duckstudios.pintandpillage.model.Unlock;

@Entity
public abstract class ProductionBuilding extends Building {

  @Getter
  @Setter
  @OneToMany(mappedBy = "productionBuilding", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
  @JsonManagedReference
  private List<UnitProductionItem> productionQueue = new ArrayList<>();

  @Getter @Setter private int queueLimit;

  @Getter @Setter private LocalDateTime lastCollected = null;

  @Getter @Setter private float lastCollectedTimeLeft = 0;

  @Getter @Setter @Transient @JsonSerialize @JsonDeserialize
  private List<Unlock> unitsUnlockedAtLevel;

  @Getter @Setter @Transient @JsonSerialize @JsonDeserialize
  private List<UnitsProductListData> unlockedUnitsData;

  @Getter @Setter private int populationInProduction;

  @Getter @Setter private float productionSpeed = 1;

  @Getter @Setter private boolean _hasNotCollected = false;

  public ProductionBuilding() {}

  public void produceUnit(Unit unit, int amount) {
    this.checkAllowedToProduce(unit, amount);

    UnitProductionItem unitProductionItem = new UnitProductionItem(unit, amount);
    unitProductionItem.setProductionBuilding(this);

    this.addToQueue(unitProductionItem);
    super.resourceManager.subtractResources(
        super.getVillage(), unit.getResourcesRequiredToProduce());
  }

  public void checkProduction() {
    this.collectProduction();
    this.updateUnlockedUnitsData();
  }

  private void checkAllowedToProduce(Unit unit, int amount) {
    if (!this.isAllowedToBuildUnit(unit)) {
      throw new ProductionConditionsNotMetException("Building can't produce unit");
    }
    if (unit.getResearchRequired() != ResearchType.None && !this.hasCompletedResearch(unit)) {
      throw new ProductionConditionsNotMetException("Unit not researched");
    }
    if (!super.getVillage().hasEnoughPopulation(unit.populationRequiredPerUnit, amount)) {
      throw new ProductionConditionsNotMetException("Not enough population");
    }
    if (!super.resourceManager.hasEnoughResourcesAvailable(
        super.getVillage(), unit.getResourcesRequiredToProduce(), amount)) {
      throw new ProductionConditionsNotMetException("Not enough resources for all the units");
    }
  }

  private void addToQueue(UnitProductionItem itemToAdd) {
    if (this.productionQueue.size() > this.queueLimit) {
      throw new BuildingConditionsNotMetException("The production queue is full");
    }
    this.productionQueue.add(itemToAdd);
  }

  private boolean hasCompletedResearch(Unit unitData) {
    return super.getVillage().getCompletedResearches().stream()
        .anyMatch(
            v -> v.getResearchName() == unitData.getResearchRequired() && v.getResearchLevel() > 0);
  }

  private boolean isAllowedToBuildUnit(Unit unitData) {
    return this.unitsUnlockedAtLevel.stream()
        .anyMatch(u -> super.getLevel() >= u.level && unitData.getUnitName() == u.unitType);
  }

  private void collectProduction() {
    if (this.lastCollected == null) {
      this.lastCollected = LocalDateTime.now();
    }

    double secondsProduced =
        (double) ChronoUnit.SECONDS.between(this.lastCollected, LocalDateTime.now())
            + this.lastCollectedTimeLeft;
    this.lastCollected = LocalDateTime.now();

    while (this.productionQueue.size() > 0) {
      UnitProductionItem unit = this.getFirstItemFromQueue();
      float actualProductionTime = unit.getSecondsToProduce() * 1 / this.productionSpeed;
      int amountThatCanBeProduced =
          (int) Math.min(secondsProduced / actualProductionTime, unit.getAmountToProduce());

      secondsProduced -= amountThatCanBeProduced * actualProductionTime;

      unit.produce(super.getVillage(), amountThatCanBeProduced);

      if (unit.getAmountToProduce() <= 0) {
        super.getVillage()
            .addToCombatLog(
                LocalDateTime.now(), "Finished producing " + unit.getUnitToProduce().getUnitName());
        this.productionQueue.remove(unit);
        unit.setProductionBuilding(null);
      } else {
        this.lastCollectedTimeLeft = (float) secondsProduced;
        return;
      }
    }
    this.lastCollectedTimeLeft = 0;
  }

  private UnitProductionItem getFirstItemFromQueue() {
    UnitProductionItem result =
        this.productionQueue.stream()
            .parallel()
            .min(Comparator.comparing(UnitProductionItem::getStartTime))
            .orElse(null);
    return result;
  }

  protected void updateUnlockedUnitsData() {
    List<UnitsProductListData> units = new ArrayList<>();
    for (Unlock unlock : this.unitsUnlockedAtLevel) {
      units.add(
          new UnitsProductListData(
              UnitFactory.getUnitStatic(unlock.unitType.name()), unlock.level));
    }
    this.unlockedUnitsData = units;
  }
}
