package nl.duckstudios.pintandpillage.model;

import com.fasterxml.jackson.annotation.JsonAlias;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import nl.duckstudios.pintandpillage.entity.Coord;

@NoArgsConstructor
@AllArgsConstructor
public class BuildingCreateData {
  public int villageId;

  public String buildingType;

  @JsonAlias("position")
  public Coord coord;
}
