<template>
  <div>
    <img class="tileImg" :src="getTileSource()" />
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
        return require('../../assets/winterTiles/sea_tile_angled.png');
      } else {
        return require('../../assets/tiles/sea_tile_angled.png');
      }
    },
  },
};
</script>

<style></style>
