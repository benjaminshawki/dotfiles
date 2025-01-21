package nl.duckstudios.pintandpillage.Exceptions;

public class UserAlreadyExistsException extends RuntimeException {

  public UserAlreadyExistsException(String message) {
    super("Email adres is taken " + message);
  }
}
