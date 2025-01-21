<template>
  <div class="clickableTile">
    <img class="tileImg" :src="getTileSource()" />
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
        return require('../../assets/winterTiles/building_spot.png');
      } else {
        return require('../../assets/tiles/building_spot.png');
      }
    },
  },
};
</script>

<style></style>
