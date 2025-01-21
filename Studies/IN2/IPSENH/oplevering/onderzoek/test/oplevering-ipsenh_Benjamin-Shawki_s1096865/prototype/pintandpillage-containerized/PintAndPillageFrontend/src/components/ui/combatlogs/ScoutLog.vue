<template>
  <div v-if="item">
    <h1>{{ userWon ? 'You WON!' : 'You LOST!' }}</h1>
    <div class="unitsFight">
      <unit-block
        :unitTypes="unitTypes"
        :startUnits="item.attackLog.startAttackingUnits"
        :leftUnits="item.attackLog.leftAttackingUnits"
        attackerOrDefender="Attacker"
        :villageName="item.attackingVillageName"
        :username="item.attackingUsername"
      ></unit-block>

      <div>
        <unit-block
          :unitTypes="unitTypes"
          :startUnits="item.attackLog.startDefendingUnits"
          :leftUnits="item.attackLog.leftDefendingUnits"
          attackerOrDefender="Defender"
          :villageName="item.defendingVillageName"
          :username="item.defendingUsername"
        ></unit-block>
        <p>The defender had a bonus defence of {{ item.attackLog.defenceBonus }}</p>
      </div>
    </div>
    <div class="afterFightData" v-if="userWon && isTheAttacker">
      <h2>Estimated the following units</h2>
      <div class="units">
        <div>
          <img src="" width="21px" height="17px" />
          <p>Amount</p>
        </div>
        <div v-for="unitType in item.attackLog.allUnitTypes" :key="unitType.id">
          <img
            :src="require('../../../assets/ui-items/' + unitType + '.png')"
            width="21px"
            height="17px"
          />
          <p>{{ getUnitAmount(item.attackLog.scoutedUnits, unitType) }}</p>
        </div>
      </div>
      <h2>Estimated the following resources</h2>
      <span class="pillagedResources" v-if="item.attackLog.pillagedResources">
        <span
          class="resource"
          v-for="(amount, resource) in item.attackLog.pillagedResources"
          :key="resource.id"
        >
          <img
            style="margin-right: 4px"
            :src="require('../../../assets/ui-items/' + resource + '.png')"
            width="21px"
            height="17px"
          />
          <span>{{ amount }}</span>
        </span>
      </span>
      <span v-else>None</span>
    </div>
  </div>
</template>

<script>
export default {
  props: ['item'],
  data() {
    return {
      unitTypes: ['Scout'],
    };
  },
  computed: {
    userId() {
      return this.$store.getters.village.villageOwnerId;
    },
    isTheAttacker() {
      return this.item.villageOwnerId === this.userId;
    },
    userWon() {
      return this.isTheAttacker
        ? this.item.attackLog.attackerWon
        : !this.item.attackLog.attackerWon;
    },
  },
  methods: {
    selectLog() {
      this.$emit('log-selected', this.item);
    },
    getUnitAmount(listOfUnits, unitType) {
      for (const u of listOfUnits) {
        if (u.unit.unitName === unitType) {
          return u.amount;
        }
      }
      return 0;
    },
  },
};
</script>

<style lang="scss">
.units {
  justify-content: space-around !important;
}
</style>

<style lang="scss" scoped>
.unitsFight {
  margin: 10px;
  display: flex;
  justify-content: space-around;
}
.units {
  margin-top: 10px;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
}

p {
  margin-top: 8px;
  margin-bottom: 8px;
}

.afterFightData {
  display: flex;
  text-align: left;
  flex-direction: column;
  margin: 10px;
}

.pillagedResources {
  flex: 0.5;

  .resource {
    display: flex;
    flex-direction: row;
    margin-bottom: 4px;
  }
}
</style>
