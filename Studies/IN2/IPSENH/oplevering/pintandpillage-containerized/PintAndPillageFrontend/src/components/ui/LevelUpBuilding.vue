<template>
  <div class="buildingLevelContainer">
    <div class="updateContainer">
      <div class="notInProgress" v-if="!currentBuilding.isUnderConstruction">
        <!--                <h2>Next level +20 {{currentBuilding.generatesResource.toLowerCase()}}</h2>-->
        <div class="levelUpInfoContainer">
          <button class="removeButton" @click="removeBuilding">Remove</button>
          <div class="altResources">
            <!--<p>time : {{currentBuilding.constructionTime}}</p>-->
            <time-frame :required-time="currentBuilding.constructionTime"></time-frame>
            <population-frame
              :checkAvailability="checkAvailability"
              :populationLeft="currentBuilding.populationRequiredNextLevel"
            ></population-frame>
          </div>
          <resource-item
            :checkAvailability="checkAvailability"
            :resources="currentBuilding.resourcesRequiredLevelUp"
            :displayTooltip="false"
          ></resource-item>
          <button :disabled="!canBeLeveledUp()" @click="updateBuilding">Level Up</button>
        </div>
      </div>
      <div v-else class="underConstruction">
        <time-frame :required-time="currentBuilding.constructionTimeLeft"></time-frame>
        <p>Building is under construction</p>
      </div>
    </div>
  </div>
</template>

<script>
/* eslint-disable no-console */
export default {
  props: ['buildingId'],
  name: 'BuildingLevel',
  data: function () {
    return {
      checkAvailability: true,
    };
  },
  computed: {
    currentBuilding: function () {
      return this.$store.getters.building(this.buildingId);
    },
  },
  methods: {
    canBeLeveledUp: function () {
      if (this.currentBuilding.isUnderConstruction) {
        return false;
      }

      const villageresources = this.$store.state.village.data.villageResources;
      for (const [resource, amount] of Object.entries(
        this.currentBuilding.resourcesRequiredLevelUp,
      )) {
        if (villageresources[resource] == null || villageresources[resource] < amount) {
          return false;
        }
      }

      const populationLeft = this.$store.state.village.data.populationLeft;
      if (populationLeft < this.currentBuilding.populationRequiredNextLevel) {
        return false;
      }

      return true;
    },
    updateBuilding: function () {
      this.$store.dispatch('updateBuilding', this.currentBuilding.buildingId).then(() => {
        this.close();
      });
    },
    removeBuilding: function () {
      this.$dialog
        .confirm(
          'Are you sure you want to delete the level ' +
            this.currentBuilding.level +
            ' ' +
            this.currentBuilding.name +
            '?' +
            'This action cannot be undone and no resources will be returned',
        )
        .then(() => {
          this.$store.dispatch('removeBuilding', this.currentBuilding.buildingId).then(() => {
            this.close();
          });
        });
    },
    nextLevelBonus: function () {
      console.log(this.currentBuilding);
    },
    close: function () {
      this.$emit('close');
    },
  },
};
</script>

<style lang="scss">
.dg-btn--ok {
  background-color: red !important;
  border: red !important;
  color: white !important;
}

.buildingLevelContainer {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-left: 63px;
  margin-right: 56px;
  height: 80px;
  background-color: #434343;
  border: 11px solid transparent;
  border-image: url('../../assets/borders_modal.png') 40% stretch;
  .updateContainer {
    display: flex;
    flex-direction: row;
    justify-content: flex-end;
    align-items: center;
    margin-right: 14px;
    margin-top: 14px;

    .notInProgress {
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      h2 {
        margin-top: 0px;
        margin-bottom: 10px;
        color: #e1ba0d;
      }
      .levelUpInfoContainer {
        display: flex;
        flex-direction: row;
        margin-bottom: 10px;
        button {
          color: white;
          background-color: #15636c;
          border-radius: 3.5px;
          height: 35px;
          font-size: 14px;
          width: 105px;
          border: 2.8px solid #0f3b43;
          min-width: 105px;
          margin-right: 35px;
        }

        p {
          margin-right: 14px;
          font-size: 14px;
        }
        .altResources {
          margin-left: 10px;
          display: flex;
          flex-direction: row;
        }
        .removeButton {
          background-color: #600000;
          border: 3px solid #7d0000;
          margin-right: 0px;
          margin-left: 35px;
        }
      }
    }
  }
}
.underConstruction {
  text-align: center;
  min-width: 770px;
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
