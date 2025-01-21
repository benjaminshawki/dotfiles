<template>
  <div v-if="item">
    <h1>{{ userWon ? 'You WON!' : 'You LOST!' }}</h1>
    <hr width="80%" />
    <div class="unitsFight">
      <unit-block
        :unitTypes="item.attackLog.allUnitTypes"
        :startUnits="item.attackLog.startAttackingUnits"
        :leftUnits="item.attackLog.leftAttackingUnits"
        attackerOrDefender="Attacker"
        :villageName="item.attackingVillageName"
        :username="item.attackingUsername"
      ></unit-block>

      <unit-block
        :unitTypes="item.attackLog.allUnitTypes"
        :startUnits="item.attackLog.startDefendingUnits"
        :leftUnits="item.attackLog.leftDefendingUnits"
        attackerOrDefender="Defender"
        :villageName="item.defendingVillageName"
        :username="item.defendingUsername"
      ></unit-block>
      <p>The defender had a bonus defence of {{ item.attackLog.defenceBonus }}</p>

      <div class="afterFightData">
        <div class="pillagedResources">
          <h2>Pillaged Resources</h2>
          <div v-if="item.attackLog.pillagedResources" class="wonResourcesContainer">
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
          </div>
          <span v-else>None</span>
        </div>
        <div class="extraInfo">
          <p v-if="item.attackLog.moraleFrom !== item.attackLog.moraleTo">
            Morale lowered from {{ item.attackLog.moraleFrom }} to {{ item.attackLog.moraleTo }}
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['item'],
  data() {
    return {};
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
  },
};
</script>

<style lang="scss" scoped>
.unitsFight {
  margin: 10px;
}
.units {
  margin-top: 10px;
  display: flex;
  flex-direction: row;
  justify-content: space-between;

  p {
    margin-top: 8px;
    margin-bottom: 8px;
  }
}

.afterFightData {
  display: flex;
  align-items: flex-start;
  text-align: left;

  .pillagedResources {
    flex: 0.5;
    .wonResourcesContainer {
      display: flex;
      flex-wrap: wrap;
    }
    .resource {
      display: flex;
      flex-direction: row;
      margin-bottom: 4px;
      margin-right: 20px;
    }
  }

  .extraInfo {
    flex: 0.5;
  }
}
</style>
