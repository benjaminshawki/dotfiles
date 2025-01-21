package nl.duckstudios.pintandpillage.helper;

import java.util.Map;
import nl.duckstudios.pintandpillage.entity.Village;
import org.springframework.stereotype.Component;

@Component
public class ResourceManager {

  public boolean hasEnoughResourcesAvailable(
      Village village, Map<String, Integer> resourcesRequiredLevelUp) {
    Map<String, Integer> resourcesInVillage = village.getVillageResources();
    for (Map.Entry<String, Integer> resource : resourcesRequiredLevelUp.entrySet()) {
      String currentKey = resource.getKey();
      if (resourcesInVillage.get(currentKey) <= resourcesRequiredLevelUp.get(currentKey))
        return false;
    }
    return true;
  }

  public boolean hasEnoughResourcesAvailable(
      Village village, Map<String, Integer> resourcesRequiredLevelUp, int amount) {
    Map<String, Integer> resourcesInVillage = village.getVillageResources();
    for (Map.Entry<String, Integer> resource : resourcesRequiredLevelUp.entrySet()) {
      String currentKey = resource.getKey();
      if (resourcesInVillage.get(currentKey) <= resourcesRequiredLevelUp.get(currentKey) * amount)
        return false;
    }
    return true;
  }

  public void subtractResources(Village village, Map<String, Integer> resourcesRequiredLevelUp) {
    Map<String, Integer> resourcesInVillage = village.getVillageResources();
    for (Map.Entry<String, Integer> resource : resourcesRequiredLevelUp.entrySet()) {
      String currentKey = resource.getKey();
      resourcesInVillage.put(
          currentKey,
          (resourcesInVillage.get(currentKey) - resourcesRequiredLevelUp.get(currentKey)));
    }
    village.setVillageResources(resourcesInVillage);
  }

  public void addResources(Village village, int amount, String type) {
    Map<String, Integer> resourcesInVillage = village.getVillageResources();
    int resourceCapacityLeft = village.getResourceLimit() - village.getVillageResources().get(type);
    int resourcesToAdd = Math.min(resourceCapacityLeft, amount);
    if (!resourcesInVillage.containsKey(type)) {
      resourcesInVillage.put(type, resourcesToAdd);
      return;
    }
    resourcesInVillage.put(type, resourcesInVillage.get(type) + resourcesToAdd);
    village.setVillageResources(resourcesInVillage);
  }
}
