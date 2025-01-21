<template>
  <div class="travelsContainer scrollerFirefox">
    <h2>Travels</h2>
    <hr width="80%" />
    <div v-if="building.marketTravels" class="offerListTravels">
      <div v-for="travel in building.marketTravels" :key="travel.key" class="travelRow">
        <p v-if="travel.amount">{{ travel.amount }} {{ travel.resourceType }}</p>
        <img
          v-if="travel.resourceType"
          style="margin-left: 20px"
          :src="require('../../../assets/ui-items/' + travel.resourceType + '.png')"
          width="28px"
          height="28px"
        />
        <p style="margin-right: 91px">Marketeers: {{ travel.marketeers }}</p>
        <p style="margin-left: 91px" v-if="travel.traveltimeLeft">
          Traveltime: {{ travel.traveltimeLeft }} {{ travel.acceptanceResource }}
        </p>
        <img
          v-if="travel.name === 'OutgoingMarketTravel'"
          class="travelArrow"
          src="../../../assets/ui-items/arrows/incommingArrow.png"
          width="42px"
          height="28px"
        />
        <img
          v-else
          src="../../../assets/ui-items/outgoingArrow.png"
          class="travelArrow"
          width="42px"
          height="28px"
        />
      </div>
    </div>
    <h2 v-if="building.marketTravels.length === 0">No current open travels</h2>
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
    }
</script>

<style lang="scss">
    .travelsContainer{
        display: flex;
        align-items: center;
        flex-direction: column;

        margin-top: 20px;
        z-index: 0;
        h2{
            color: white;
        }
    }
    .offerListTravels{
        max-height: 280px;
        overflow: auto;
        .travelRow{
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
            .travelArrow{
                margin-left: 14px;
                margin-right: 14px;
            }
        }
    }



</style>
