<template>
  <div>
    <construction-tile v-if="buildingProperties.isUnderConstruction"></construction-tile>
    <img v-else class="tileImg" :src="getTileSource()" />
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
          return require('../../assets/winterTiles/baracks.png');
        }
        return require('../../assets/tiles/level_10/winter/baracks_10.png');
      } else {
        if (this.isLevelTen()) {
          return require('../../assets/tiles/baracks.png');
        }
        return require('../../assets/tiles/level_10/baracks_10.png');
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
