<template>
  <div v-if="this.properties.villageData" class="scrollerFirefox">
    <ul v-if="villageLogHasData()" class="logList">
      <li v-for="(log, index) in this.properties.villageData.villageLog" v-bind:key="index">
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
    villageLogHasData: function () {
      return this.properties.villageData.villageLog.length > 0;
    },
  },
};
</script>

<style lang="scss">
.logText {
  font-size: 15px !important;
}
</style>
