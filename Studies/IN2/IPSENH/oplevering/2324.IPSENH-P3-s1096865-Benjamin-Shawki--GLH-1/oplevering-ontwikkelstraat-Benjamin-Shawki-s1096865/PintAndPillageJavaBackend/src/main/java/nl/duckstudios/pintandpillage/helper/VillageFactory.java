package nl.duckstudios.pintandpillage.helper;

import nl.duckstudios.pintandpillage.entity.Coord;
import nl.duckstudios.pintandpillage.entity.User;
import nl.duckstudios.pintandpillage.entity.Village;
import nl.duckstudios.pintandpillage.entity.buildings.Headquarters;
import org.springframework.stereotype.Component;

@Component
public class VillageFactory {

  public Village createBasicVillage(User user, Coord coord) {
    Village village = new Village();

    village.setPositionX(coord.getX());
    village.setPositionY(coord.getY());
    village.setName(this.generateRandomVillageName());
    village.setUser(user);

    Headquarters hq = new Headquarters();
    hq.setPosition(new Coord(6, 6));
    hq.setVillage(village);
    hq.setLevel(1);
    hq.setUnderConstruction(false);

    village.createBuilding(hq);

    return village;
  }

  private String generateRandomVillageName() {
    String[] names = {
      "Apal", "Bekkr", "Breior", "Brekka", "Buo", "Dalr", "Djupr", "Eksi", "Full", "Garor", "Gata",
      "Haugr", "Holm", "Holr", "Hus", "Kaldr", "Kirkja"
    };
    int randomIndex = (int) (Math.random() * (names.length));
    return names[randomIndex];
  }
}
