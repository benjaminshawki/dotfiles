package nl.duckstudios.pintandpillage.Exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.UNPROCESSABLE_ENTITY)
public class ProductionConditionsNotMetException extends RuntimeException {
  public ProductionConditionsNotMetException(String message) {
    super(message);
  }
}
