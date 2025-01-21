<template>
  <div
    :class="gridContainerClass"
    v-dragscroll
    @wheel="zoom($event)"
    :style="{ transform: 'scale(' + currentZoom + ')' }"
  >
    <div class="gridContainer">
      <div class="grid" v-if="grid">
        <div v-for="(cellLength, i) in gridLength" :key="cellLength.key" class="row">
          <div v-for="(cellWidth, j) in gridWidth" :key="cellWidth.key" class="tile">
            <component
              v-bind:is="grid[i][j].name"
              @click.native="showModal(grid[i][j])"
              :buildingProperties="grid[i][j]"
            ></component>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import decorativeTiles from '../jsons/DecorativeTiles';
import wallTiles from '../jsons/WallTiles';

export default {
  data: function () {
    return {
      gridWidth: 15,
      gridLength: 15,
      grid: null,
      gridContainerClass: 'gridContainer',
      decorativeTiles: decorativeTiles,
      wallTiles: wallTiles,
      unclickableTiles: [
        'BaseTile',
        'WaterTile',
        'WaterCornerTile',
        'WallLeft',
        'WallLeftEnd',
        'WallRight',
        'WallRightEnd',
        'NatureForest_1',
        'NatureForest_2',
      ],
    };
  },
  computed: {
    village: function () {
      return this.$store.getters.village;
    },
    currentZoom: function () {
      return this.$store.getters.zoomState;
    },
    zoomPerStep: function () {
      return this.$store.getters.zoomPerStep;
    },
  },
  watch: {
    village: function (village) {
      this.buildGrid(village);
    },
  },
  created: function () {
    if (this.village) {
      this.buildGrid(this.village);
    }
  },
  methods: {
    buildGrid: function (village) {
      this.grid = [];
      this.buildBaseTiles(village);
      this.buildBuildingSpots(village);
      this.buildBuildingTiles(village);
      this.buildDecorativeTiles(village);
      this.checkIfWallShouldBeShown(village);
    },
    checkIfWallShouldBeShown: function (village) {
      for (let i = 0; i < village.buildings.length; i++) {
        if (village.buildings[i].name === 'Wall' && village.buildings[i].level > 0) {
          this.showWall();
          break;
        }
      }
    },
    buildBaseTiles: function () {
      for (let y = 0; y <= this.gridLength; y++) {
        const rowList = [];
        for (let x = 0; x <= this.gridWidth; x++) {
          rowList.push({ name: 'BaseTile', position: { x: x, y: y } });
        }
        this.grid.push(rowList);
      }
    },
    buildBuildingTiles: function (village) {
      const buildingList = village.buildings;
      for (let i = 0; i < buildingList.length; i++) {
        this.grid[buildingList[i].position.y][buildingList[i].position.x] = buildingList[i];
      }
    },
    buildBuildingSpots: function (village) {
      this.setBuildingTiles(village.validBuildPositions);
    },
    buildDecorativeTiles: function () {
      this.setBuildingTiles(this.decorativeTiles);
    },
    showWall: function () {
      this.setBuildingTiles(this.wallTiles);
    },
    setBuildingTiles: function (tileSet) {
      for (let i = 0; i < tileSet.length; i++) {
        this.grid[tileSet[i].position.y][tileSet[i].position.x] = tileSet[i];
      }
    },
    showModal: function (currentTile) {
      for (let i = 0; i < this.unclickableTiles.length; i++) {
        if (currentTile.name === this.unclickableTiles[i]) {
          return false;
        }
      }
      this.$emit('toggleModal', currentTile);
    },
    zoom: function (zoomEvent) {
      const deltaY = zoomEvent.deltaY;
      if (deltaY < 0) {
        this.$store.dispatch('updateZoomState', this.currentZoom + this.zoomPerStep);
      } else if (deltaY > 0) {
        this.$store.dispatch('updateZoomState', this.currentZoom - this.zoomPerStep);
      }
    },
  },
};
</script>

<style>
.gridContainer {
  height: 100%;
  width: 100%;
  background-color: #507f7d;
  transform-origin: center;
  display: flex;
  justify-content: center;
  align-items: center;
  position: fixed;
  cursor: grab;
}
.grid {
  margin-top: 120px;
  -webkit-transform: rotateX(65deg) rotateZ(45deg);
  box-shadow: 80px 80px 50px rgb(70, 70, 70);
}
.tile {
  position: relative;
  max-width: 200px;
  max-height: 200px;
}

.row {
  position: relative;
  display: flex;
  flex-direction: row;
}
</style>
