package nl.duckstudios.pintandpillage.dao;

import nl.duckstudios.pintandpillage.entity.travels.AttackCombatTravel;
import org.springframework.stereotype.Component;

@Component
public class TravelDao {

  private final TravelRepository travelRepository;

  public TravelDao(TravelRepository travelRepository) {
    this.travelRepository = travelRepository;
  }

  public void insertAttack(AttackCombatTravel travel) {
    this.travelRepository.save(travel);
  }
}
