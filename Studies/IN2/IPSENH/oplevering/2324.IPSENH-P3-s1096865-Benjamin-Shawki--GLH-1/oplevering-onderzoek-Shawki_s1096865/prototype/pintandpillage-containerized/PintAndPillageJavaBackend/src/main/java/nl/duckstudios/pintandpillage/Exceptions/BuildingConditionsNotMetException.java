package nl.duckstudios.pintandpillage.Exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.UNPROCESSABLE_ENTITY)
public class BuildingConditionsNotMetException extends RuntimeException {
  public BuildingConditionsNotMetException(String message) {
    super(message);
  }
}
