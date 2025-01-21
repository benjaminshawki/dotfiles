package nl.duckstudios.pintandpillage.entity.travels;

import java.time.LocalDateTime;
import java.time.LocalTime;
import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
public class Travel {
  @Id
  @Getter
  @GeneratedValue(strategy = GenerationType.AUTO)
  @Setter
  private long id;

  @Getter @Setter private String name = getClass().getName();

  @Getter @Setter private LocalDateTime timeOfArrival;

  @Getter @Setter private LocalTime travelTime;

  @Getter @Setter private LocalTime travelTimeLeft;
}
