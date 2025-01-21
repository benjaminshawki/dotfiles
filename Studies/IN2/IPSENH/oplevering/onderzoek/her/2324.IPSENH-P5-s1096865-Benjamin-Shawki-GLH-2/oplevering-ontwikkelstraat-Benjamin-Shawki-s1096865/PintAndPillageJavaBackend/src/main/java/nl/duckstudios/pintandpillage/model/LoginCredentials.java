package nl.duckstudios.pintandpillage.model;

public class LoginCredentials {

  public String username;
  public String password;

  public LoginCredentials() {}

  public LoginCredentials(String email, String password) {
    this.username = email;
    this.password = password;
  }
}
