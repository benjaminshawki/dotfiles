package nl.duckstudios.pintandpillage.config;

import com.auth0.jwt.exceptions.JWTVerificationException;
import java.io.IOException;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nl.duckstudios.pintandpillage.service.UserService;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

@Component
public class JWTFilter extends OncePerRequestFilter {

  private final UserService userService;
  private final JwtTokenUtil jwtTokenUtil;

  public JWTFilter(UserService userService, JwtTokenUtil jwtTokenUtil) {
    this.userService = userService;
    this.jwtTokenUtil = jwtTokenUtil;
  }

  @Override
  protected void doFilterInternal(
      HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
      throws ServletException, IOException {
    String authHeader = request.getHeader("Authorization");
    if (authHeader != null && !authHeader.isBlank() && authHeader.startsWith("Bearer ")) {
      String jwt = authHeader.substring(7);
      if (jwt == null || jwt.isBlank()) {
        response.sendError(
            HttpServletResponse.SC_BAD_REQUEST, "Invalid JWT Token in Bearer Header");
        return;
      } else {
        try {
          String email = jwtTokenUtil.validateTokenAndRetrieveSubject(jwt);
          UserDetails userDetails = userService.loadUserByUsername(email);
          UsernamePasswordAuthenticationToken authToken =
              new UsernamePasswordAuthenticationToken(
                  email, userDetails.getPassword(), userDetails.getAuthorities());
          if (SecurityContextHolder.getContext().getAuthentication() == null) {
            SecurityContextHolder.getContext().setAuthentication(authToken);
          }
        } catch (JWTVerificationException exc) {
          response.sendError(401, exc.getMessage());
          return;
        }
      }
    }

    filterChain.doFilter(request, response);
  }
}
