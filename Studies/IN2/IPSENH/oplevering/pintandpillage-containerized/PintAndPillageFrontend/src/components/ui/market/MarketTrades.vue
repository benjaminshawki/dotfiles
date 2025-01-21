<template>
  <div>
    <div v-if="offersList" class="offerList scrollerFirefox">
      <div v-for="(offer, index) in offersList" :key="offer.key" class="offerRow">
        <p>
          {{ offersList[index].username }} offered {{ offer.marketOffer.offerAmount }}
          {{ offer.marketOffer.offerResource }}
        </p>
        <img
          style="margin-right: 91px; margin-left: 7px"
          :src="require('../../../assets/ui-items/' + offer.marketOffer.offerResource + '.png')"
          width="28px"
          height="28px"
        />
        <img
          src="../../../assets/ui-items/arrows/exchange-arrows.png"
          width="105px"
          height="70px"
        />
        <p style="margin-left: 91px">
          {{ offer.marketOffer.acceptanceAmount }} {{ offer.marketOffer.acceptanceResource }}
        </p>
        <img
          style="margin-right: 7px; margin-left: 7px"
          :src="
            require('../../../assets/ui-items/' + offer.marketOffer.acceptanceResource + '.png')
          "
          width="28px"
          height="28px"
        />
        <button class="acceptTradeOffer" @click="acceptMarketOffer(offer.marketOffer, index)">
          Trade
        </button>
      </div>
    </div>
    <h2
      v-if="!offersList || offersList.length === 0"
      style="justify-content: center; align-items: center; display: flex"
    >
      No current trades available
    </h2>
  </div>
</template>

<script>
export default {
  props: ['properties'],

  computed: {
    offersList: function () {
      return this.$store.getters.offers;
    },
  },
  created: function () {
    this.getOffersList();
  },
  methods: {
    getOffersList: function () {
      this.$store.dispatch('fetchMarketOffers');
    },
    acceptMarketOffer: function (offer, offerIndex) {
      this.$store
        .dispatch('acceptMarketOffer', { marketId: this.properties.buildingId, offerId: offer.id })
        .then(() => {
          this.offersList.splice(offerIndex, 1);
          this.$toaster.success('Trade successfully started!');
        });
    },
  },
};
</script>

<style lang="scss">
.offerList {
  max-height: 350px;
  overflow: auto;

  .offerRow {
    display: flex;
    align-items: center;
    flex-direction: row;
    justify-content: space-evenly;
    border: 7px solid transparent;
    border-image: url('../../../assets/borders_modal.png') 40% stretch;
    margin-bottom: 7px;
    margin-top: 7px;
    p {
      font-size: 14px;
      margin-left: 21px;
    }
    .acceptTradeOffer {
      color: white;
      background-color: #1f8031;
      border: 2.1px solid #175922;
      border-radius: 5px;
      height: 35px;
      font-size: 14px;
      margin-left: 21px;
      justify-content: flex-end;
    }
  }
}
</style>
