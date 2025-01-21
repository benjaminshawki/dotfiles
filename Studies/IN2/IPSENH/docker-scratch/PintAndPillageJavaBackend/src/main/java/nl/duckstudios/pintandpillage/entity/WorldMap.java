package nl.duckstudios.pintandpillage.entity;

import java.util.List;
import java.util.Optional;
import java.util.Random;
import lombok.Getter;
import lombok.Setter;
import nl.duckstudios.pintandpillage.Exceptions.NoEmptyVillageSpotFoundException;
import nl.duckstudios.pintandpillage.model.Tile;
import nl.duckstudios.pintandpillage.model.TileType;
import nl.duckstudios.pintandpillage.model.WorldVillage;

public class WorldMap {

  private final int minDistanceBetweenIslands = 2;
  private final int changeWaterTileBecomesGrass = 80;
  @Setter @Getter private List<WorldVillage> villages;
  @Setter @Getter private Tile[][] worldTiles;

  public WorldMap(int seed, int xSize, int ySize, int maxIslandsAmount) {
    this.generateWorld(seed, xSize, ySize, maxIslandsAmount);
  }

  public Coord findEmptySpot() {
    int maxIterations = 200;
    Random random = new Random();

    for (int i = 0; i < maxIterations; i++) {
      int randomX = random.nextInt(0, this.worldTiles.length - 1);
      int randomY = random.nextInt(0, this.worldTiles[0].length - 1);
      Tile tile = this.worldTiles[randomX][randomY];

      if (this.isWaterTile(randomX, randomY) || !this.hasWaterTilesAround(tile, 3)) continue;

      Coord coord = new Coord(randomX, randomY);
      Optional<WorldVillage> match =
          this.villages.stream().filter(v -> v.position.equals(coord)).findAny();
      if (match.isEmpty()) {
        return coord;
      }
    }
    throw new NoEmptyVillageSpotFoundException("This world has no empty spots left");
  }

  public boolean isValidToBuildNewVillage(Coord coord) {
    return this.isValidPosition(coord.getX(), coord.getY())
        && this.isGrassTile(coord.getX(), coord.getY())
        && this.hasWaterTilesAround(this.worldTiles[coord.getX()][coord.getY()], 2)
        && this.villages.stream().filter(v -> v.position.equals(coord)).findAny().isEmpty();
  }

  private void generateWorld(int seed, int xSize, int ySize, int maxIslandsAmount) {
    Random randomSeed = new Random(seed);
    this.worldTiles = new Tile[xSize][ySize];

    this.fillMapWithWater();

    for (int i = 0; i < maxIslandsAmount; i++) {
      int randomX = randomSeed.nextInt(0, xSize - 1);
      int randomY = randomSeed.nextInt(0, ySize - 1);

      if (this.isNotNearOtherIslands(randomX, randomX)) {
        Tile tile = new Tile(TileType.Grass, randomX, randomY);
        this.makeIslandOfStartPoint(tile, randomSeed);
      }
    }
  }

  private void fillMapWithWater() {
    for (int x = 0; x < this.worldTiles.length; x++) {
      for (int y = 0; y < this.worldTiles[x].length; y++) {
        this.worldTiles[x][y] = new Tile(TileType.Water, x, y);
      }
    }
  }

  private boolean isNotNearOtherIslands(int startX, int startY) {
    for (int x = startX - this.minDistanceBetweenIslands;
        x < startX + minDistanceBetweenIslands;
        x++) {
      for (int y = startY - this.minDistanceBetweenIslands;
          y < startY + minDistanceBetweenIslands;
          y++) {
        if (!this.isValidPosition(x, y)) continue;

        if (this.isGrassTile(x, y)) {
          return false;
        }
      }
    }
    return true;
  }

  private boolean isValidPosition(int x, int y) {
    return x >= 0 && y >= 0 && x < this.worldTiles.length - 1 && y < this.worldTiles[x].length - 1;
  }

  private boolean isGrassTile(int x, int y) {
    return this.worldTiles[x][y] != null && this.worldTiles[x][y].tileType == TileType.Grass;
  }

  private void makeIslandOfStartPoint(Tile tile, Random random) {
    this.expandIsland(tile.x, tile.y, random, 0);
  }

  private void expandIsland(int x, int y, Random random, int depth) {
    if (!this.isValidPosition(x, y)) return;

    if (depth > 5) {
      return;
    }

    boolean willExpand = random.nextInt(0, 100) < this.changeWaterTileBecomesGrass;
    if (willExpand) {
      if (!this.isWaterTile(x, y)) return;

      depth += 1;
      this.turnTileToGrass(x, y);
      this.expandIsland(x, y + 1, random, depth);
      this.expandIsland(x, y - 1, random, depth);
      this.expandIsland(x + 1, y, random, depth);
      this.expandIsland(x - 1, y, random, depth);
    }
  }

  private boolean isWaterTile(int x, int y) {
    return this.worldTiles[x][y] != null && this.worldTiles[x][y].tileType == TileType.Water;
  }

  private void turnTileToGrass(int x, int y) {
    this.worldTiles[x][y] = new Tile(TileType.Grass, x, y);
  }

  private boolean hasWaterTilesAround(Tile tile, int amountOfWaterTiles) {
    int amountWaterFound = 0;

    for (int x = tile.x - 1; x <= tile.x + 1; x++) {
      for (int y = tile.y - 1; y <= tile.y + 1; y++) {
        if (this.isValidPosition(x, y) && isWaterTile(x, y)) {
          amountWaterFound++;
        }
      }
    }
    return amountWaterFound >= amountOfWaterTiles;
  }
}
