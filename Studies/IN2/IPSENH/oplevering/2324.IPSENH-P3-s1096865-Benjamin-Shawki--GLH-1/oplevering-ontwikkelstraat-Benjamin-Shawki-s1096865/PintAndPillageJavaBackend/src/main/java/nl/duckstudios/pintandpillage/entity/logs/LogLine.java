package nl.duckstudios.pintandpillage.entity.logs;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.time.LocalDateTime;
import javax.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import nl.duckstudios.pintandpillage.entity.Village;

@Entity(name = "Logs")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@NoArgsConstructor
public class LogLine {
  @Id
  @Setter
  @Getter
  @GeneratedValue(strategy = GenerationType.AUTO)
  private long id;

  @Getter @Setter private LocalDateTime date;

  @Getter @Setter private String message;

  @Getter @Setter @ManyToOne @JsonIgnore private Village village;

  public LogLine(LocalDateTime date, String message, Village village) {
    this.date = date;
    this.message = message;
    this.village = village;
  }
}
