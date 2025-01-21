package nl.duckstudios.pintandpillage.dao;

import java.util.Optional;
import nl.duckstudios.pintandpillage.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
  Optional<User> findByEmail(String email);
}
