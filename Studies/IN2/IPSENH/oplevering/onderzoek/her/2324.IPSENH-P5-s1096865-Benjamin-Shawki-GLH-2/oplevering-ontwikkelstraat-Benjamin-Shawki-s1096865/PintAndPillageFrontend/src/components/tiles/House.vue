<template>
  <div class="clickableTile">
    <construction-tile v-if="buildingProperties.isUnderConstruction"></construction-tile>
    <img v-else class="tileImgHouse" :src="getTileSource()" />
  </div>
</template>

<script>
export default {
  props: ['buildingProperties'],
  computed: {
    seasonsOn: function () {
      return this.$store.state.seasonsEnabled;
    },
    currentSeason: function () {
      return this.$store.state.currentSeason;
    },
  },
  methods: {
    getTileSource: function () {
      if (this.seasonsOn && this.currentSeason === 'winter') {
        if (this.isLevelTen()) {
          return require('../../assets/tiles/level_10/winter/house_10.png');
        }
        return require('../../assets/winterTiles/house.png');
      } else {
        if (this.isLevelTen()) {
          return require('../../assets/tiles/level_10/house_10.png');
        }
        return require('../../assets/tiles/house.png');
      }
    },
    isLevelTen: function () {
      if (this.buildingProperties.level >= 10) {
        return true;
      }
      return false;
    },
  },
};
</script>

<style>
.clickableTile:hover {
  cursor: pointer;
}
.tileImgHouse {
  position: relative;
  top: -260px;
  left: -478px;
  width: 725px;
  height: 500px;
  pointer-events: none;
  user-select: none;
  z-index: 0;
}
</style>
