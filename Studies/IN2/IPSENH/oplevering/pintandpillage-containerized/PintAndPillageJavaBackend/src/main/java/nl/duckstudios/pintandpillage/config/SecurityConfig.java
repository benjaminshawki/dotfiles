package nl.duckstudios.pintandpillage.config;

import javax.servlet.http.HttpServletResponse;
import nl.duckstudios.pintandpillage.service.UserService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
  private final JWTFilter filter;
  private final UserService userService;

  public SecurityConfig(JWTFilter filter, UserService userService) {
    this.filter = filter;
    this.userService = userService;
  }

  @Bean
  public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

    http.csrf()
        .disable()
        .httpBasic()
        .disable()
        .cors()
        .and()
        .authorizeHttpRequests()
        .antMatchers("/api/auth/register", "/api/auth/login")
        .permitAll()
        .antMatchers("/api/user/info")
        .hasRole("USER")
        .antMatchers("/api/village")
        .hasRole("USER")
        .antMatchers("/api/building")
        .hasRole("USER")
        .antMatchers("/api/production")
        .hasRole("USER")
        .antMatchers("/api/world")
        .hasRole("USER")
        .and()
        .userDetailsService(userService)
        .exceptionHandling()
        .authenticationEntryPoint(
            (request, response, authException) ->
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized"))
        .and()
        .sessionManagement()
        .sessionCreationPolicy(SessionCreationPolicy.STATELESS);

    return http.addFilterBefore(filter, UsernamePasswordAuthenticationFilter.class).build();
  }

  @Bean
  public PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder();
  }

  @Bean
  public AuthenticationManager authenticationManager(
      AuthenticationConfiguration authenticationConfiguration) throws Exception {
    return authenticationConfiguration.getAuthenticationManager();
  }
}
