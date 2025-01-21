<template>
  <div class="clickableTile">
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
        return require('../../assets/winterTiles/market.png');
      } else {
        return require('../../assets/tiles/market.png');
      }
    },
  },
};
</script>

<style></style>
