package nl.duckstudios.pintandpillage.service;

import nl.duckstudios.pintandpillage.dao.BuildingDAO;
import nl.duckstudios.pintandpillage.entity.buildings.Building;
import org.springframework.stereotype.Service;

@Service
public class BuildingService {

  private final BuildingDAO buildingDAO;

  public BuildingService(BuildingDAO buildingDAO) {
    this.buildingDAO = buildingDAO;
  }

  public Building getBuilding(long id) {
    return this.buildingDAO.getBuilding(id);
  }
}
