<template>
  <div class="smithContainer scrollerFirefox">
    <div class="smithTitle">
      <h1>{{ building.name }} - Lv {{ building.level }}</h1>
      <hr width="70%" style="margin-bottom: 20px" />
    </div>
    <div class="researchContainer">
      <div class="researchBoxesContainer">
        <research-box
          v-for="research in researches"
          :key="research.key"
          :building="building"
          :research="research"
          :building-id="buildingId"
          :building-level="building.level"
        ></research-box>
      </div>
    </div>
    <level-up-building @close="close" :buildingId="buildingId"></level-up-building>
  </div>
</template>

<script>
export default {
  props: ['buildingId'],
  computed: {
    building: function () {
      return this.$store.getters.building(this.buildingId);
    },
    researches: function () {
      return this.$store.getters.village.availableResearches;
    },
  },
  methods: {
    close: function () {
      this.$emit('close');
    },
  },
};
</script>

<style lang="scss">
.smithContainer {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  width: 100%;
  .smithTitle {
    width: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }
  .researchContainer {
    max-height: 420px;
    min-height: 450px;
    max-width: 840px;
    margin-right: 56px;
    margin-left: 56px;
    overflow: auto;
    .researchBoxesContainer {
      display: flex;
      width: 770px;
      justify-content: flex-start;
      flex-direction: row;
      flex-wrap: wrap;
      flex-flow: row wrap;
      align-content: flex-end;
      margin-left: 35px;
    }
  }
}
</style>
