package nl.duckstudios.pintandpillage.service;

import nl.duckstudios.pintandpillage.dao.UserDAO;
import nl.duckstudios.pintandpillage.entity.User;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
public class AuthenticationService {

  private final UserDAO userDAO;

  public AuthenticationService(UserDAO userDAO) {
    this.userDAO = userDAO;
  }

  public User getAuthenticatedUser() {
    String email = (String) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    User user = userDAO.findByEmail(email).get();
    return user;
  }
}
