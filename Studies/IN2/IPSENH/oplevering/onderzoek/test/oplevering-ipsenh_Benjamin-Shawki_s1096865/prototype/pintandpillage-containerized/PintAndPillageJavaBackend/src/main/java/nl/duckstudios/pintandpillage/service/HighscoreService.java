package nl.duckstudios.pintandpillage.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import nl.duckstudios.pintandpillage.dao.UserDAO;
import nl.duckstudios.pintandpillage.entity.User;
import nl.duckstudios.pintandpillage.model.UserHighscore;
import nl.duckstudios.pintandpillage.model.WorldVillage;
import org.springframework.stereotype.Service;

@Service
public class HighscoreService {

  private final UserDAO userDAO;
  private final VillageService villageService;

  public HighscoreService(UserDAO userDAO, VillageService villageService) {
    this.userDAO = userDAO;
    this.villageService = villageService;
  }

  public List<UserHighscore> getHighscore() {
    List<UserHighscore> highscores = new ArrayList<>();
    var villages = this.villageService.getWorldVillages();
    for (WorldVillage village : villages) {
      Optional<User> user = this.userDAO.findUsernameById(village.userId);
      if (user.isPresent()) {
        UserHighscore newHighscore = new UserHighscore(user.get().getUsername(), village.points);
        Optional<UserHighscore> existingScore =
            highscores.stream()
                .filter(h -> h.username.equals(user.get().getUsername()))
                .findFirst();
        if (existingScore.isPresent()) {
          existingScore.get().totalPoints += newHighscore.totalPoints;
          continue;
        }
        highscores.add(newHighscore);
      }
    }
    return highscores;
  }
}
