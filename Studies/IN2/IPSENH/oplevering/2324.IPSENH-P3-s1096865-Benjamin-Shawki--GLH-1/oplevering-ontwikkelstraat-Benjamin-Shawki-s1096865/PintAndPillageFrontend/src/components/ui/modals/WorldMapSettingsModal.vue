<template>
  <div class="worldMapSettingsButtonContainer">
    <div class="showSettleTiles" @click="toggleSettleTiles">
      <p v-if="!showSettleTiles">Show settle tiles</p>
      <p v-else>Hide settle tiles</p>
    </div>
  </div>
</template>

<script>
export default {
  computed: {
    village: function () {
      return this.$store.getters.village;
    },
    showSettleTiles: function () {
      return this.$store.getters.showSettleTiles;
    },
  },
  mounted() {
    this.$store.dispatch('turnShowSettleTilesOff');
  },
  methods: {
    toggleSettleTiles: function () {
      this.$store.dispatch('toggleSettleTiles', this.village.villageId).then(() => {
        this.$toaster.success('Updated world map');
      });
    },
  },
};
</script>

<style lang="scss" scoped>
.worldMapSettingsButtonContainer {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: row;

  .showSettleTiles {
    border: 5px solid transparent;
    background-color: rgb(104, 104, 104);
    border-image: url('../../../assets/borders_modal.png') 40% stretch;
    min-width: 40px;
    height: 40px;
    color: white;
    margin: 5px;
    display: flex;
    justify-content: center;
    align-items: center;
    p {
      font-size: 18px;
      margin: 0;
      padding: 10px;
    }
  }
  .showSettleTiles:hover {
    opacity: 0.8;
  }
}
</style>
