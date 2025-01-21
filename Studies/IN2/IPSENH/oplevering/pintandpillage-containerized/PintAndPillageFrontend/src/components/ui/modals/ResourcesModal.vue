<template>
  <div class="resourceModalBackdrop">
    <div>
      <div class="resourceContainer" v-if="building.generatesResource">
        <img
          v-bind:src="require('../../../assets/ui-items/' + building.generatesResource + '.png')"
          width="77px"
          height="70px"
        />
        <div class="resourceTitleContainer">
          <h1 id="buildingName">{{ building.name }} - Lv {{ building.level }}</h1>
          <h2 id="buildingDescription">
            {{ building.resourcesPerHour }} {{ building.generatesResource }} / Hour
          </h2>
        </div>
      </div>
    </div>
    <level-up-building
      @close="close"
      @buildingFetched="building = $event"
      :buildingId="buildingId"
    ></level-up-building>
  </div>
</template>

<script>
export default {
  props: ['buildingId'],
  computed: {
    building: function () {
      return this.$store.getters.building(this.buildingId);
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
.resourceModalBackdrop {
  margin-top: 7px;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;

  .resourceContainer {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 56px;
    flex-direction: row;
    min-width: 315px;
    height: 105px;
    border: 14px solid transparent;
    border-image: url('../../../assets/borders_modal.png') 40% stretch;
    background-color: #434343;

    .resourceTitleContainer {
      margin-left: 28px;
      h1,
      h2 {
        margin-top: 0px;
        margin-bottom: 0px;
      }
    }
  }
}
</style>
