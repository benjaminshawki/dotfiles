<template>
  <div>
    <div class="outerBarackContainer">
      <unit
        v-for="unit in unitList"
        :unit="unit"
        :building="building"
        :unitUnlockList="unitUnlockList"
        :key="unit.key"
      ></unit>
    </div>
  </div>
</template>

<script>
export default {
  props: ['properties'],
  computed: {
    building: function () {
      return this.$store.getters.building(this.properties.buildingId);
    },
    unitList: function () {
      return this.building.unlockedUnitsData;
    },
    unitUnlockList: function () {
      return this.building.unitsUnlockedAtLevel;
    },
  },
};
</script>

<style lang="scss">
.outerBarackContainer {
  min-width: 560px;
  min-height: 280px;
  max-height: 385px;
  overflow: auto;
  overflow-x: hidden;
  background-color: #434343;
  margin-top: 14px;
  border: 10.5px solid transparent;
  border-image: url('../../../assets/borders_modal.png') 40% stretch;
}
</style>
