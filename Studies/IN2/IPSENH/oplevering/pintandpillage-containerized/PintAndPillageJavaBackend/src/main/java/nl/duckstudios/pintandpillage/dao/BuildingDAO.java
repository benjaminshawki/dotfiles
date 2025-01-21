package nl.duckstudios.pintandpillage.dao;

import nl.duckstudios.pintandpillage.entity.buildings.Building;
import org.springframework.stereotype.Component;

@Component
public class BuildingDAO {

  private final BuildingRepository buildingRepository;

  public BuildingDAO(BuildingRepository buildingRepository) {
    this.buildingRepository = buildingRepository;
  }

  public Building getBuilding(long id) {
    return this.buildingRepository.findById(id);
  }
}
