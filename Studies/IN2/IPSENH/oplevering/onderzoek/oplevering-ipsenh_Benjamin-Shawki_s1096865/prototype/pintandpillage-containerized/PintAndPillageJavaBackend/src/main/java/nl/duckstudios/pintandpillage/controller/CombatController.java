package nl.duckstudios.pintandpillage.controller;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import nl.duckstudios.pintandpillage.Exceptions.AttackingConditionsNotMetException;
import nl.duckstudios.pintandpillage.dao.TravelDao;
import nl.duckstudios.pintandpillage.entity.Coord;
import nl.duckstudios.pintandpillage.entity.User;
import nl.duckstudios.pintandpillage.entity.Village;
import nl.duckstudios.pintandpillage.entity.VillageUnit;
import nl.duckstudios.pintandpillage.entity.travels.AttackCombatTravel;
import nl.duckstudios.pintandpillage.model.AttackVillageData;
import nl.duckstudios.pintandpillage.service.*;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/combat")
public class CombatController {

  private final AuthenticationService authenticationService;
  private final AccountService accountService;
  private final VillageService villageService;
  private final CombatService combatService;

  private final TravelDao travelDao;
  private final DistanceService distanceService;

  public CombatController(
      AuthenticationService authenticationService,
      AccountService accountService,
      VillageService villageService,
      CombatService combatService,
      TravelDao travelDao,
      DistanceService distanceService) {
    this.authenticationService = authenticationService;
    this.accountService = accountService;
    this.villageService = villageService;
    this.combatService = combatService;
    this.travelDao = travelDao;
    this.distanceService = distanceService;
  }

  @RequestMapping(method = RequestMethod.POST)
  @ResponseBody
  public Village attackVillage(@RequestBody AttackVillageData data) {
    if (data.fromVillageId == data.toVillageId) {
      throw new AttackingConditionsNotMetException("You should not attack yourself...");
    }

    User user = this.authenticationService.getAuthenticatedUser();

    Village attackingVillage = this.villageService.getVillage(data.fromVillageId);
    this.accountService.checkIsCorrectUser(user.getId(), attackingVillage);

    Village defendingVillage = this.villageService.getVillage(data.toVillageId);

    List<VillageUnit> attackingUnits = this.combatService.convertToVillageUnits(data);

    this.combatService.checkHasEnoughUnitsToAttack(attackingUnits, attackingVillage);
    this.combatService.checkHasEnoughShipsToSendUnits(attackingUnits);

    AttackCombatTravel travel =
        this.CreateCombatTravel(attackingUnits, attackingVillage, defendingVillage);

    this.villageService.update(attackingVillage);
    this.travelDao.insertAttack(travel);

    return attackingVillage;
  }

  private AttackCombatTravel CreateCombatTravel(
      List<VillageUnit> attackingUnits, Village attackingVillage, Village defendingVillage) {
    int slowestUnitSpeed =
        attackingUnits.stream().mapToInt(a -> a.getUnit().getSpeed()).min().orElse(-1);
    int distanceBetweenVillages =
        this.distanceService.calculateDistance(
            new Coord(attackingVillage.getPositionX(), attackingVillage.getPositionY()),
            new Coord(defendingVillage.getPositionX(), defendingVillage.getPositionY()));

    long travelTimeSeconds = (long) distanceBetweenVillages * (1000 / slowestUnitSpeed);
    LocalTime travelTime = LocalTime.of(0, 0, 0).plusSeconds(travelTimeSeconds);

    AttackCombatTravel travel = new AttackCombatTravel();
    travel.setAttackingVillage(attackingVillage);
    travel.setDefendingVillage(defendingVillage);
    travel.setTimeOfArrival(LocalDateTime.now().plusSeconds(travelTimeSeconds));
    travel.setTravelTime(travelTime);
    travel.setTravelingUnits(attackingUnits);
    for (VillageUnit villageUnit : attackingUnits) {
      villageUnit.setCombatTravel(travel);
    }

    return travel;
  }
}
