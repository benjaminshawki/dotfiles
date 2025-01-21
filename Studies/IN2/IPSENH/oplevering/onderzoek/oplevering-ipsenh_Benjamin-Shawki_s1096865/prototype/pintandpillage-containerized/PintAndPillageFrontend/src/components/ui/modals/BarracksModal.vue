<template>
  <div class="barackContainer scrollerFirefox">
    <div v-if="building" class="barackInfo">
      <h1>{{ building.name }} - Lv {{ building.level }}</h1>
      <hr width="80%" />
    </div>
    <div class="tabContainer">
      <tab-navigation
        :tab-list="tabList"
        :properties="{ buildingId: buildingId, title: 'Unit Queue' }"
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
        { name: 'Recruits', componentName: 'UnitList' },
        { name: 'Units In Progress', componentName: 'UnitsInProgress' },
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
.barackInfo {
  font-size: 12.6px;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  h1 {
    margin-top: 0px;
    margin-bottom: 14px;
    font-size: 30px;
  }
}
.tabContainer {
  margin-left: 70px;
  margin-right: 70px;
  margin-bottom: 70px;
}

.barackContainer {
  margin-left: 28px;
  margin-right: 28px;
}
</style>
