<template>
  <div class="clickableTile">
    <construction-tile v-if="buildingProperties.isUnderConstruction"></construction-tile>
    <img v-else class="tileImgHouse" :src="getTileSource()" />
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
          return require('../../assets/tiles/level_10/winter/storage_10.png');
        }
        return require('../../assets/winterTiles/storage.png');
      } else {
        if (this.isLevelTen()) {
          return require('../../assets/tiles/level_10/storage_10.png');
        }
        return require('../../assets/tiles/storage.png');
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

<style></style>
