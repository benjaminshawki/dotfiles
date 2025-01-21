<template>
  <div class="harborContainer scrollerFirefox">
    <div v-if="building" class="harborInfo">
      <h1>{{ building.name }} - Lv {{ building.level }}</h1>
      <hr width="80%" />
    </div>
    <div class="tabContainer">
      <tab-navigation
        :tab-list="tabList"
        :properties="{ buildingId: buildingId, title: 'Ship Queue' }"
      ></tab-navigation>
    </div>
    <level-up-building @close="close" :buildingId="buildingId"></level-up-building>
  </div>
</template>

<script>
export default {
  props: ['buildingId'],
  data: function () {
    return {
      tabList: [
        { name: 'Ships', componentName: 'UnitList' },
        { name: 'Ships In Progress', componentName: 'UnitsInProgress' },
      ],
    };
  },
  computed: {
    building: function () {
      return this.$store.getters.building(this.buildingId);
    },
  },
  methods: {
    close: function () {
      this.$emit('close');
    },
  },
};
</script>

<style lang="scss">
.harborInfo {
  font-size: 24px;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  h1 {
    margin-top: 0px;
    margin-bottom: 20px;
    font-size: 30px;
  }
}
.tabContainer {
  margin-left: 100px;
  margin-right: 100px;
  margin-bottom: 100px;
}

.harborContainer {
  margin-left: 40px;
  margin-right: 40px;
}
</style>
