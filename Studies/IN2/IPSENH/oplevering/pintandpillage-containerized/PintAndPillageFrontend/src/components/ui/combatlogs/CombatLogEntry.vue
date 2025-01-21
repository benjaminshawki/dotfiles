<template>
  <div v-if="item" @click="selectLog" class="combatLogEntry">
    <p v-if="isTheAttacker">
      You {{ item.attackLog.isScoutAttack ? 'scouted' : 'attacked' }} {{ item.defendingUsername }}
    </p>
    <p v-else>
      {{ item.attackingUsername }} {{ item.attackLog.isScoutAttack ? 'scouted' : 'attacked' }} you
    </p>
    <p>{{ userWon ? 'You won!' : 'You lost!' }}</p>
    <p>{{ item.attackLog.timeOfCombat | moment('DD/MM/YYYY HH:mm:ss') }}</p>
    <!--        <hr style="margin-bottom: 8px;">-->
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

<style scoped>
.combatLogEntry {
  border-bottom: 10px solid transparent;
  border-image: url('../../../assets/borders_modal.png') 40% stretch;
}

div {
  cursor: pointer;
}

div:hover {
  background-color: #696969;
}

p {
  margin: 2px;
}
</style>
