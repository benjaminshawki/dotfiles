<template>
  <div :class="{ disabledResearchOverlay: !researchLevelRequirementMet() }">
    <div class="researchBox">
      <div class="researchTitle">
        <img
          :src="require('../../assets/ui-items/' + research.researchName + '.png')"
          width="35px"
          height="28px"
        />
        <h2>{{ research.researchName }}</h2>
      </div>
      <h3 v-if="!isThisResearchInProgress()">Research time: {{ research.secondsToResearch }}</h3>
      <h3 v-else>Time left: {{ building.researchTimeLeft }}</h3>
      <h3 v-if="research.researchLevel > 0">Research Level: {{ research.researchLevel }}</h3>
      <h3 v-else>Not researched yet</h3>
      <resource-item
        :checkAvailability="checkAvailability"
        class="researchResources"
        :resources="research.resourcesRequiredToResearch"
      ></resource-item>
      <p class="researchLevelRequirement" v-if="!hasHighEnoughBuildingLevel()">
        Research requires Smith level {{ research.buildingLevelRequirement }}
      </p>
      <button
        class="researchButton"
        v-if="!isThisResearchInProgress()"
        :disabled="!researchLevelRequirementMet() || building.isResearchInProgress"
        @click="startResearch(research.researchName)"
      >
        Start Research
      </button>
      <p v-else style="color: lightgreen; font-size: 14px">Research under progress</p>
    </div>
  </div>
</template>

<script>
export default {
  props: ['research', 'buildingLevel', 'buildingId', 'building'],
  data: function () {
    return {
      checkAvailability: true,
    };
  },
  methods: {
    researchLevelRequirementMet: function () {
      if (!this.hasHighEnoughBuildingLevel()) {
        return false;
      }

      const villageresources = this.$store.getters.resources;
      for (const [resource, amount] of Object.entries(this.research.resourcesRequiredToResearch)) {
        if (villageresources[resource] === null || villageresources[resource] < amount) {
          return false;
        }
      }

      return true;
    },
    isThisResearchInProgress: function () {
      if (!this.building.isResearchInProgress || !this.building.currentResearch) {
        return false;
      }
      return this.building.currentResearch.researchName === this.research.researchName;
    },
    hasHighEnoughBuildingLevel: function () {
      return this.research.buildingLevelRequirement <= this.buildingLevel;
    },
    startResearch: function (researchType) {
      const research = { researchBuildingId: this.buildingId, researchType: researchType };
      this.$store.dispatch('startResearch', research).then(() => {
        this.$toaster.success('Research Started!');
      });
    },
  },
};
</script>

<style lang="scss">
.disabledResearchOverlay {
  img,
  h1,
  button,
  h3,
  h2 {
    filter: grayscale(1);
    color: #7f7f7f;
    -webkit-filter: grayscale(1);
  }
  button {
    color: #7f7f7f !important;
  }
  .researchLevelRequirement {
    color: #da3c40;
  }
}
.researchBox {
  width: 340px;
  height: 210px;
  border: 7px solid transparent;
  border-image: url('../../assets/borders_modal.png') 40% stretch;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  /*margin: 14px;*/
  margin-left: 14px;
  margin-bottom: 14px;
  background-color: #434343;
  .researchTitle {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
  }
  .researchResources {
  }
  img {
    margin-right: 7px;
  }
  h3 {
    margin-top: 0px;
  }
  .researchButton {
    color: white;
    background-color: #15636c;
    border-radius: 3.5px;
    height: 35px;
    font-size: 12.6px;
    width: 84px;
    border: 2.8px solid #0f3b43;
    min-width: 105px;
    margin: 14px;
  }
  .researchLevelRequirement {
    color: #d71c1f;
    margin-bottom: 0px;
    font-size: 14px;
  }
}
</style>
