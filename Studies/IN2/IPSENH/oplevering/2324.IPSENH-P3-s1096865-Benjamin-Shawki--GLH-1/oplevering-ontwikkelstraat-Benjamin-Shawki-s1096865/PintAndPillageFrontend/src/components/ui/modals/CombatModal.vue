<template>
  <div class="combatModal">
    <div style="max-width: 420px; text-align: center" v-if="!checkForUnits()">
      <h2>You currently don't have any units. Train some units to join the battlefields!</h2>
    </div>
    <div class="combatFrame" v-if="!shipsSelected && checkForUnits()">
      <h1>Select your Long Ships</h1>
      <h2>Unit Carrying Capacity</h2>
      <p>Capacity: {{ totalCarryingCapacity() }}</p>
      <hr width="70%" style="margin-bottom: 20px" />
      <div v-for="(ship, index) in ships" class="combatUnitFrame" :key="ship.key">
        <img
          :src="require('../../../assets/ui-items/' + ship.unit.unitName + '.png')"
          width="49px"
          height="42px"
        />
        <div class="combatUnitsInStore">
          <p>{{ ship.amount }}</p>
        </div>
        <h2>{{ ship.unit.unitName }}</h2>
        <div class="inputContainer">
          <input
            type="number"
            v-model="inputValues[index]"
            min="0"
            :max="ship.amount"
            @keypress="validateNumberInput(ship.amount, $event)"
            @change="addShips(ship.unit.unitName, ship.unit.shipCapacity, index)"
          />
        </div>
      </div>
      <h2 v-if="showErrorCarryingCapacity" style="color: #ca3e14">Not enough carrying capacity</h2>
      <button class="combatButton" v-if="!shipsSelected" @click="openUnitsFrame">
        Select Units
      </button>
    </div>

    <div class="combatFrame" v-if="shipsSelected">
      <h1>Select your raiders</h1>
      <h2>Selected units:</h2>
      <p>{{ totalUnitsSelected() }}/{{ totalCarryingCapacity() }}</p>
      <hr width="70%" style="margin-bottom: 20px" />
      <div class="combatUnitScrollContainer scrollerFirefox">
        <div v-for="(unit, index) in units" class="combatUnitFrame" :key="unit.key">
          <img
            :src="require('../../../assets/ui-items/' + unit.unit.unitName + '.png')"
            width="49px"
            height="42px"
          />
          <div class="combatUnitsInStore">
            <p>{{ unit.amount }}</p>
          </div>
          <h2>{{ unit.unit.unitName }}</h2>
          <div class="inputContainer">
            <input
              type="number"
              v-model="inputValues[index]"
              min="0"
              :max="unit.amount"
              @keypress="validateNumberInput(unit.amount, $event)"
              @change="addUnit(unit.unit.unitName, index)"
            />
          </div>
        </div>
      </div>

      <h2 v-if="showErrorNoUnitsSelected" style="color: #ca3e14">Please select some units</h2>
      <button class="combatButton" v-if="shipsSelected" @click="startAttack">To Battle!</button>
    </div>
  </div>
</template>

<script>
export default {
  props: ['villageId'],
  data: function () {
    return {
      shipsSelected: false,
      carryingShipCapacity: null,
      shipsAmount: 0,
      units: [],
      ships: [],
      shipsDictionaryList: [],
      unitsDictionaryList: [],
      inputValues: [],
      showErrorCarryingCapacity: false,
      showErrorNoUnitsSelected: false,
    };
  },
  computed: {
    unitsInVillage: function () {
      return this.$store.getters.village.unitsInVillage;
    },
  },
  created: function () {
    this.createShipsList();
  },
  methods: {
    createShipsList: function () {
      for (let i = 0; i < this.unitsInVillage.length; i++) {
        if (this.unitsInVillage[i].unit.unitName.toLowerCase().includes('ship')) {
          this.ships.push(this.unitsInVillage[i]);
        } else {
          this.units.push(this.unitsInVillage[i]);
        }
      }
    },
    addShips: function (shipType, shipsCarryingCapacity, index) {
      for (let i = 0; i < this.shipsDictionaryList.length; i++) {
        if (this.shipsDictionaryList[i].shipType === shipType) {
          this.shipsDictionaryList.splice(i, 1);
        }
      }
      this.shipsDictionaryList.push({
        shipType: shipType,
        shipCarryingCapacity: shipsCarryingCapacity,
        shipsAmount: this.inputValues[index],
      });
    },
    totalCarryingCapacity: function () {
      let totalCarryingCapacity = 0;
      for (let i = 0; i < this.shipsDictionaryList.length; i++) {
        totalCarryingCapacity +=
          this.shipsDictionaryList[i].shipCarryingCapacity *
          this.shipsDictionaryList[i].shipsAmount;
      }
      return totalCarryingCapacity;
    },
    openUnitsFrame: function () {
      if (this.totalCarryingCapacity() !== 0) {
        this.shipsSelected = true;
        this.inputValues = [];
      } else {
        this.showErrorCarryingCapacity = true;
      }
    },
    totalUnitsSelected: function () {
      let totalUnitsSelected = 0;
      for (let i = 0; i < this.unitsDictionaryList.length; i++) {
        totalUnitsSelected += parseInt(this.unitsDictionaryList[i].amount);
      }
      return totalUnitsSelected;
    },
    addUnit: function (unitType, index) {
      for (let i = 0; i < this.unitsDictionaryList.length; i++) {
        if (this.unitsDictionaryList[i].unitType === unitType) {
          this.unitsDictionaryList.splice(i, 1);
        }
      }
      this.unitsDictionaryList.push({ unitType: unitType, amount: this.inputValues[index] });
    },
    startAttack: function () {
      if (this.totalUnitsSelected() === 0) {
        this.showErrorNoUnitsSelected = true;
        return false;
      }
      this.addShipsToUnitList();
      this.$store
        .dispatch('attackVillage', this.getAttackData())
        .then(() => {
          this.$emit('close');
          this.$toaster.success('Units Send!');
        })
        .catch((err) => {
          this.$toaster.error(err);
        });
    },
    addShipsToUnitList: function () {
      for (let i = 0; i < this.shipsDictionaryList.length; i++) {
        const shipUnit = {
          unitType: this.shipsDictionaryList[i].shipType,
          amount: this.shipsDictionaryList[i].shipsAmount,
        };
        this.unitsDictionaryList.push(shipUnit);
      }
    },
    getAttackData: function () {
      return {
        fromVillageId: this.$store.state.village.data.villageId,
        toVillageId: this.villageId,
        units: this.unitsDictionaryList,
      };
    },
    close: function () {
      this.$emit('close');
    },
    checkForUnits: function () {
      if (this.unitsInVillage.length === 0) {
        return false;
      } else {
        let i = 0;
        let shipsInvillage = false;
        for (i; i < this.unitsInVillage.length; i++) {
          if (
            this.unitsInVillage[i].unit.unitName === 'TransportShip' ||
            this.unitsInVillage[i].unit.unitName === 'CombatShip'
          ) {
            shipsInvillage = true;
          }
        }

        return shipsInvillage;
      }
    },
  },
};
</script>

<style lang="scss">
.combatModal {
  user-select: none;
  h1,
  h2 {
    margin-bottom: 0px;
  }
  .combatFrame {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;

    img {
      margin-left: 14px;
    }
    .combatUnitScrollContainer {
      max-height: 400px;
      width: 100%;
      overflow-y: scroll;
    }
    .combatUnitFrame {
      border: 7px solid transparent;
      border-image: url('../../../assets/borders_modal.png') 40% stretch;
      width: 420px;
      display: flex;
      align-items: center;
      flex-direction: row;
      margin-bottom: 14px;
      .inputContainer {
        max-height: 24px;
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
        width: 70px;
      }
      .combatUnitsInStore {
        width: 35px;
        height: 35px;
        text-align: center;
        font-size: 14px;
        background-image: url('../../../assets/ui-items/number_frame.png');
        background-size: 100% 100%;
        margin: 14px;
        padding: 2.8px;
        p {
          margin-top: 7px;
          margin-left: 3.5px;
          width: 28px;
        }
      }
    }
  }
}

.combatButton,
.shipAddButton {
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
.shipAddButton {
  min-width: 56px !important;
  width: 56px !important;
  height: 28px;
  font-size: 11.2px;
}
</style>
