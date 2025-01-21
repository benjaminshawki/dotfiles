<template>
  <div v-if="this.properties.villageData" class="scrollerFirefox">
    <ul v-if="unitMovementHasData()" class="unitMovementList">
      <h2 v-if="incomingAttacksHasData()" id="attackingYouTitle">
        Careful, you are about to be attacked by the following troops
      </h2>
      <li
        v-for="(attack, index) in this.properties.villageData.incomingAttacks"
        v-bind:key="'inAttack' + index"
      >
        <div class="travelingUnits">
          <div v-for="(unit, index) in attack.travelingUnits" v-bind:key="'inAttackUnit' + index">
            <p>{{ unit.unit.unitName }}: {{ unit.amount }}</p>
          </div>
        </div>
        <div class="travelAndArrow">
          <p>Traveltime: {{ attack.travelTimeLeft }}</p>
          <img
            class="TravelArrows"
            src="../../../assets/ui-items/arrows/incommingAttackArrow.png"
          />
        </div>
      </li>
      <h2 v-if="outgoingAttacksHasData()">Your attacking troops</h2>
      <li
        v-for="(attack, index) in this.properties.villageData.outgoingAttacks"
        v-bind:key="'outAttack' + index"
      >
        <div class="travelingUnits">
          <div v-for="(unit, index) in attack.travelingUnits" v-bind:key="'outAttackUnit' + index">
            <p>{{ unit.unit.unitName }}: {{ unit.amount }}</p>
          </div>
        </div>
        <div class="travelAndArrow">
          <p>Traveltime: {{ attack.travelTimeLeft }}</p>
          <img class="TravelArrows" src="../../../assets/ui-items/arrows/outgoingAttackArrow.png" />
        </div>
      </li>
      <h2 v-if="returningCombatTravelsHasData()">Your returning troops</h2>
      <li
        v-for="(travel, index) in this.properties.villageData.returningCombatTravels"
        v-bind:key="'travel' + index"
      >
        <ul class="resourcesTravelArrowAndUnits">
          <li>
            <div class="resources">
              <p>{{ travel.pillagedResources.Wood }}</p>
              <img src="../../../assets/ui-items/Wood.png" />
              <p>{{ travel.pillagedResources.Stone }}</p>
              <img src="../../../assets/ui-items/Stone.png" />
              <p>{{ travel.pillagedResources.Beer }}</p>
              <img src="../../../assets/ui-items/Beer.png" />
            </div>
            <div class="travelAndArrow">
              <p>Traveltime: {{ travel.travelTimeLeft }}</p>
              <img
                class="TravelArrows"
                src="../../../assets/ui-items/arrows/incommingOwnTroopsArrow.png"
              />
            </div>
          </li>
          <li class="units">
            <div class="travelingUnits">
              <div
                v-for="(unit, index) in travel.travelingUnits"
                v-bind:key="'travel-unit' + index"
              >
                <p>{{ unit.unit.unitName }}: {{ unit.amount }}</p>
              </div>
            </div>
          </li>
        </ul>
      </li>
    </ul>
    <p v-else class="logErrors">Nothing to be seen here</p>
  </div>
  <p v-else class="logErrors">Loading...</p>
</template>

<script>
export default {
  props: ['properties'],
  methods: {
    unitMovementHasData: function () {
      const villageData = this.properties.villageData;
      const dataAmount =
        villageData.incomingAttacks.length +
        villageData.outgoingAttacks.length +
        villageData.returningCombatTravels.length;
      return dataAmount > 0;
    },
    incomingAttacksHasData: function () {
      return this.properties.villageData.incomingAttacks.length > 0;
    },
    outgoingAttacksHasData: function () {
      return this.properties.villageData.outgoingAttacks.length > 0;
    },
    returningCombatTravelsHasData: function () {
      return this.properties.villageData.returningCombatTravels.length > 0;
    },
  },
};
</script>

<style lang="scss">
.unitMovementList {
  #attackingYouTitle {
    color: #ff0000;
  }
  list-style: none;
  height: 385px;
  width: 700px;
  overflow-y: auto;
  overflow-x: hidden;
  padding: 0;
  max-width: 700px;
  .travelingUnits {
    display: flex;
    max-width: 455px;
    overflow-x: auto;
    overflow-y: hidden;
  }
  .resourcesTravelArrowAndUnits {
    min-width: 100%;
    padding: 0;
    margin: 0;
    li {
      display: flex;
      border: none;
    }
    .resources {
      margin: 0;
      display: flex;
      img {
        width: 28px;
        height: 28px;
        margin: 0;
      }
    }
  }
  .travelAndArrow {
    margin: 0 0 0 auto;
    display: flex;
  }
  .TravelArrows {
    width: 48px;
    height: 28px;
    padding: 10.5px;
    margin: 1.4px;
  }
  li {
    display: flex;
    border: 10.5px solid transparent;
    padding: 1.4px;
    border-image: url('../../../assets/borders_modal.png') 40% stretch;
    p {
      font-size: 15.4px;
      padding: 10.5px;
      margin: 4px 1.4px 1.4px;
    }
  }
  h2 {
    text-align: center;
  }
}
</style>
