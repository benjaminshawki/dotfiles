package nl.duckstudios.pintandpillage.entity;

import java.util.HashMap;
import java.util.Map;
import nl.duckstudios.pintandpillage.model.ResourceType;
import org.springframework.stereotype.Component;

@Component
public class Resources {

  private Map<ResourceType, Integer> availableResources = new HashMap<ResourceType, Integer>();

  public void addResource(ResourceType resource, Integer amount) {
    availableResources.put(resource, amount);
    System.out.println(availableResources);
  }
}
