package nl.duckstudios.pintandpillage.controller;

import java.util.List;
import nl.duckstudios.pintandpillage.entity.User;
import nl.duckstudios.pintandpillage.entity.WorldMap;
import nl.duckstudios.pintandpillage.model.SettleableSpots;
import nl.duckstudios.pintandpillage.model.UserHighscore;
import nl.duckstudios.pintandpillage.service.AuthenticationService;
import nl.duckstudios.pintandpillage.service.HighscoreService;
import nl.duckstudios.pintandpillage.service.VillageService;
import nl.duckstudios.pintandpillage.service.WorldService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/world")
public class WorldController {

  private final WorldService worldService;
  private final VillageService villageService;

  private final AuthenticationService authenticationService;

  private final HighscoreService highscoreService;

  public WorldController(
      WorldService worldService,
      VillageService villageService,
      AuthenticationService authenticationService,
      HighscoreService highscoreService) {
    this.worldService = worldService;
    this.villageService = villageService;
    this.authenticationService = authenticationService;
    this.highscoreService = highscoreService;
  }

  @RequestMapping(method = RequestMethod.GET)
  @ResponseBody
  public WorldMap getWorld() {
    return this.worldService.getWorldMap();
  }

  @RequestMapping(value = "settlespots/{id}", method = RequestMethod.GET)
  @ResponseBody
  public SettleableSpots getSettleableSpots(@PathVariable long id) {
    User user = this.authenticationService.getAuthenticatedUser();

    return this.worldService.getSettleableSpots(id, user);
  }

  @RequestMapping(value = "highscore", method = RequestMethod.GET)
  @ResponseBody
  public List<UserHighscore> getHighscore() {
    return this.highscoreService.getHighscore();
  }
}
