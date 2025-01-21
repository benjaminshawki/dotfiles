package nl.duckstudios.pintandpillage.dao;

import nl.duckstudios.pintandpillage.entity.travels.Travel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TravelRepository extends JpaRepository<Travel, Long> {
  void deleteById(long id);
}
