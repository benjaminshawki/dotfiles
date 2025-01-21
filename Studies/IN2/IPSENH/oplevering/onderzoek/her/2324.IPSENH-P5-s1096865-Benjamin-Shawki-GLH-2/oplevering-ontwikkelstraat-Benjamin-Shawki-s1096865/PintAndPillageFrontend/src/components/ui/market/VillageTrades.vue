<template>
  <div class="outerVillageTradeContainer scrollerFirefox" v-if="hasMultipleVillages()">
    <div style="display: flex; flex-direction: row; justify-content: center; height: 140px">
      <div style="margin-top: 15px">
        <div
          class="villageSelectorMarket"
          @click="isDroppedDown = !isDroppedDown"
          v-click-outside="closeDropdown"
        >
          <p>{{ selectedVillage().name }}</p>
        </div>
        <div class="dropdownMarket" v-show="isDroppedDown">
          <div v-for="village in villageList" :key="village.key">
            <div @click="updateVillage(village.villageId)" class="dropdownItemsMarket">
              <div v-if="village.villageId !== selectedVillage().villageId">
                <p>{{ village.name }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="inputVillageTradeContainer">
        <input
          v-model="offerAmount"
          type="number"
          min="0"
          :max="getMaxTradeResource(tradeResource)"
          @keypress="validateNumberInput(getMaxTradeResource(tradeResource), $event)"
        />
      </div>
      <resource-selector
        v-if="resources"
        :resources="Object.keys(resources)"
        @selectedUpdate="updateTradeResource($event)"
      ></resource-selector>
    </div>
    <button @click="setOffer()" class="tradeButton">Transfer Goods</button>
  </div>
  <div
    v-else
    style="display: flex; justify-content: center; align-items: center; color: white; width: 700px"
  >
    <h2 style="width: 70%; text-align: center">
      You currently don't have multiple villages to trade with. Train a Jarl and Settle a new piece
      of land!
    </h2>
  </div>
</template>

<script>
import ResourceSelector from '../ResourceSelector';
export default {
  components: { ResourceSelector },
  props: ['properties'],
  data: function () {
    return {
      tradeResource: null,
      acceptanceAmount: 1,
      offerAmount: 1,
      isDroppedDown: false,
      currentVillageId: '',
    };
  },
  created: function () {
    if (this.villageList.length !== 0) {
      this.currentVillageId = this.villageList[0].villageId;
    }
  },
  computed: {
    building: function () {
      return this.$store.getters.building(this.properties.buildingId);
    },
    resources: function () {
      return this.$store.getters.village.villageResources;
    },
    villageList: function () {
      const unFilteredList = this.$store.getters.villageList;
      const filteredList = [];
      for (let i = 0; i < unFilteredList.length; i++) {
        if (unFilteredList[i].villageId !== this.currentVillage.villageId) {
          filteredList.push(unFilteredList[i]);
        }
      }
      return filteredList;
    },
    currentVillage: function () {
      return this.$store.getters.village;
    },
  },
  methods: {
    updateTradeResource: function (event) {
      this.tradeResource = event;
    },
    getMaxTradeResource: function (resource) {
      for (const [key, value] of Object.entries(this.resources)) {
        if (key === resource) {
          return value;
        }
      }
    },
    setOffer: function () {
      const marketOffer = {
        marketId: this.properties.buildingId,
        toVillageId: this.currentVillageId,
        resource: this.tradeResource,
        amount: this.offerAmount,
      };
      this.$store
        .dispatch('makeVillageTrade', marketOffer)
        .then(() => this.$toaster.success('Village trade successfully!'))
        .catch((err) => {
          if (err.response.status === 412) {
            this.$toaster.error(
              'Preconditions not met, market in receiving village must be level 5 or higher',
            );
          } else {
            this.$toaster.error('Something went wrong');
          }
        });
    },
    selectedVillage: function () {
      if (this.villageList) {
        for (let i = 0; i < this.villageList.length; i++) {
          if (this.villageList[i].villageId === this.currentVillageId) {
            return this.villageList[i];
          }
        }
      }
      return null;
    },
    updateVillage: function (villageId) {
      this.currentVillageId = villageId;
      this.isDroppedDown = false;
    },
    closeDropdown: function () {
      this.isDroppedDown = false;
    },
    hasMultipleVillages: function () {
      return this.villageList.length !== 0;
    },
  },
};
</script>

<style lang="scss">
.outerVillageTradeContainer {
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
  .inputVillageTradeContainer {
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
    height: 49px;
    font-size: 17.5px;
    width: 94px;
    border: 2.8px solid #0f3b43;
    min-width: 140px;
    z-index: 1 !important;
  }
}

.villageSelectorMarket {
  width: 260px;
  margin-top: -14px;
  background: url('../../../assets/ui-items/village_dropdown.png') no-repeat right center;
  background-size: 260px 100%;
  text-align: center;
  color: white;
  cursor: pointer;
  z-index: 500;
  position: relative;
  p {
    font-size: 17.5px;
    padding: 14px;
    margin-top: 0;
    user-select: none;
    margin-bottom: -7px;
  }
}
.dropdownItemsMarket {
  width: 232px;
  background-color: rgb(104, 104, 104);
  cursor: pointer;
  z-index: 1500;

  p {
    font-size: 14px;
    padding: 7px;
    margin-top: 0;
    margin-bottom: 0;
    user-select: none;
    text-align: center;
    color: white;
    margin-left: 0;
    margin-right: 0;
    /*border: 2px solid rgb(61, 61, 61);*/
  }
  p:hover {
    background-color: rgb(144, 144, 144);
  }
}
.dropdownMarket {
  margin-left: 7px;
  width: 232px;
  border: 7px solid transparent;
  border-image: url('../../../assets/borders_modal.png') 40% stretch;
  max-height: 560px;
  overflow: auto;
}
</style>
