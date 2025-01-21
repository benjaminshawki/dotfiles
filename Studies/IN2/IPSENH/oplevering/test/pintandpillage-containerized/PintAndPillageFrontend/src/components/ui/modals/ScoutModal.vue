<template>
  <div v-if="scout" class="scoutModal">
    <div class="scoutFrame">
      <h1>Select your Scout</h1>
      <hr width="70%" />
      <div class="scoutUnitFrame">
        <img
          :src="require('../../../assets/ui-items/' + scout.unit.unitName + '.png')"
          width="49px"
          height="42px"
        />
        <div class="scoutUnitsInStore">
          <p>{{ scout.amount }}</p>
        </div>
        <h2>{{ scout.unit.unitName }}</h2>
        <div class="inputContainer">
          <input
            type="number"
            v-model="scoutAmount"
            min="0"
            :max="scout.amount"
            @keypress="validateNumberInput(scout.amount, $event)"
            @change="addScout(scout.unit.unitName)"
          />
        </div>
      </div>
      <h2 v-if="showErrorNoScoutsSelected" style="color: #ca3e14">
        Please select at least 1 scout
      </h2>
      <button class="scoutButton" @click="sendScout">Send Scout</button>
    </div>
  </div>
  <div style="text-align: center; max-width: 420px" v-else>
    <h2>You currently don't have any scouts. Train some to scout other players!</h2>
  </div>
</template>

<script>
export default {
  props: ['villageId'],
  data: function () {
    return {
      scout: '',
      scoutAmount: 0,
      showErrorNoScoutsSelected: false,
      selectedScouts: null,
    };
  },
  created: function () {
    this.setScoutUnit();
  },
  methods: {
    setScoutUnit: function () {
      const unitsList = this.$store.getters.village.unitsInVillage;
      for (let i = 0; i < unitsList.length; i++) {
        if (unitsList[i].unit.unitName === 'Scout') {
          this.scout = unitsList[i];
        }
      }
    },
    addScout: function (unitType) {
      this.selectedScouts = [{ unitType: unitType, amount: this.scoutAmount }];
    },
    sendScout: function () {
      if (this.scoutAmount === 0) {
        this.showErrorNoScoutsSelected = true;
        return false;
      }
      this.$store
        .dispatch('attackVillage', this.getScoutData())
        .then(() => {
          this.$emit('close');
          this.$toaster.success('Scouts Send!');
        })
        .catch((err) => {
          this.$toaster.error(err);
        });
    },
    getScoutData: function () {
      return {
        fromVillageId: this.$store.getters.village.villageId,
        toVillageId: this.villageId,
        units: this.selectedScouts,
      };
    },
  },
};
</script>

<style lang="scss">
.scoutModal {
  user-select: none;
  h1,
  h2 {
    margin-bottom: 0px;
  }
  hr {
    margin-bottom: 28px;
  }
  .scoutFrame {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    img {
      margin-left: 14px;
    }
    .scoutUnitFrame {
      border: 7px solid transparent;
      border-image: url('../../../assets/borders_modal.png') 40% stretch;
      width: 420px;
      display: flex;
      align-items: center;
      flex-direction: row;
      margin-bottom: 14px;
      .inputContainer {
        max-height: 28px;
        min-width: 77px;
        width: 77px;
        margin-top: 3.5px;
        border: 7px solid transparent;
        border-image: url('../../../assets/borders_modal.png') 40% stretch;
        color: white;
        margin-left: 49px;
        margin-right: 7px;
        input {
          background-color: #7f7f7f;
          min-width: 77px;
          width: 77px;
          text-align: center;
          border: none;
          color: white;
          font-size: 14px;
          height: 21px;
        }
      }
      h2 {
        margin: 14px 14px 14px 7px;
        width: 100px;
      }
      .scoutUnitsInStore {
        width: 35px;
        height: 35px;
        text-align: center;
        font-size: 14px;
        background-image: url('../../../assets/ui-items/number_frame.png');
        background-size: 100% 100%;
        margin: 14px;
        padding: 2.1px;
        p {
          margin-top: 7px;
          margin-left: 3.5px;
          width: 28px;
        }
      }
    }
  }
}

.scoutButton {
  color: white;
  background-color: #15636c;
  border-radius: 3.5px;
  height: 35px;
  font-size: 14px;
  width: 105px;
  border: 2.8px solid #0f3b43;
  min-width: 105px;
  margin: 14px;
}
</style>
