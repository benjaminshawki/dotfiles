package nl.duckstudios.pintandpillage.controller;

import nl.duckstudios.pintandpillage.entity.User;
import nl.duckstudios.pintandpillage.entity.Village;
import nl.duckstudios.pintandpillage.entity.buildings.ProductionBuilding;
import nl.duckstudios.pintandpillage.entity.production.Unit;
import nl.duckstudios.pintandpillage.helper.UnitFactory;
import nl.duckstudios.pintandpillage.model.UnitCreateData;
import nl.duckstudios.pintandpillage.service.AccountService;
import nl.duckstudios.pintandpillage.service.AuthenticationService;
import nl.duckstudios.pintandpillage.service.BuildingService;
import nl.duckstudios.pintandpillage.service.VillageService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/production")
public class ProductionController {

  private final VillageService villageService;
  private final BuildingService buildingService;
  private final AuthenticationService authenticationService;
  private final AccountService accountService;

  private final UnitFactory unitFactory;

  public ProductionController(
      VillageService villageService,
      BuildingService buildingService,
      AuthenticationService authenticationService,
      AccountService accountService,
      UnitFactory unitFactory) {
    this.villageService = villageService;
    this.buildingService = buildingService;
    this.authenticationService = authenticationService;
    this.accountService = accountService;
    this.unitFactory = unitFactory;
  }

  @RequestMapping(value = "train", method = RequestMethod.POST)
  @ResponseBody
  public Village trainUnitsInBuilding(@RequestBody UnitCreateData unitCreateData) {
    User user = this.authenticationService.getAuthenticatedUser();
    ProductionBuilding productionBuilding =
        (ProductionBuilding) this.buildingService.getBuilding(unitCreateData.productionBuildingId);
    Village village = productionBuilding.getVillage();

    this.accountService.checkIsCorrectUser(user.getId(), village);

    Unit unit = this.unitFactory.getUnit(unitCreateData.unitType);

    productionBuilding.produceUnit(unit, unitCreateData.amount);

    this.villageService.update(productionBuilding.getVillage());

    return productionBuilding.getVillage();
  }
}
