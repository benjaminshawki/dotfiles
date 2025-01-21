package nl.duckstudios.pintandpillage.Exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.UNPROCESSABLE_ENTITY)
public class UnmetEmailRequirementsException extends RuntimeException {
  public UnmetEmailRequirementsException() {
    super("Not a valid Email was provided");
  }
}
