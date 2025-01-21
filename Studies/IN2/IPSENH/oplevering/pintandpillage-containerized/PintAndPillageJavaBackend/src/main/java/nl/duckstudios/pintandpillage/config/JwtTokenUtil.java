package nl.duckstudios.pintandpillage.config;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTCreationException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import java.util.Calendar;
import java.util.Date;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class JwtTokenUtil {

  @Value("${jwt.secret}")
  private String secret;

  public String generateToken(String email) throws IllegalArgumentException, JWTCreationException {

    return JWT.create()
        .withSubject("User Details")
        .withClaim("email", email)
        .withIssuedAt(new Date())
        .withExpiresAt(this.createExpirationDate())
        .withIssuer("Duck Studios")
        .sign(Algorithm.HMAC256(secret));
  }

  public String validateTokenAndRetrieveSubject(String token) throws JWTVerificationException {
    JWTVerifier verifier =
        JWT.require(Algorithm.HMAC256(secret))
            .withSubject("User Details")
            .withIssuer("Duck Studios")
            .build();
    DecodedJWT jwt = verifier.verify(token);
    return jwt.getClaim("email").asString();
  }

  private Date createExpirationDate() {
    int expirationHours = 6;
    Calendar appendableDate = Calendar.getInstance();
    appendableDate.setTime(new Date());
    appendableDate.add(Calendar.HOUR, expirationHours);
    return appendableDate.getTime();
  }
}
