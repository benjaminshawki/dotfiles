<template>
  <div>
    <h2 style="text-align: left">{{ attackerOrDefender }}: {{ villageName }} ({{ username }})</h2>
    <div class="units">
      <div style="margin-top: 22px">
        <p>Amount</p>
        <p>Died</p>
        <p>Left</p>
      </div>
      <div v-for="unitType in unitTypes" :key="unitType.id">
        <img
          :src="require('../../../assets/ui-items/' + unitType + '.png')"
          width="21px"
          height="17px"
        />
        <p>{{ getUnitAmount(startUnits, unitType) }}</p>
        <p>{{ getUnitAmount(startUnits, unitType) - getUnitAmount(leftUnits, unitType) }}</p>
        <p>{{ getUnitAmount(leftUnits, unitType) }}</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['unitTypes', 'startUnits', 'leftUnits', 'attackerOrDefender', 'villageName', 'username'],
  methods: {
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

<style scoped>
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
</style>
