package nl.duckstudios.pintandpillage.service;

import nl.duckstudios.pintandpillage.dao.VillageDataMapper;
import nl.duckstudios.pintandpillage.entity.Coord;
import nl.duckstudios.pintandpillage.entity.User;
import nl.duckstudios.pintandpillage.entity.Village;
import nl.duckstudios.pintandpillage.entity.WorldMap;
import nl.duckstudios.pintandpillage.model.SettleableSpots;
import org.springframework.stereotype.Service;

@Service
public class WorldService {

  private final VillageDataMapper villageDataMapper;
  private final DistanceService distanceService;

  public WorldService(VillageDataMapper villageDataMapper, DistanceService distanceService) {
    this.villageDataMapper = villageDataMapper;
    this.distanceService = distanceService;
  }

  public WorldMap getWorldMap() {
    WorldMap worldMap = new WorldMap(34843, 50, 50, 25);
    worldMap.setVillages(this.villageDataMapper.getWorldVillages());

    return worldMap;
  }

  public SettleableSpots getSettleableSpots(long id, User user) {
    final int maxRange = 5;
    Village village = this.villageDataMapper.getVillage(id);
    Coord villagePosition = new Coord(village.getPositionX(), village.getPositionY());
    WorldMap worldMap = this.getWorldMap();

    int amountOfJarlsNeeded = this.villageDataMapper.getVillages(user.getId()).size();

    SettleableSpots spots = new SettleableSpots();
    spots.amountOfJarlsNeeded = amountOfJarlsNeeded;

    for (int x = villagePosition.getX() - maxRange; x < villagePosition.getX() + maxRange; x++) {
      for (int y = villagePosition.getY() - maxRange; y < villagePosition.getY() + maxRange; y++) {
        Coord position = new Coord(x, y);
        if (worldMap.isValidToBuildNewVillage(position)
            && this.distanceService.calculateDistance(villagePosition, position) <= maxRange) {
          spots.validPositions.add(position);
        }
      }
    }

    return spots;
  }
}
