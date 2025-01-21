<template>
  <div v-if="this.properties.villageData" class="scrollerFirefox">
    <ul v-if="combatLogHasData()" class="logList">
      <li v-for="(log, index) in this.properties.villageData.combatLog" v-bind:key="index">
        <p class="logText">{{ log.message }}</p>
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
    combatLogHasData: function () {
      return this.properties.villageData.combatLog.length > 0;
    },
  },
};
</script>

<style scoped></style>
