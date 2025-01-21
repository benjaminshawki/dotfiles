package nl.duckstudios.pintandpillage.service;

import nl.duckstudios.pintandpillage.Exceptions.UnauthorizedException;
import nl.duckstudios.pintandpillage.entity.Village;
import org.springframework.stereotype.Service;

@Service
public class AccountService {

  public void checkIsCorrectUser(long userId, Village village) {
    if (userId != village.getUser().getId()) {
      throw new UnauthorizedException("No the owner of this village");
    }
  }
}
