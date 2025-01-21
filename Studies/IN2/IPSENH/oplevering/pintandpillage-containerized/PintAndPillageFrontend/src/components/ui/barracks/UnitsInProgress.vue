<template>
  <div v-if="building" class="unitQueue">
    <h1>{{ this.properties.title }}</h1>
    <div v-for="(unit, index) in building.productionQueue" :key="unit.key">
      <div :style="[index === 0 ? { color: 'green' } : { color: 'grey' }]" class="queueItem">
        <h2 style="margin-right: 14px">{{ index + 1 }}.</h2>
        <img
          :src="require('../../../assets/ui-items/' + unit.unitToProduce.unitName + '.png')"
          width="28px"
          height="28px"
        />
        <h2>
          {{ unit.unitToProduce.unitName }} -{{ unit.amountToProduce }} -
          {{ unit.totalTimeToProduce }}
          <!--                    <timer v-bind:time="unit.constructionTimeLeft"/>-->
        </h2>
      </div>
    </div>
    <p v-if="building.productionQueue.length == 0" style="text-align: center; font-size: 14px">
      No units being trained right now
    </p>
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
  },
};
</script>

<style lang="scss">
.unitQueue {
  min-width: 175px;
  margin-top: 35px;
  margin-right: 14px;
  height: 100%;
  background-color: #434343;
  border: 10.5px solid transparent;
  border-image: url('../../../assets/borders_modal.png') 40% stretch;
  h1 {
    text-align: center;
  }
  h2 {
    margin: 7px;
  }
  .queueItem {
    display: flex;
    flex-direction: row;
    margin-left: 28px;
    margin-bottom: 7px;
    align-items: center;
  }
}
</style>
