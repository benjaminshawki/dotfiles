<template>
  <div class="storageFrame">
    <div class="storageContainer">
      <img src="../../../assets/ui-items/storage_icon.png" width="98px" height="84px" />
      <div class="storageTitleContainer">
        <h1>{{ building.name }} - Lv {{ building.level }}</h1>
        <h2>Capacity : {{ building.resourceCapacity }}</h2>
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
.storageFrame {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  .storageContainer {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 56px;
    flex-direction: row;
    min-width: 315px;
    height: 105px;
    border: 14px solid transparent;
    border-image: url('../../../assets/borders_modal.png') 40% stretch;
    background-color: #434343;

    .storageTitleContainer {
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
