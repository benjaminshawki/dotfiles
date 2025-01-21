<template>
  <div>
    <img class="leftWall" :src="getTileSource()" />
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
        return require('../../assets/winterTiles/Nature_tile_01.png');
      } else {
        return require('../../assets/tiles/Nature_tile_01.png');
      }
    },
  },
};
</script>

<style>
.leftWall {
  position: relative;
  top: -140px;
  left: -140px;
  width: 390px;
  height: 390px;
  pointer-events: none;
  user-select: none;
}
</style>
