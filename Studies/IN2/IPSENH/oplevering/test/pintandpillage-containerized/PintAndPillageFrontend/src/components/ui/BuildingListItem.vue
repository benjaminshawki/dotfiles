<template>
  <div>
    <div class="buildingListItemContainer" :class="{ disabledOverlay: !canBeBuild() }">
      <img
        class="buildingIcon"
        v-bind:src="require('../../assets/buildingIcons/' + building.name + '.png')"
      />

      <div class="buildingInformationContainer">
        <h1>{{ building.name }}</h1>
        <p id="buildingDescription">{{ building.description }}</p>

        <div style="display: flex; flex-direction: row">
          <population-frame
            :checkAvailability="checkAvailability"
            :population-left="building.populationRequiredNextLevel"
          ></population-frame>
          <time-frame class="timeComp" :required-time="building.constructionTime"></time-frame>
        </div>

        <div class="resourcesContainer">
          <resource-item
            class="resourceItemComp"
            :checkAvailability="checkAvailability"
            :resources="building.resourcesRequiredLevelUp"
          ></resource-item>
        </div>

        <div v-for="(value, key) in building.buildingLevelRequiredToLevelup" :key="value.key">
          <h2 class="requirements" v-if="!hasBuildingRequirement(key, value)">
            Requires {{ key }} level {{ value }}
          </h2>
        </div>
      </div>

      <button :disabled="!canBeBuild()" @click="createBuilding(building.name)">Build</button>
    </div>

    <hr width="80%" />
  </div>
</template>

<script>
/* eslint-disable no-console */
export default {
  props: ['building', 'position'],
  computed: {
    village: function () {
      this.$forceUpdate();
      return this.$store.getters.village;
    },
  },
  data: function () {
    return {
      checkAvailability: true,
    };
  },
  methods: {
    createBuilding: function (inputvalue) {
      const villageId = this.village.villageId;
      this.$store
        .dispatch('createBuilding', {
          villageId: villageId,
          buildingType: inputvalue,
          position: { x: this.position.x, y: this.position.y },
        })
        .then(() => this.close());
    },
    close: function () {
      this.$emit('close');
    },
    canBeBuild: function () {
      for (const [resource, amount] of Object.entries(this.building.resourcesRequiredLevelUp)) {
        if (this.village.villageResources[resource] < amount) {
          return false;
        }
      }

      if (this.village.populationLeft < this.building.populationRequiredNextLevel) {
        return false;
      }

      let amountOfLevelrequirementsMet = 0;
      for (const [buildingType, level] of Object.entries(
        this.building.buildingLevelRequiredToLevelup,
      )) {
        amountOfLevelrequirementsMet += this.hasBuildingRequirement(buildingType, level);
      }
      if (
        amountOfLevelrequirementsMet !==
        Object.keys(this.building.buildingLevelRequiredToLevelup).length
      ) {
        return false;
      }
      return true;
    },
    hasBuildingRequirement(buildingName, level) {
      for (let i = 0; i < this.village.buildings.length; i++) {
        const building = this.village.buildings[i];
        if (building.name === buildingName && building.level >= level) {
          return true;
        }
      }
      return false;
    },
  },
};
</script>

<style></style>

<style lang="scss">
.disabledOverlay {
  #buildingDescription,
  img,
  h1,
  button {
    filter: grayscale(1);
    color: #7f7f7f;
    -webkit-filter: grayscale(1);
  }
  button {
    color: #7f7f7f !important;
  }
}
.buildingListItemContainer {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  margin-right: 91px;
  margin-left: 98px;
  margin-bottom: 20px;
  .buildingIcon {
    width: 245px;
    height: 210px;
    min-width: 245px;
    margin-right: 3.5%;
  }
  button {
    color: white;
    background-color: #15636c;
    border-radius: 3.5px;
    height: 35px;
    font-size: 14px;
    width: 150.5px;
    border: 2.8px solid #0f3b43;
    margin-left: 7%;
    min-width: 91px;
    max-width: 91px;
  }
  p {
    font-size: 14px;
  }
  .buildingInformationContainer {
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: flex-start;
    min-width: 280px;

    .resourcesContainer {
      display: flex;
      flex-direction: row;
      margin-top: 10px;
    }
    .requirements {
      color: #da3c40 !important;
      filter: none !important;
      margin-bottom: 5px;
      margin-top: 10px;
    }
  }
}
</style>
