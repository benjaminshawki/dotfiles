<template>
  <div class="marketModal">
    <div class="marketLevelContainer">
      <h1>{{ building.name }} - Lv {{ building.level }}</h1>
      <hr width="70%" />
    </div>
    <tab-navigation :tabList="tabList" :properties="tabProperties"></tab-navigation>
    <div class="marketeersDisplay">
      <p>
        Marketeers: {{ building.marketeersAvailable }}/{{
          building.marketeersAvailable + building.marketeersInUse
        }}
      </p>
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
        { name: 'Make Offer', componentName: 'MakeMarketOffer' },
        { name: 'Open Offers', componentName: 'MarketTrades' },
        { name: 'Village Trades', componentName: 'VillageTrades' },
        { name: 'Trades', componentName: 'OpenMarketOffers' },
        { name: 'Travels', componentName: 'MarketTravels' },
      ],
      tabProperties: { buildingId: this.buildingId },
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
.marketModal {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  flex-direction: column;
  .marketLevelContainer {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    width: 100%;
    font-size: 25px;
    h1 {
      font-size: 30px;
      margin-bottom: 0px;
    }
  }
  .marketeersDisplay {
    font-size: 25px;
    /*width: 100%;*/
    /*background-color: #333333;*/
  }
}
</style>
