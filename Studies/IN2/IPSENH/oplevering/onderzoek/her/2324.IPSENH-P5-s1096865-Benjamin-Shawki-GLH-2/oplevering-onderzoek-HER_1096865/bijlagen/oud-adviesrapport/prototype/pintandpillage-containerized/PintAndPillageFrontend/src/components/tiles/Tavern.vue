<template>
  <div class="clickableTile">
    <construction-tile v-if="buildingProperties.isUnderConstruction"></construction-tile>
    <img v-else class="tileImgTavern" :src="getTileSource()" />
  </div>
</template>

<script>
/* eslint-disable no-console */

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
          return require('../../assets/tiles/level_10/winter/tavern_10.png');
        }
        return require('../../assets/winterTiles/tavern.png');
      } else {
        if (this.isLevelTen()) {
          return require('../../assets/tiles/level_10/tavern_10.png');
        }
        return require('../../assets/tiles/tavern.png');
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
.tileImgTavern {
  position: relative;
  top: -260px;
  left: -480px;
  width: 728px;
  height: 500px;
  pointer-events: none;
  user-select: none;
}
</style>
