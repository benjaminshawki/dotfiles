package nl.duckstudios.pintandpillage.dao;

import java.util.List;
import nl.duckstudios.pintandpillage.entity.Village;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VillageRepository extends JpaRepository<Village, Long> {
  List<Village> findByUserId(long id);
}
