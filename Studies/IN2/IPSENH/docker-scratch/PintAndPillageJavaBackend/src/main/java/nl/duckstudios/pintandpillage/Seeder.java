package nl.duckstudios.pintandpillage;

import java.util.HashMap;
import java.util.Optional;
import nl.duckstudios.pintandpillage.dao.UserDAO;
import nl.duckstudios.pintandpillage.dao.VillageDAO;
import nl.duckstudios.pintandpillage.dao.VillageDataMapper;
import nl.duckstudios.pintandpillage.entity.Coord;
import nl.duckstudios.pintandpillage.entity.User;
import nl.duckstudios.pintandpillage.entity.Village;
import nl.duckstudios.pintandpillage.entity.buildings.Barracks;
import nl.duckstudios.pintandpillage.entity.buildings.Harbor;
import nl.duckstudios.pintandpillage.entity.buildings.House;
import nl.duckstudios.pintandpillage.entity.buildings.Smith;
import nl.duckstudios.pintandpillage.entity.production.Spear;
import nl.duckstudios.pintandpillage.entity.production.TransportShip;
import nl.duckstudios.pintandpillage.helper.VillageFactory;
import nl.duckstudios.pintandpillage.model.ResourceType;
import nl.duckstudios.pintandpillage.service.AuthenticationService;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class Seeder {
  private final UserDAO userDAO;
  private final VillageFactory villageFactory;

  private final VillageDataMapper villageDataMapper;

  private final VillageDAO villageDAO;

  private final AuthenticationService authenticationService;

  public Seeder(
      UserDAO userDAO,
      VillageFactory villageFactory,
      VillageDataMapper villageDataMapper,
      VillageDAO villageDAO,
      AuthenticationService authenticationService) {
    this.userDAO = userDAO;
    this.villageFactory = villageFactory;
    this.villageDataMapper = villageDataMapper;
    this.villageDAO = villageDAO;
    this.authenticationService = authenticationService;
  }

  @EventListener
  public void seed(ContextRefreshedEvent event) {
    this.seedUser();
    this.seedVillage();
  }

  public void seedUser() {
    User user = new User();
    user.setEmail("test5@mail.com");
    user.setUsername("Derp");
    user.setPassword(new BCryptPasswordEncoder().encode("Test123!"));
    userDAO.save(user);

    User user2 = new User();
    user2.setEmail("test6@mail.com");
    user2.setUsername("DerpTheBetterDerp");
    user2.setPassword(new BCryptPasswordEncoder().encode("Test123!"));
    userDAO.save(user2);
  }

  public void seedVillage() {
    Optional<User> user = this.userDAO.findByEmail("test5@mail.com");
    Optional<User> user2 = this.userDAO.findByEmail("test6@mail.com");

    if (user2.isPresent()) {
      Village village2 = this.villageFactory.createBasicVillage(user2.get(), new Coord(20, 15));
      Barracks barracks = new Barracks();
      barracks.setLevel(10);
      barracks.setVillage(village2);
      barracks.setPosition(new Coord(2, 2));
      barracks.setUnderConstruction(false);

      Smith smith = new Smith();
      smith.setLevel(10);
      smith.setVillage(village2);
      smith.setPosition(new Coord(9, 4));
      smith.setUnderConstruction(false);

      Harbor harbor = new Harbor();
      harbor.setLevel(10);
      harbor.setVillage(village2);
      harbor.setPosition(new Coord(11, 10));
      harbor.setUnderConstruction(false);

      House house = new House();
      house.setLevel(20);
      house.setVillage(village2);
      house.setPosition(new Coord(1, 4));
      house.setUnderConstruction(false);
      village2.setVillageResources(
          new HashMap<>() {
            {
              put(ResourceType.Stone.name(), 10000);
              put(ResourceType.Wood.name(), 10000);
              put(ResourceType.Beer.name(), 10000);
              put(ResourceType.Hop.name(), 5);
            }
          });

      village2.createBuilding(barracks);
      village2.createBuilding(smith);
      village2.createBuilding(harbor);
      village2.createBuilding(house);

      Spear spearUnit = new Spear();
      TransportShip transportShip = new TransportShip();

      village2.addUnit(spearUnit, 200);
      village2.addUnit(transportShip, 1);

      this.villageDAO.save(village2);
    }

    if (user.isPresent()) {
      Village village = this.villageFactory.createBasicVillage(user.get(), new Coord(10, 10));
      Barracks barracks = new Barracks();
      barracks.setLevel(10);
      barracks.setVillage(village);
      barracks.setPosition(new Coord(2, 2));
      barracks.setUnderConstruction(false);

      Smith smith = new Smith();
      smith.setLevel(10);
      smith.setVillage(village);
      smith.setPosition(new Coord(9, 4));
      smith.setUnderConstruction(false);

      Harbor harbor = new Harbor();
      harbor.setLevel(10);
      harbor.setVillage(village);
      harbor.setPosition(new Coord(11, 10));
      harbor.setUnderConstruction(false);

      House house = new House();
      house.setLevel(20);
      house.setVillage(village);
      house.setPosition(new Coord(1, 4));
      house.setUnderConstruction(false);
      village.setVillageResources(
          new HashMap<>() {
            {
              put(ResourceType.Stone.name(), 10000);
              put(ResourceType.Wood.name(), 10000);
              put(ResourceType.Beer.name(), 10000);
              put(ResourceType.Hop.name(), 5);
            }
          });

      village.createBuilding(barracks);
      village.createBuilding(smith);
      village.createBuilding(harbor);
      village.createBuilding(house);

      Spear spearUnit = new Spear();
      TransportShip transportShip = new TransportShip();

      village.addUnit(spearUnit, 10);
      village.addUnit(transportShip, 1);

      this.villageDAO.save(village);
    }
  }
}
