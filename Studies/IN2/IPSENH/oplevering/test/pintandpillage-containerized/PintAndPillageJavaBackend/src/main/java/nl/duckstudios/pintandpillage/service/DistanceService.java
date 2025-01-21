package nl.duckstudios.pintandpillage.service;

import nl.duckstudios.pintandpillage.entity.Coord;
import org.springframework.stereotype.Service;

@Service
public class DistanceService {

  public int calculateDistance(Coord coordA, Coord coordB) {
    int xDiff = Math.abs(coordB.getX() - coordA.getX());
    int yDiff = Math.abs(coordB.getY() - coordA.getY());

    // Math time!
    int distance = (int) Math.ceil(Math.sqrt(Math.pow(xDiff, 2) + Math.pow(yDiff, 2)));

    return distance;
  }
}
