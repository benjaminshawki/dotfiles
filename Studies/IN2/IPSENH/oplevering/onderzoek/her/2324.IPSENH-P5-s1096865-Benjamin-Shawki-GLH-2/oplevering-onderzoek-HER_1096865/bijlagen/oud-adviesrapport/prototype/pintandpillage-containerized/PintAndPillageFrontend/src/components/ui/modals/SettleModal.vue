<template>
  <div class="SettleConatiner">
    <img src="../../../assets/ui-items/SettleIcon.png" width="210px" height="140px" />
    <h3>Some nice fertile land, perfect for a new settlement!</h3>
    <div class="jarlInVillageContainer">
      <p>Available Jarls:</p>
      <img src="../../../assets/ui-items/Jarl.png" width="28px" height="21px" />
      <p v-if="properties.jarl">{{ properties.jarl.amount }}</p>
      <p v-else>0</p>
    </div>
    <div class="jarlInVillageContainer">
      <p>Required Jarls to Settle:</p>
      <img src="../../../assets/ui-items/Jarl.png" width="28px" height="21px" />
      <p v-if="jarlsNeededToSettle > 0">{{ jarlsNeededToSettle }}</p>
      <p v-else>0</p>
    </div>
    <button v-if="hasEnoughJarls()" class="baseButton" @click="settleLand">Settle!</button>
    <p v-else>Not enough Jarls to Settle!</p>
  </div>
</template>

<script>
export default {
  props: ['properties'],
  computed: {
    village: function () {
      return this.$store.getters.village;
    },
    jarlsNeededToSettle: function () {
      return this.$store.getters.jarlsNeededToSettle;
    },
  },
  methods: {
    settleLand: function () {
      const SettleData = {
        villageId: this.village.villageId,
        newPosition: {
          x: this.properties.tileData.x,
          y: this.properties.tileData.y,
        },
      };
      console.log(SettleData);
      this.$store
        .dispatch('SettleLand', SettleData)
        .then((data) => {
          this.$toaster.success('Claiming new land!');
          this.updateVillageList();
        })
        .catch((err) => {
          this.$toaster.error(err);
        });
    },
    updateVillageList: function () {
      this.$store.dispatch('fetchVillageList');
      this.$emit('close');
    },
    hasEnoughJarls() {
      if (!this.properties.jarl) {
        return false;
      }
      return this.properties.jarl.amount >= this.jarlsNeededToSettle;
    },
  },
};
</script>

<style lang="scss">
.SettleConatiner {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  button {
    margin-right: 0px;
    margin-top: 14px;
  }
  .jarlInVillageContainer {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    p {
      margin-left: 14px;
      margin-right: 14px;
    }
  }
}
</style>
