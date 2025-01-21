<template>
  <div class="tradesContainer scrollerFirefox">
    <h2>Your open offers</h2>
    <hr width="80%" />
    <div v-if="building && noCurrentOffers()" class="offerListTrades">
      <div v-for="(offer, index) in building.marketOffers" :key="offer.key" class="offerRow">
        <p>You offered {{ offer.offerAmount }} {{ offer.offerResource }}</p>
        <img
          style="margin-right: 91px; margin-left: 14px"
          :src="require('../../../assets/ui-items/' + offer.offerResource + '.png')"
          width="28px"
          height="28px"
        />
        <img
          src="../../../assets/ui-items/arrows/exchange-arrows.png"
          width="105px"
          height="70px"
        />
        <p style="margin-left: 91px">{{ offer.acceptanceAmount }} {{ offer.acceptanceResource }}</p>
        <img
          style="margin-right: 4.9px; margin-left: 4.9px"
          :src="require('../../../assets/ui-items/' + offer.acceptanceResource + '.png')"
          width="28px"
          height="28px"
        />
        <button class="removeTradeButton" @click="removeOffer(offer, index)">Remove</button>
      </div>
    </div>
    <div v-else style="display: flex; justify-content: center; align-items: center; color: white">
      <h2 style="text-align: center">No offers set yet.</h2>
    </div>
  </div>
</template>

<script>
/* eslint-disable */
    export default{
        props: ['properties'],
        computed: {
            building: function(){
                return this.$store.getters.building(this.properties.buildingId);
            }
        },
        methods:{
            removeOffer: function (offer, offerIndex) {
                this.$store.dispatch('deleteMarketOffer', offer.id).then(()=>{
                    this.building.marketOffers.splice(offerIndex, 1);
                    this.$toaster.success('Market offer removed');
                })
            },
            noCurrentOffers: function () {
                return this.building.marketOffers.length !== 0;
            }
        }
    }
</script>

<style lang="scss">
    .tradesContainer{
        display: flex;
        align-items: center;
        flex-direction: column;
        margin-top: 14px;
        z-index: 0;
        h2{
            color: white;
        }
    }
    .offerListTrades{
        max-height: 280px;
        overflow: auto;
        .offerRow{
            display: flex;
            align-items: center;
            flex-direction: row;
            justify-content: space-evenly;
            border: 7px solid transparent;
            border-image: url("../../../assets/borders_modal.png") 40% stretch;
            margin-bottom: 7px;
            margin-top: 7px;
            p{
                font-size: 14px;
                margin-left: 21px;
            }
            .removeTradeButton{
                color: white;
                background-color: #600000;
                border: 2.1px solid #a80000;
                border-radius: 3.5px;
                height: 35px;
                font-size: 14px;
                margin-left: 30px;
                justify-content: flex-end;
                margin-right: 14px;
            }
        }
    }

</style>
