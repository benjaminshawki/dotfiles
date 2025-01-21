<template>
  <div class="clickableTile">
    <construction-tile v-if="buildingProperties.isUnderConstruction"></construction-tile>
    <img v-else class="headQuarters" :src="getTileSource()" />
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
        return require('../../assets/winterTiles/headquarters.png');
      } else {
        return require('../../assets/tiles/headquarters.png');
      }
    },
  },
};
</script>

<style>
.headQuarters {
  position: relative;
  top: -260px;
  left: -450px;
  width: 700px;
  height: 500px;
  pointer-events: none;
  user-select: none;
}
</style>
