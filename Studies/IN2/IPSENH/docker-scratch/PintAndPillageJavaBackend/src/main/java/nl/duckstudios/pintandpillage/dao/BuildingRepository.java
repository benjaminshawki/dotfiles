package nl.duckstudios.pintandpillage.dao;

import nl.duckstudios.pintandpillage.entity.buildings.Building;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BuildingRepository extends JpaRepository<Building, Long> {
  Building findById(long id);
}
