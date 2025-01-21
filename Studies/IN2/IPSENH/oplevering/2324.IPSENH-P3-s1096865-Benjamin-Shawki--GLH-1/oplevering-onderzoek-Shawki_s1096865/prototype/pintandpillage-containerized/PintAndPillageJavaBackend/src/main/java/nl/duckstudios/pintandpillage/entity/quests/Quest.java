package nl.duckstudios.pintandpillage.entity.quests;

import lombok.Getter;
import lombok.Setter;

public class Quest {
  @Getter @Setter private int questId;

  @Getter @Setter private String title;

  @Getter @Setter private String description;

  @Getter @Setter private boolean isCompleted = false;
}
