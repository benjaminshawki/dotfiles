<template>
  <div :class="{ disabledOverlay: !canRecruit() }" style="margin-bottom: 14px">
    <div class="unitContainer">
      <div class="unitImage">
        <img
          :src="require('../../../assets/ui-items/' + unit.unit.unitName + '.png')"
          width="77px"
          height="70px"
        />
        <div class="unitsInStore">
          <p>{{ getUnitAmount(unit.unit.unitName) }}</p>
        </div>
      </div>
      <div class="unitDescription">
        <h1>{{ unit.unit.unitName }}</h1>
        <h2>{{ unit.unit.description }}</h2>
        <p>
          Attack: {{ unit.unit.attack }} - Defence: {{ unit.unit.defence }} - Health:
          {{ unit.unit.health }} - Speed: {{ unit.unit.speed }}
        </p>
        <div class="sliderDiv">
          <input
            :disabled="!canRecruit()"
            type="range"
            min="1"
            :max="unitMaxProduce"
            :value="sliderValue"
            class="slider"
            v-on:input="updateSliderValue($event)"
          />
          <div class="unitInputContainer">
            <input
              :disabled="!canRecruit()"
              type="number"
              min="1"
              class="unitInput"
              :value="sliderValue"
              v-on:input="updateSliderValue($event)"
              @keypress="validateNumberInput(unitMaxProduce, $event)"
            />
          </div>
          <button :disabled="!canRecruit()" @click="createUnit" @keyup.enter="close()">
            Train
          </button>
        </div>
        <div class="unitResources">
          <resource-item
            :checkAvailability="checkAvailability"
            class="resourceItemComp"
            :resources="unit.unit.resourcesRequiredToProduce"
            :displayTooltip="false"
          ></resource-item>
          <population-frame
            class="populationFrameComp"
            :population-left="unit.unit.populationRequiredPerUnit"
          ></population-frame>
          <time-frame class="timeComp" :required-time="unit.unit.baseTimeToProduce"></time-frame>
        </div>
        <h2 class="unitLevelRequirements" v-if="!unitLevelRequirementMet().requirementMet">
          Unit requires {{ building.name }} level {{ unitLevelRequirementMet().buildingLevel }}
        </h2>
        <h2 class="unitResearchRequirements" v-if="!unitResearchRequirementMet().requirementMet">
          Unit requires research {{ unitResearchRequirementMet().research }}
        </h2>
      </div>
    </div>
    <hr width="80%" />
  </div>
</template>

<script>
export default {
  props: ['unit', 'building', 'unitUnlockList'],
  data: function () {
    return {
      sliderValue: 0,
      checkAvailability: true,
    };
  },
  created() {
    console.log(this.unit);
  },
  computed: {
    village: function () {
      return this.$store.getters.village;
    },
    villageResources: function () {
      return this.$store.getters.village.villageResources;
    },
    villagePopulationLeft: function () {
      return this.$store.getters.village.populationLeft;
    },
    unitMaxProduce: function () {
      let currentMax = Number.MAX_SAFE_INTEGER;
      for (const resourceName in this.unit.unit.resourcesRequiredToProduce) {
        if (this.villageResources[resourceName]) {
          const tempMax =
            this.villageResources[resourceName] /
            this.unit.unit.resourcesRequiredToProduce[resourceName];
          currentMax = Math.min(currentMax, tempMax);
        } else {
          return 0;
        }
      }
      const tempMaxPopulation =
        this.villagePopulationLeft / this.unit.unit.populationRequiredPerUnit;
      currentMax = Math.min(currentMax, tempMaxPopulation);
      return currentMax;
    },
  },
  methods: {
    createUnit: function () {
      if (this.sliderValue > 0) {
        const unitToCreate = {
          productionBuildingId: this.building.buildingId,
          unitType: this.unit.unit.unitName,
          amount: this.sliderValue,
        };
        this.$store
          .dispatch('createUnit', unitToCreate)
          .then(() => {
            this.$toaster.success('Unit production started!');
            this.resetInput();
          })
          .catch((err) => {
            this.$toaster.error(err.response.data.error);
          });
      }
    },
    resetInput: function () {
      this.sliderValue = 0;
    },
    canRecruit: function () {
      if (!this.unitLevelRequirementMet().requirementMet) {
        return false;
      } else if (!this.unitResearchRequirementMet().requirementMet) {
        return false;
      } else if (this.unitMaxProduce === 0) {
        return false;
      }
      return true;
    },
    unitLevelRequirementMet: function () {
      const unitName = this.unit.unit.unitName;
      for (let i = 0; i < this.unitUnlockList.length; i++) {
        if (
          this.unitUnlockList[i].unitType === unitName &&
          this.unitUnlockList[i].level > this.building.level
        ) {
          return { requirementMet: false, buildingLevel: this.unitUnlockList[i].level };
        }
      }
      return { requirementMet: true, buildingLevel: null };
    },
    unitResearchRequirementMet: function () {
      const requiredResearch = this.unit.unit.researchRequired;
      const completedResearches = this.village.completedResearches;
      if (requiredResearch === 'None') {
        return { requirementMet: true, research: null };
      }
      for (let i = 0; i < completedResearches.length; i++) {
        if (completedResearches[i].researchName === requiredResearch) {
          return { requirementMet: true, research: null };
        }
      }
      return { requirementMet: false, research: this.unit.unit.researchRequired };
    },
    updateSliderValue: function (event) {
      this.sliderValue = event.target.value;
    },
    getUnitAmount: function (unitName) {
      const unitsList = this.village.unitsInVillage;
      for (let i = 0; i < unitsList.length; i++) {
        if (unitsList[i].unit.unitName === unitName) {
          return unitsList[i].amount;
        }
      }
      return 0;
    },
  },
};
</script>

<style lang="scss">
.disabledOverlay {
  .resourceItemComp,
  .unitsInStore,
  .unitInputContainer,
  p,
  img,
  h1,
  h2,
  button,
  .populationFrameComp,
  .timeComp {
    filter: grayscale(1);
    color: #7f7f7f;
    -webkit-filter: grayscale(1);
  }
  button {
    color: #7f7f7f !important;
  }
}
.unitContainer {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  background-color: #434343;
  min-width: 595px;
  margin: 14px 0px 14px 14px;
  .unitDescription {
    min-width: 600px;
    .sliderDiv {
      display: flex;
      flex-direction: row;
      .slider {
        min-width: 210px;
        margin-right: 21px;
        background: inherit;
      }
      .unitInputContainer {
        max-height: 21px;
        min-width: 77px;
        width: 77px;
        border: 7px solid transparent;
        border-image: url('../../../assets/borders_modal.png') 40% stretch;
        color: white;
        display: flex;
        flex-direction: row;
        input {
          background-color: #7f7f7f;
          height: 21px;
          min-width: 77px;
          width: 77px;
          font-size: 17.5px;
          text-align: center;
          border: none;
          color: white;
        }
      }
    }

    .unitResources {
      display: flex;
      flex-direction: row;
      justify-content: flex-start;
      align-items: center;
      margin-top: 24px;
      p {
        margin-right: 14px;
      }
    }
    .unitLevelRequirements,
    .unitResearchRequirements {
      color: #da3c40 !important;
      filter: none !important;
    }
  }
  button {
    color: white;
    background-color: #15636c;
    border-radius: 3.5px;
    height: 35px;
    font-size: 14px;
    width: 105px;
    border: 2.8px solid #0f3b43;
    min-width: 105px;
    margin-left: 84px;
  }
  .unitImage {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    margin: 21px;
    .unitsInStore {
      width: 35px;
      height: 35px;
      text-align: center;
      font-size: 14px;
      background-image: url('../../../assets/ui-items/number_frame.png');
      background-size: 100% 100%;
      margin-top: 14px;
      padding: 2.7px;
      p {
        margin-top: 7px;
        margin-left: 3.5px;
        width: 28px;
      }
    }
  }
}
</style>
