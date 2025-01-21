<template>
  <div class="worldMapBackground">
    <div style="position: absolute; top: 140px; left: 42%; color: white">
      <h1>Loading World Map...</h1>
    </div>
    <div class="gridContainer2" v-if="renderedWorldmapTiles" v-dragscroll>
      <div>
        <div class="worldRow" v-for="(cellLength, y) in renderedWorldmapTiles.length" :key="y">
          <div
            class="worldTile"
            v-for="(cellWidth, x) in renderedWorldmapTiles[0].length"
            :key="x + '_' + y"
          >
            <img
              @click="openModal(x, y)"
              class="villageTile"
              v-if="renderedWorldmapTiles[x][y].village"
              :src="require('../assets/worldmap/' + renderedWorldmapTiles[x][y].village + '.png')"
            />
            <img
              class="tileWorldMap"
              height="30"
              :src="require('../assets/worldmap/' + renderedWorldmapTiles[x][y].tileType + '.png')"
            />
            <span v-if="renderedWorldmapTiles[x][y].Settleable">
              <img
                @click="buildNewVillageModal(x, y)"
                class="tileWorldMap SettleableTile"
                v-show="showSettleTiles"
                src="../assets/worldmap/SettleIconWorldMap.png"
              />
            </span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
/* eslint-disable no-console */
export default {
  name: 'WorldMap',
  data() {
    return {
      worldMapTiles: null,
      worldMap: null,
      renderedWorldmapTiles: null,
      currentZoom: 0.8,
      windowHeight: 0,
      width: 0,
      villages: [],
    };
  },
  watch: {
    SettleableSpots(SettleableSpots) {
      console.log(SettleableSpots);
      for (let x = 0; x < this.worldMapTiles.length; x++) {
        for (let y = 0; y < this.worldMapTiles[0].length; y++) {
          this.renderedWorldmapTiles[x][y].Settleable = false;
        }
      }
      SettleableSpots.forEach((c) => {
        this.renderedWorldmapTiles[c.x][c.y].Settleable = true;
      });
      this.$forceUpdate();
    },
  },
  created: function () {
    this.loadWorldMap();
  },
  computed: {
    village: function () {
      return this.$store.getters.village;
    },
    villageList: function () {
      return this.$store.getters.villageList;
    },
    showSettleTiles: function () {
      return this.$store.getters.showSettleTiles;
    },
    SettleableSpots() {
      return this.$store.getters.SettleableSpots;
    },
  },
  methods: {
    loadWorldMap: function () {
      this.$store.dispatch('getWorldmap').then((w) => {
        this.worldMapTiles = w.data.worldTiles;
        this.worldMap = w.data;
        this.buildVillages();
        this.buildWorldmap();
      });
    },
    async buildWorldmap() {
      const renderedWorldmap = [];

      for (let x = 0; x < this.worldMapTiles.length; x++) {
        renderedWorldmap[x] = [];
        for (let y = 0; y < this.worldMapTiles[0].length; y++) {
          renderedWorldmap[x][y] = {};
          renderedWorldmap[x][y].tileType = this.worldMapTiles[x][y].tileType;

          if (renderedWorldmap[x][y].tileType === 'Grass') {
            renderedWorldmap[x][y].tileType = this.getGrassTile(x, y);
          }
        }
      }

      this.SettleableSpots.forEach((c) => {
        renderedWorldmap[c.x][c.y].Settleable = true;
      });

      this.worldMap.villages.forEach((v) => {
        renderedWorldmap[v.position.x][v.position.y].village = this.checkIsOwnVillage(
          v.positionX,
          v.positionY,
        );
      });

      this.renderedWorldmapTiles = renderedWorldmap;
    },
    buildVillages: function () {
      this.villages = this.worldMap.villages;
      for (let i = 0; i < this.villages.length; i++) {
        this.worldMapTiles[this.villages[i].position.x][this.villages[i].position.y] = {
          tileType: 'Grass',
          x: this.villages[i].position.x,
          y: this.villages[i].position.y,
        };
      }
    },
    getVillage: function (x, y) {
      let villageName = 'Village';
      for (let i = 0; i < this.villages.length; i++) {
        if (this.villages[i].position.x === x && this.villages[i].position.y === y) {
          villageName = this.checkIsOwnVillage(x, y);
        }
      }
      return villageName;
    },
    getTileName: function (x, y) {
      const tile = this.worldMapTiles[x][y].tileType;
      if (tile === 'Grass') {
        return 'LandTileWorldMap';
      }
      return 'SeaTileWorldMap';
    },
    getGrassTile: function (x, y) {
      const tile = this.worldMapTiles[x][y];
      if (tile.tileType !== 'Grass') {
        return '';
      }
      let baseString = 'Grass_';
      baseString += this.addPartToGrassTile('N', x, y - 1);
      baseString += this.addPartToGrassTile('E', x + 1, y);
      baseString += this.addPartToGrassTile('S', x, y + 1);
      baseString += this.addPartToGrassTile('W', x - 1, y);
      return baseString;
    },
    addPartToGrassTile(directionName, x, y) {
      if (x < 0 || y < 0 || x >= this.worldMapTiles.length || y >= this.worldMapTiles[0].length) {
        return '';
      }
      const tile = this.worldMapTiles[x][y];
      if (tile == null) {
        return '';
      }
      if (tile.tileType === 'Water') {
        return directionName;
      }
      return '';
    },
    openModal: function (x, y) {
      const villages = this.worldMap.villages;
      for (let i = 0; i < villages.length; i++) {
        if (villages[i].position.x === x && villages[i].position.y === y) {
          const modalVariables = { name: 'Village', properties: villages[i] };
          this.$emit('toggleModal', modalVariables);
        }
      }
    },
    canSettle: function (x, y) {
      let tileName = null;
      this.SettleableSpots.forEach((item) => {
        if (item.position.x === x && item.position.y === y) {
          tileName = 'SettleTileWorldMap';
        }
      });
      return tileName;
    },
    buildNewVillageModal: function (x, y) {
      console.log(x, y);
      const modalProperties = { jarl: this.getJarlInVillage(), tileData: this.worldMapTiles[x][y] };
      const modal = { name: 'Settle', properties: modalProperties };
      this.$emit('toggleModal', modal);
    },
    checkCoastlineTile: function (x, y) {
      return this.getGrassTile(x, y) !== 'Grass_' && this.getGrassTile(x, y) !== '';
    },
    checkInVillageRange: function (x, y) {
      if (this.village) {
        const currentVillageX = this.village.position.x;
        const currentVillageY = this.village.position.y;
        const maxTileDistance = 4;
        if (
          Math.abs(currentVillageX - x) > maxTileDistance ||
          Math.abs(currentVillageY - y) > maxTileDistance
        ) {
          return false;
        }
        return true;
      }
    },
    checkAvailableJarl: function () {
      const jarl = this.getJarlInVillage();
      if (jarl.amount > 0) {
        return true;
      }
      return false;
    },
    checkIsOwnVillage: function (currentTileX, currentTileY) {
      let i = 0;

      if (!this.village) {
        return 'Village';
      }

      const selectedVillageId = this.village.villageId;
      for (i; i < this.villageList.length; i++) {
        if (
          this.villageList[i].positionX === currentTileX &&
          this.villageList[i].positionY === currentTileY
        ) {
          if (this.villageList[i].villageId === selectedVillageId) {
            return 'SelectedVillage';
          }
          return 'OwnVillage';
        }
      }
      return 'Village';
    },
    getJarlInVillage: function () {
      const unitsInVillage = this.village.unitsInVillage;
      for (let i = 0; i < unitsInVillage.length; i++) {
        if (unitsInVillage[i].unit.unitName === 'Jarl') {
          return unitsInVillage[i];
        }
      }
    },
  },
};
</script>

<style scoped lang="scss">
.worldMapBackground {
}
.gridContainer2 {
  user-select: none;
  cursor: grab;
  height: 100%;
  width: 100%;
  overflow: hidden;
  background-color: #1f666e;
  display: flex;
  position: fixed;
  margin-top: 70px;
}
.worldRow {
  position: relative;
  display: flex;
  flex-direction: row;
}
.tileWorldMap {
  position: absolute;
  width: 40px;
  height: 40px;
}
.villageTile {
  z-index: 1;
  position: absolute;
  cursor: pointer;
  width: 40px;
  height: 40px;
}
.worldTile {
  max-width: 100px;
  max-height: 100px;
  height: 40px;
  width: 40px;
}
.VillageTileWorldMap {
  cursor: pointer;
  z-index: 100;
  position: absolute;
}
.canSettle {
  cursor: pointer;
  z-index: 99;
  position: absolute;
}
.SettleableTile {
  z-index: 100;
}
</style>
