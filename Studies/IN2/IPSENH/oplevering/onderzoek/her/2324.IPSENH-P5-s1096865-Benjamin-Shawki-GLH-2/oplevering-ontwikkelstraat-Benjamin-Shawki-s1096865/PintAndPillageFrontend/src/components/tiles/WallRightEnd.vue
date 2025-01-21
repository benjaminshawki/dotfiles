<template>
  <div class="clickableTile">
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
        return require('../../assets/winterTiles/Wall_right_end.png');
      } else {
        return require('../../assets/tiles/Wall_right_end.png');
      }
    },
  },
};
</script>

<style></style>
