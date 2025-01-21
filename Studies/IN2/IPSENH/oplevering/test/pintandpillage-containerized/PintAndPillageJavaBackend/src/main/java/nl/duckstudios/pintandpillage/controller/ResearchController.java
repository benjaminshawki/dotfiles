package nl.duckstudios.pintandpillage.controller;

import nl.duckstudios.pintandpillage.entity.User;
import nl.duckstudios.pintandpillage.entity.Village;
import nl.duckstudios.pintandpillage.entity.buildings.ResearchBuilding;
import nl.duckstudios.pintandpillage.entity.researching.Research;
import nl.duckstudios.pintandpillage.helper.ResearchFactory;
import nl.duckstudios.pintandpillage.model.ResearchStartData;
import nl.duckstudios.pintandpillage.service.AccountService;
import nl.duckstudios.pintandpillage.service.AuthenticationService;
import nl.duckstudios.pintandpillage.service.BuildingService;
import nl.duckstudios.pintandpillage.service.VillageService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/research")
public class ResearchController {

  private final VillageService villageService;
  private final BuildingService buildingService;
  private final AuthenticationService authenticationService;
  private final AccountService accountService;

  private final ResearchFactory researchFactory;

  public ResearchController(
      VillageService villageService,
      BuildingService buildingService,
      AuthenticationService authenticationService,
      AccountService accountService,
      ResearchFactory researchFactory) {
    this.villageService = villageService;
    this.buildingService = buildingService;
    this.authenticationService = authenticationService;
    this.accountService = accountService;
    this.researchFactory = researchFactory;
  }

  @RequestMapping(method = RequestMethod.POST)
  @ResponseBody
  public Village startResearch(@RequestBody ResearchStartData researchStartData) {
    User user = this.authenticationService.getAuthenticatedUser();
    ResearchBuilding researchBuilding =
        (ResearchBuilding) this.buildingService.getBuilding(researchStartData.researchBuildingId);
    Village village = researchBuilding.getVillage();

    this.accountService.checkIsCorrectUser(user.getId(), village);

    Research research = this.getResearchData(village, researchStartData);

    researchBuilding.startResearch(research);

    this.villageService.update(village);

    return village;
  }

  private Research getResearchData(Village village, ResearchStartData researchStartData) {
    Research research =
        village.getCompletedResearches().stream()
            .filter(r -> r.getResearchName().name().equals(researchStartData.researchType))
            .findFirst()
            .orElse(this.researchFactory.getResearch(researchStartData.researchType));

    return research;
  }
}
