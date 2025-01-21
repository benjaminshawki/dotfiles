package nl.duckstudios.pintandpillage.entity.buildings;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import nl.duckstudios.pintandpillage.entity.Village;
import nl.duckstudios.pintandpillage.helper.ResourceManager;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class BuildingTest {

  @Mock private Village villageMock;

  @Mock private Building building;

  @Mock private ResourceManager resourceManagerMock;

  @Test
  void levelUpSuccessfulWhenConditionsMet() {
    villageMock = new Village();
    villageMock.hasEnoughPopulation(10);
    // Arrange
    // when(resourceManagerMock.hasEnoughResourcesAvailable(villageMock,
    // building.getResourcesRequiredLevelUp())).thenReturn(true);
    // when(villageMock.hasEnoughPopulation(building.getPopulationRequiredNextLevel())).thenReturn(true);

    // Act
    building.levelUp();

    // Assert
    // assertTrue(building.isUnderConstruction());
    // assertNotNull(building.getLevelupFinishedTime());
    // verify(resourceManagerMock).subtractResources(villageMock,
    // building.getResourcesRequiredLevelUp());
  }
}
