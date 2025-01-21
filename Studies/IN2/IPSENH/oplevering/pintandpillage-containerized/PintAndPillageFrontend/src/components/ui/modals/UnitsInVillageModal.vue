<template>
  <div class="outerUnitsModal scrollerFirefox">
    <div class="innerUnitsModal" v-if="checkForUnitsInVillage()">
      <h2>Units in village</h2>
      <div class="unitListContainer scrollerFirefox">
        <div v-for="unit in unitsList" :key="unit.id" class="unitDisplayList">
          <div v-if="unit.amount !== 0" class="unitDisplayList">
            <img
              :src="require('../../../assets/ui-items/' + unit.unit.unitName + '.png')"
              width="21px"
              height="17px"
            />
            <p>{{ unit.unit.unitName }} unit - Amount: {{ unit.amount }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  computed: {
    unitsList: function () {
      return this.$store.getters.unitsList;
    },
  },
  methods: {
    checkForUnitsInVillage: function () {
      if (this.unitsList) {
        if (this.unitsList.length !== 0) {
          return true;
        }
      }
      return false;
    },
  },
};
</script>

<style lang="scss">
.outerUnitsModal {
  display: flex;
  justify-content: flex-start;
  align-items: flex-start;
  user-select: none;
  flex-direction: column;
  max-width: 250px;
  min-width: 250px;
  .innerUnitsModal {
    display: flex;
    justify-content: flex-start;
    flex-direction: column;
    align-items: center;
    margin-left: 56px;
    /*margin-top: 40px;*/
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
    .unitListContainer {
      max-height: 210px;
      /*max-width: 310px;*/
      overflow: auto;
    }
    .unitDisplayList {
      text-align: left;
      display: flex;
      justify-self: left;
      align-self: flex-start;
      p {
        margin-left: 10px;
        margin-top: 0px;
        font-size: 12px;
        margin-right: 20px;
        color: white;
      }
      img {
        margin-left: 14px;
      }
    }
  }
}
</style>
