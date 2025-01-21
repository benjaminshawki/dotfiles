package nl.duckstudios.pintandpillage.controller;

import java.util.Arrays;
import java.util.Collections;
import java.util.Map;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import nl.duckstudios.pintandpillage.Exceptions.ForbiddenException;
import nl.duckstudios.pintandpillage.Exceptions.UnmetEmailRequirementsException;
import nl.duckstudios.pintandpillage.Exceptions.UnmetPasswordRequirementsException;
import nl.duckstudios.pintandpillage.Exceptions.UserAlreadyExistsException;
import nl.duckstudios.pintandpillage.config.JwtTokenUtil;
import nl.duckstudios.pintandpillage.dao.UserDAO;
import nl.duckstudios.pintandpillage.entity.User;
import nl.duckstudios.pintandpillage.model.JwtResult;
import nl.duckstudios.pintandpillage.model.LoginCredentials;
import org.passay.*;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

  private final UserDAO userDAO;
  private final JwtTokenUtil jwtUtil;
  private final AuthenticationManager authManager;
  private final PasswordEncoder passwordEncoder;

  public AuthController(
      JwtTokenUtil jwtUtil,
      AuthenticationManager authManager,
      PasswordEncoder passwordEncoder,
      UserDAO userDAO) {
    this.jwtUtil = jwtUtil;
    this.authManager = authManager;
    this.passwordEncoder = passwordEncoder;
    this.userDAO = userDAO;
  }

  @PostMapping("/register")
  public Map<String, Object> register(@RequestBody User user) {
    if (!this.isValidEmail(user.getEmail())) {
      throw new UnmetEmailRequirementsException();
    }

    if (!this.isValidPassword(user.getPassword())) {
      throw new UnmetPasswordRequirementsException();
    }

    Optional<User> requestedUser = userDAO.findByEmail(user.getEmail());

    if (requestedUser.isPresent()) {
      throw new UserAlreadyExistsException(user.getEmail());
    }

    String encodedPassword = passwordEncoder.encode(user.getPassword());
    user.setPassword(encodedPassword);
    user = userDAO.save(user);
    String token = jwtUtil.generateToken(user.getEmail());
    return Collections.singletonMap("token", token);
  }

  @PostMapping("/login")
  public JwtResult login(@RequestBody LoginCredentials body) {
    try {
      UsernamePasswordAuthenticationToken authInputToken =
          new UsernamePasswordAuthenticationToken(body.username, body.password);

      authManager.authenticate(authInputToken);

      String token = jwtUtil.generateToken(body.username);
      JwtResult jwtResult = new JwtResult();

      Optional<User> user = userDAO.findByEmail(body.username);
      if (user.isPresent() && user.get().isFirstTimeLoggedIn()) {
        user.get().setFirstTimeLoggedIn(false);
        userDAO.save(user.get());
        jwtResult.isFirstTimeLoggedIn = true;
      }
      jwtResult.token = token;

      return jwtResult;

    } catch (AuthenticationException authExc) {
      throw new ForbiddenException("Invalid Login Credentials");
    }
  }

  private boolean isValidPassword(String password) {
    PasswordValidator validator =
        new PasswordValidator(
            Arrays.asList(
                new LengthRule(8, 30),
                new CharacterRule(EnglishCharacterData.Digit, 1),
                new CharacterRule(EnglishCharacterData.LowerCase, 1),
                new CharacterRule(EnglishCharacterData.UpperCase, 1),
                new CharacterRule(EnglishCharacterData.Special, 1),
                new WhitespaceRule()));

    RuleResult result = validator.validate(new PasswordData(password));
    return result.isValid();
  }

  private boolean isValidEmail(String email) {
    final Pattern VALID_EMAIL_ADDRESS_REGEX =
        Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$", Pattern.CASE_INSENSITIVE);
    Matcher matcher = VALID_EMAIL_ADDRESS_REGEX.matcher(email);
    return matcher.find();
  }
}
