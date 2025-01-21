package nl.duckstudios.pintandpillage.Exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.UNPROCESSABLE_ENTITY)
public class SettleConditionsNotMetException extends RuntimeException {
  public SettleConditionsNotMetException(String message) {
    super(message);
  }
}
