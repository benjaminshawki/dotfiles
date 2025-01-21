package nl.duckstudios.pintandpillage.controller;

import nl.duckstudios.pintandpillage.entity.User;
import nl.duckstudios.pintandpillage.entity.Village;
import nl.duckstudios.pintandpillage.entity.buildings.Building;
import nl.duckstudios.pintandpillage.helper.BuildingFactory;
import nl.duckstudios.pintandpillage.model.BuildingCreateData;
import nl.duckstudios.pintandpillage.service.AccountService;
import nl.duckstudios.pintandpillage.service.AuthenticationService;
import nl.duckstudios.pintandpillage.service.BuildingService;
import nl.duckstudios.pintandpillage.service.VillageService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/building")
public class BuildingController {

  private final VillageService villageService;
  private final BuildingService buildingService;
  private final AuthenticationService authenticationService;
  private final AccountService accountService;
  private final BuildingFactory buildingFactory;

  public BuildingController(
      VillageService villageService,
      BuildingService buildingService,
      AuthenticationService authenticationService,
      AccountService accountService,
      BuildingFactory buildingFactory) {
    this.villageService = villageService;
    this.buildingService = buildingService;
    this.authenticationService = authenticationService;
    this.accountService = accountService;
    this.buildingFactory = buildingFactory;
  }

  @RequestMapping(value = "/build", method = RequestMethod.POST)
  @ResponseBody
  public Village createBuilding(@RequestBody BuildingCreateData buildingCreateData) {
    User user = this.authenticationService.getAuthenticatedUser();
    Village village = this.villageService.getVillage(buildingCreateData.villageId);

    this.accountService.checkIsCorrectUser(user.getId(), village);
    Building building =
        buildingFactory.getBuilding(buildingCreateData.buildingType, buildingCreateData.coord);

    return this.villageService.createBuilding(village, building);
  }

  @RequestMapping(value = "/levelup/{id}", method = RequestMethod.POST)
  @ResponseBody
  public Village levelUpBuilding(@PathVariable long id) {
    User user = this.authenticationService.getAuthenticatedUser();
    Building building = this.buildingService.getBuilding(id);
    Village village = building.getVillage();

    this.accountService.checkIsCorrectUser(user.getId(), village);

    building.levelUp();
    this.villageService.update(village);
    return village;
  }
}
