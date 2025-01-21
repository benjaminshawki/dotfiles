<template>
  <div>
    <div class="populationFrame">
      <img class="populationImg" src="../../assets/ui-items/populationIcon.png" />
      <p :style="{ color: hasEnoughPopulation() ? 'white' : 'red' }">{{ populationLeft }}</p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'PopulationFrame',
  props: ['population', 'populationLeft', 'checkAvailability'],

  computed: {
    village: function () {
      return this.$store.getters.village;
    },
  },
  methods: {
    hasEnoughPopulation() {
      if (this.checkAvailability) {
        return this.village.populationLeft >= this.populationLeft;
      }
      return true;
    },
  },
};
</script>

<style scoped lang="scss">
.populationFrame {
  display: flex;
  flex-direction: row;
  z-index: 10;
  border: 5px solid transparent;
  background-color: rgb(104, 104, 104);
  border-image: url('../../assets/borders_modal.png') 40% stretch;
  min-width: 85px;
  height: 23px;
  margin-right: 5px;
  justify-content: flex-start;
  align-items: center;
  p {
    color: white;
    font-size: 14px;
    margin-left: 5px;
    margin-right: 5px;
  }
  .populationImg {
    width: 25px;
    height: 25px;
    margin-left: 5px;
  }
}
</style>
