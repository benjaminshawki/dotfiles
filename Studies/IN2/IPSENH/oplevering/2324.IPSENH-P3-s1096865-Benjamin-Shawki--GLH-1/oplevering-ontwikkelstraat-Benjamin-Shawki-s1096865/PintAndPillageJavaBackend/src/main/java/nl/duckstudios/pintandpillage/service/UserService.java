package nl.duckstudios.pintandpillage.service;

import java.util.Collections;
import java.util.Optional;
import nl.duckstudios.pintandpillage.dao.UserDAO;
import nl.duckstudios.pintandpillage.entity.User;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class UserService implements UserDetailsService {

  private final UserDAO userDAO;

  public UserService(UserDAO userDAO) {
    this.userDAO = userDAO;
  }

  @Override
  public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
    Optional<User> requestedUser = userDAO.findByEmail(email);

    if (requestedUser.isEmpty()) {
      throw new UsernameNotFoundException("No user with email: " + email);
    }

    User user = requestedUser.get();
    return new org.springframework.security.core.userdetails.User(
        email,
        user.getPassword(),
        Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER")));
  }
}
