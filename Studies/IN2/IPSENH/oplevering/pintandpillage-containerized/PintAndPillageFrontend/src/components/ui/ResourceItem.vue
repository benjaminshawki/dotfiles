<template>
  <div class="resourceItemContainer">
    <div class="resourceItem" v-for="(value, key) in resources" :key="value.key">
      <div
        aria-disabled="true"
        class="resourceDetails"
        v-tooltip.bottom-center="getResourchesPerHour(key)"
      >
        <img class="resourceImg" v-bind:src="require('../../assets/ui-items/' + key + '.png')" />
        <p
          v-if="checkAvailability"
          :style="{ color: hasEnoughResources(key, value) ? 'white' : 'red' }"
        >
          {{ value }}
        </p>
        <p v-else :style="{ color: hasEnoughStorage(key, value) ? 'yellow' : 'white' }">
          {{ value }}
        </p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['resources', 'displayTooltip', 'checkAvailability'],
  name: 'ResourceItem',
  data: function () {
    return {
      msg: null,
      isMobile: false,
    };
  },
  computed: {
    village: function () {
      return this.$store.getters.village;
    },
  },
  methods: {
    hasEnoughResources: function (type, amount) {
      if (this.village) {
        return this.village.villageResources[type] >= amount;
      }
      return true;
    },
    hasEnoughStorage: function (type) {
      if (this.village) {
        return this.village.villageResources[type] === this.village.resourceLimit;
      }
    },
    getResourchesPerHour: function (resource) {
      if (!this.displayTooltip) {
        return;
      }
      const resourcesPerHourDictionary = this.village.resourcesPerHour;
      const resourceLimit = this.village.resourceLimit;
      for (const key in resourcesPerHourDictionary) {
        if (key === resource) {
          const resourcesPerHourString =
            resourcesPerHourDictionary[key] + ' ' + resource + ' ' + 'per hour - ';
          const combinedResourcesLimitAndPerHour =
            resourcesPerHourString + '\n' + 'Resource Max: ' + resourceLimit;
          return combinedResourcesLimitAndPerHour;
        }
      }
      return 'No current resource production';
    },
  },
};
</script>

<style lang="scss">
.resourceItemContainer {
  display: flex;
  flex-direction: row;
}
.resourceItem {
  display: flex;
  flex-direction: row;
  max-width: 140px;
  margin-right: 5px;
  user-select: none;
  .resourceDetails {
    display: flex;
    flex-direction: row;
    z-index: 10;
    justify-content: flex-start;
    align-items: center;
    width: 85px;
    height: 23px;
    background-color: rgb(104, 104, 104);
    border: 5px solid transparent;
    border-image: url('../../assets/borders_modal.png') 40% stretch;
    p {
      color: white;
      font-size: 14px;
      margin-left: 5px;
      filter: none !important;
    }
    p.notEnoughResources {
      color: red !important;
      filter: none !important;
    }
    .resourceImg {
      margin-left: 5px;
      width: 20px;
      height: 20px;
    }
  }
}
</style>
