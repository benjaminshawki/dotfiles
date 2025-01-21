<template>
  <div class="defenceFrame">
    <div class="defenceContainer">
      <img src="../../../assets/ui-items/defence_icon.png" width="98px" height="84px" />
      <div class="defenceTitleContainer">
        <h1>{{ building.name }} - Lv {{ building.level }}</h1>
        <h2>Defence bonus : {{ building.defenceBonus }}</h2>
      </div>
    </div>
    <level-up-building @close="close" :buildingId="buildingId"></level-up-building>
  </div>
</template>

<script>
export default {
  props: ['buildingId'],
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
.defenceFrame {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  .defenceContainer {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 56px;
    flex-direction: row;
    min-width: 385px;
    height: 105px;
    border: 14px solid transparent;
    border-image: url('../../../assets/borders_modal.png') 40% stretch;
    background-color: #434343;

    .defenceTitleContainer {
      margin-left: 28px;
      h1,
      h2 {
        margin-top: 0px;
        margin-bottom: 0px;
      }
    }
  }
}
</style>
