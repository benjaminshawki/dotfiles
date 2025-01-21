package nl.duckstudios.pintandpillage.controller;

import java.util.List;
import nl.duckstudios.pintandpillage.Exceptions.SettleConditionsNotMetException;
import nl.duckstudios.pintandpillage.dao.VillageDAO;
import nl.duckstudios.pintandpillage.entity.Coord;
import nl.duckstudios.pintandpillage.entity.User;
import nl.duckstudios.pintandpillage.entity.Village;
import nl.duckstudios.pintandpillage.entity.VillageUnit;
import nl.duckstudios.pintandpillage.helper.VillageFactory;
import nl.duckstudios.pintandpillage.model.NewVillageData;
import nl.duckstudios.pintandpillage.model.UnitType;
import nl.duckstudios.pintandpillage.model.VillageNameChangeData;
import nl.duckstudios.pintandpillage.service.AccountService;
import nl.duckstudios.pintandpillage.service.AuthenticationService;
import nl.duckstudios.pintandpillage.service.VillageService;
import nl.duckstudios.pintandpillage.service.WorldService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/village")
public class VillageController {

  private final VillageFactory villageFactory;
  private final VillageDAO villageDAO;
  private final AuthenticationService authenticationService;
  private final AccountService accountService;
  private final VillageService villageService;

  private final WorldService worldService;

  public VillageController(
      VillageFactory villageFactory,
      VillageDAO villageDAO,
      AuthenticationService authenticationService,
      AccountService accountService,
      VillageService villageService,
      WorldService worldService) {
    this.villageFactory = villageFactory;
    this.villageDAO = villageDAO;
    this.authenticationService = authenticationService;
    this.accountService = accountService;
    this.villageService = villageService;
    this.worldService = worldService;
  }

  @RequestMapping(method = RequestMethod.POST)
  @ResponseBody
  public Village createVillage() {
    User user = this.authenticationService.getAuthenticatedUser();
    Coord coord = this.worldService.getWorldMap().findEmptySpot();
    Village village = this.villageFactory.createBasicVillage(user, coord);
    villageDAO.save(village);
    return village;
  }

  @RequestMapping(value = "/{id}", method = RequestMethod.GET)
  @ResponseBody
  public Village getVillage(@PathVariable long id) {
    User user = this.authenticationService.getAuthenticatedUser();
    Village village = this.villageService.getVillage(id);

    this.accountService.checkIsCorrectUser(user.getId(), village);

    return village;
  }

  @RequestMapping(method = RequestMethod.GET)
  @ResponseBody
  public List<Village> getVillagesFromUser() {
    User user = this.authenticationService.getAuthenticatedUser();
    List<Village> villages = this.villageService.getListOfVillagesFromUser(user.getId());

    if (villages.size() == 0) {
      this.createVillage();
      villages = this.villageService.getListOfVillagesFromUser(user.getId());
    }

    return villages;
  }

  @RequestMapping(value = "changename/{id}", method = RequestMethod.POST)
  @ResponseBody
  public Village changeVillageName(
      @PathVariable long id, @RequestBody VillageNameChangeData villageNameChangeData) {
    User user = this.authenticationService.getAuthenticatedUser();
    Village village = this.villageService.getVillage(id);

    this.accountService.checkIsCorrectUser(user.getId(), village);

    village.setName(villageNameChangeData.newName);

    this.villageService.update(village);
    return village;
  }

  @RequestMapping(value = "startNew", method = RequestMethod.POST)
  @ResponseBody
  public Village startNewVillage(@RequestBody NewVillageData newVillageData) {
    User user = this.authenticationService.getAuthenticatedUser();
    Village village = this.villageService.getVillage(newVillageData.villageId);

    this.accountService.checkIsCorrectUser(user.getId(), village);

    this.villageService.checkIsValidCreatingSpot(village, newVillageData.newPosition);

    int amountOfJarlsNeeded = this.villageService.getListOfVillagesFromUser(user.getId()).size();
    VillageUnit jarl = village.getUnitInVillage(UnitType.Jarl);

    if (jarl == null || jarl.getAmount() < amountOfJarlsNeeded) {
      throw new SettleConditionsNotMetException("Not enough jarls to create this settlement");
    }

    jarl.setAmount(jarl.getAmount() - amountOfJarlsNeeded);

    Village newVillage = this.villageFactory.createBasicVillage(user, newVillageData.newPosition);

    this.villageService.update(newVillage);
    return newVillage;
  }
}
