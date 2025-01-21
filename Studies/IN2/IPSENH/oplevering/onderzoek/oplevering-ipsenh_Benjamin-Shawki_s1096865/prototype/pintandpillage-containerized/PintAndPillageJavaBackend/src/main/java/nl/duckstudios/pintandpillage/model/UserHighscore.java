package nl.duckstudios.pintandpillage.model;

public class UserHighscore {
  public String username;
  public int totalPoints;

  public UserHighscore(String username, int totalPoints) {
    this.username = username;
    this.totalPoints = totalPoints;
  }
}
