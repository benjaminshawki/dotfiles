<template>
  <div class="outerOfferContainer">
    <div style="display: flex; flex-direction: row; justify-content: center; height: 120px">
      <div class="inputContainer">
        <input
          v-model="offerAmount"
          type="number"
          min="0"
          :max="getMaxTradeResource(offerResource)"
          @keypress="validateNumberInput(getMaxTradeResource(offerResource), $event)"
        />
      </div>
      <resource-selector
        v-if="resources"
        :resources="Object.keys(resources)"
        @selectedUpdate="offerResource = $event"
      ></resource-selector>
      <img
        style="margin-left: 20px; margin-bottom: 1000px"
        src="../../../assets/ui-items/arrows/exchange-arrows.png"
        width="150px"
        height="100px"
      />
      <div class="inputContainer">
        <input
          v-model="acceptanceAmount"
          type="number"
          min="0"
          @keypress="validateNumberInput(999999, $event)"
        />
      </div>
      <resource-selector
        v-if="resources"
        :resources="building.allResourceTypes"
        @selectedUpdate="tradeResource = $event"
      ></resource-selector>
    </div>
    <button @click="setOffer()" class="tradeButton">Set Offer</button>
  </div>
</template>

<script>
import ResourceSelector from '../ResourceSelector';
export default {
  components: { ResourceSelector },
  props: ['properties'],
  data: function () {
    return {
      offerResource: null,
      tradeResource: null,
      acceptanceAmount: 1,
      offerAmount: 1,
    };
  },
  computed: {
    building: function () {
      return this.$store.getters.building(this.properties.buildingId);
    },
    resources: function () {
      return this.$store.getters.village.villageResources;
    },
  },
  methods: {
    getMaxTradeResource: function (resource) {
      for (const [key] of Object.entries(this.resources)) {
        if (key === resource) {
          return this.resources[key];
        }
      }
    },
    setOffer: function () {
      const marketOffer = {
        buildingId: this.properties.buildingId,
        offerResource: this.offerResource,
        offerAmount: this.offerAmount,
        acceptanceResource: this.tradeResource,
        acceptanceAmount: this.acceptanceAmount,
      };
      this.$store.dispatch('makeMarketOffer', marketOffer).then(() => {
        this.$toaster.success('Market offer successfully set!');
      });
    },
  },
};
</script>

<style lang="scss">
.outerOfferContainer {
  display: flex;
  flex-direction: column;
  justify-content: center;
  margin-top: 28px;
  align-items: center;
  padding-top: 35px;
  padding-bottom: 35px;
  p {
    margin: 14px;
    font-size: 17.5px;
  }
  .inputContainer {
    max-height: 28px;
    min-width: 77px;
    width: 77px;
    margin-top: 3.5px;
    margin-right: 14px;
    margin-left: 14px;
    border: 7px solid transparent;
    border-image: url('../../../assets/borders_modal.png') 40% stretch;
    color: white;
    input {
      background-color: #7f7f7f;
      height: 28px;
      min-width: 77px;
      width: 77px;
      font-size: 17.5px;
      text-align: center;
      border: none;
      color: white;
    }
  }
  .tradeButton {
    color: white;
    background-color: #15636c;
    border-radius: 3.5px;
    height: 50px;
    font-size: 17.5px;
    width: 91px;
    border: 2.8px solid #0f3b43;
    min-width: 140px;
  }
}
</style>
