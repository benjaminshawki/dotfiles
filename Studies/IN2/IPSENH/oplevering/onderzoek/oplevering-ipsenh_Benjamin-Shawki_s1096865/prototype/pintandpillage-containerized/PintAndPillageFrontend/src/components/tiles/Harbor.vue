<template>
  <div class="clickableTile">
    <construction-tile v-if="buildingProperties.isUnderConstruction"></construction-tile>
    <img v-else class="harbor" :src="getTileSource()" />
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
          return require('../../assets/tiles/level_10/winter/harbor_10.png');
        }
        return require('../../assets/winterTiles/harbor.png');
      } else {
        if (this.isLevelTen()) {
          return require('../../assets/tiles/level_10/harbor_10.png');
        }
        return require('../../assets/tiles/harbor.png');
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
.harbor {
  position: relative;
  top: -260px;
  left: -88px;
  width: 700px;
  height: 500px;
  pointer-events: none;
  user-select: none;
  z-index: 1;
}
</style>
