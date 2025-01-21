<template>
  <div class="outerBuildingTimeModal scrollerFirefox">
    <div class="innerBuildingTimeModal" v-if="buildingList && hasConstructionBuildings()">
      <h2>Construction Times</h2>
      <div class="buildintTimerScrollContainer">
        <div v-for="building in buildingList" :key="building.buildingId" class="buildingTimers">
          <div v-if="building.isUnderConstruction" class="buildingTimeRow">
            <h3>{{ building.name }} to level {{ building.level + 1 }}</h3>
            <h3>{{ building.constructionTimeLeft }}</h3>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as moment from 'moment';
export default {
  computed: {
    buildingList: function () {
      if (this.$store.getters.buildingList === null) {
        return;
      }

      const buildings = this.$store.getters.buildingList.filter(
        (b) => b.isUnderConstruction === true,
      );

      return buildings.sort((a, b) => {
        return (
          moment.duration(a.constructionTimeLeft).asSeconds() -
          moment.duration(b.constructionTimeLeft).asSeconds()
        );
      });
    },
  },
  methods: {
    hasConstructionBuildings: function () {
      for (let i = 0; i < this.buildingList.length; i++) {
        if (this.buildingList[i].isUnderConstruction) {
          return true;
        }
      }
      return false;
    },
  },
};
</script>

<style lang="scss">
.outerBuildingTimeModal {
  display: flex;
  justify-content: flex-start;
  align-items: flex-start;
  user-select: none;
  flex-direction: column;
  .innerBuildingTimeModal {
    display: flex;
    justify-content: flex-start;
    flex-direction: column;
    align-items: center;
    margin-left: 56px;
    /*margin-top: 98px;*/
    margin-bottom: 40px;
    border: 7px solid transparent;
    border-image: url('../../../assets/borders_modal.png') 40% stretch;
    min-height: 140px;
    min-width: 210px;
    background-color: #434343;
    h2 {
      color: white;
      font-size: 17px;
    }
    h3 {
      margin-bottom: 0px;
      color: white;
      margin-right: 7px;
      font-size: 13px;
    }
    .buildintTimerScrollContainer {
      max-height: 210px;
      overflow: auto;
      text-align: center;
    }
    .buildingTimers {
      display: flex;
      justify-content: flex-start;
      align-content: flex-start;
      text-align: left;
    }
    .buildingTimeRow {
      display: flex;
      flex-direction: row;
      text-align: left;
      justify-self: flex-start !important;
      align-self: flex-start !important;
      justify-content: flex-start;
      align-content: flex-start;
    }
  }
}
</style>
