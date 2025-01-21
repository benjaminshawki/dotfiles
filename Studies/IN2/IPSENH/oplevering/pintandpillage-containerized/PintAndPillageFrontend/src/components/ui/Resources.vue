<template>
  <div>
    <div class="resourcesContainer" v-if="village">
      <resource-item :resources="village.villageResources" :displayTooltip="true"></resource-item>
      <population-frame
        :checkAvailability="checkAvailability"
        class="resourcesPopulationFrame"
        :population="village.population"
        :populationLeft="village.populationLeft"
      ></population-frame>
    </div>
  </div>
</template>

<script>
/* eslint-disable no-console */
import ResourceItem from './ResourceItem';
import PopulationFrame from './PopulationFrame';

export default {
  name: 'Resources',
  components: { PopulationFrame, ResourceItem },
  data: function () {
    return {
      checkAvailability: false,
    };
  },
  computed: {
    village: function () {
      return this.$store.getters.village;
    },
  },
};
</script>

<style lang="scss">
.resourcesContainer {
  display: flex;
  flex-direction: row;
  width: auto;
  justify-content: center;
  align-items: center;
}
</style>
