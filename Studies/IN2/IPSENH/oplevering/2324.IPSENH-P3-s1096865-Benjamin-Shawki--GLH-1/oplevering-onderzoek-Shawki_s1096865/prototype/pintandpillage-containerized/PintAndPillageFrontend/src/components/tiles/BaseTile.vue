<template>
  <div>
    <!--<img class="tileImg" v-bind:src="require('../../assets/tiles/tile_0' + getRandomTileNumber() + '.png')"/>-->
    <img class="tileImg" :src="getTileSource()" />
  </div>
</template>

<script>
/* eslint-disable no-console */
export default {
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
        return require('../../assets/winterTiles/blank_spot.png');
      } else {
        return require('../../assets/tiles/blank_spot.png');
      }
    },
  },
};
</script>

<style>
.tileImg {
  position: relative;
  top: -140px;
  left: -140px;
  width: 390px;
  height: 390px;
  pointer-events: none;
  user-select: none;
}
</style>
