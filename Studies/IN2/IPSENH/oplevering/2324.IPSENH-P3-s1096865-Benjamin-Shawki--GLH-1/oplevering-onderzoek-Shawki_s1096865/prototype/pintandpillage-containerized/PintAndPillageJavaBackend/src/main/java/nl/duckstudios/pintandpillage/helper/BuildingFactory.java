package nl.duckstudios.pintandpillage.helper;

import nl.duckstudios.pintandpillage.Exceptions.NotExistingEntityException;
import nl.duckstudios.pintandpillage.entity.Coord;
import nl.duckstudios.pintandpillage.entity.buildings.*;
import org.springframework.stereotype.Component;

@Component
public class BuildingFactory {

  public Building getBuilding(String buildingName, Coord position) {
    switch (buildingName) {
      case "Headquarters" -> {
        Headquarters headquarters = new Headquarters();
        headquarters.setPosition(position);
        return headquarters;
      }
      case "House" -> {
        House house = new House();
        house.setPosition(position);
        return house;
      }
      case "Mine" -> {
        Mine mine = new Mine();
        mine.setPosition(position);
        return mine;
      }
      case "Barracks" -> {
        Barracks barracks = new Barracks();
        barracks.setPosition(position);
        return barracks;
      }
      case "Lumberyard" -> {
        Lumberyard lumberyard = new Lumberyard();
        lumberyard.setPosition(position);
        return lumberyard;
      }
      case "Farm" -> {
        Farm farm = new Farm();
        farm.setPosition(position);
        return farm;
      }
      case "Tavern" -> {
        Tavern tavern = new Tavern();
        tavern.setPosition(position);
        return tavern;
      }
      case "Wall" -> {
        Wall wall = new Wall();
        wall.setPosition(position);
        return wall;
      }
      case "DefenceTower" -> {
        DefenceTower defenceTower = new DefenceTower();
        defenceTower.setPosition(position);
        return defenceTower;
      }
      case "Harbor" -> {
        Harbor harbor = new Harbor();
        harbor.setPosition(position);
        return harbor;
      }
      case "Smith" -> {
        Smith smith = new Smith();
        smith.setPosition(position);
        return smith;
      }
      case "Storage" -> {
        Storage storage = new Storage();
        storage.setPosition(position);
        return storage;
      }
      default -> throw new NotExistingEntityException(buildingName + " does not exist");
    }
  }
}
