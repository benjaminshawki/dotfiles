package nl.duckstudios.pintandpillage.entity.production;

import com.fasterxml.jackson.annotation.JsonBackReference;
import java.time.LocalDateTime;
import java.time.LocalTime;
import javax.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import nl.duckstudios.pintandpillage.entity.Village;
import nl.duckstudios.pintandpillage.entity.buildings.ProductionBuilding;

@Entity
@NoArgsConstructor
@Table(name = "ProductionItems")
public class UnitProductionItem {
  @Id @GeneratedValue @Getter private long id;

  @Getter
  @Setter
  @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
  @JsonBackReference
  private ProductionBuilding productionBuilding;

  @Getter
  @Setter
  @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
  private Unit unitToProduce;

  @Getter @Setter private long secondsToProduce;

  @Getter @Setter private long totalSecondsToProduce;

  @Getter @Setter private LocalTime timeToProduce;

  @Getter @Setter private LocalTime totalTimeToProduce;

  @Getter @Setter private LocalDateTime startTime;

  @Getter @Setter private int amountToProduce;

  @Getter @Setter private int startAmountToProduce;

  public UnitProductionItem(Unit unitToProduce, int amountToProduce) {
    this.unitToProduce = unitToProduce;
    this.amountToProduce = amountToProduce;
    this.startAmountToProduce = amountToProduce;
    this.startTime = LocalDateTime.now();
    this.secondsToProduce = unitToProduce.getBaseSecondsToProduce();
    this.totalSecondsToProduce = unitToProduce.getBaseSecondsToProduce() * amountToProduce;
    LocalTime localTime = LocalTime.of(0, 0, 0);
    this.timeToProduce = localTime.plusSeconds(this.secondsToProduce);
    this.totalTimeToProduce = localTime.plusSeconds(this.totalSecondsToProduce);
  }

  public void produce(Village village, int amount) {
    this.amountToProduce -= amount;
    this.addProductionToVillage(village, amount);
  }

  protected void addProductionToVillage(Village village, int amount) {
    village.addUnit(this.unitToProduce, amount);
  }
}
