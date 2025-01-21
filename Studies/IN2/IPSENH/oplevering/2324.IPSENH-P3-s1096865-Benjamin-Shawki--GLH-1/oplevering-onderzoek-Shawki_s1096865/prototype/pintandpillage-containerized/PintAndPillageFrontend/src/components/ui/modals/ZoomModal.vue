<template>
  <div class="zoomButtonContainer">
    <div class="zoomButton" @click="zoomIn">
      <p>+</p>
    </div>
    <div class="zoomButton" @click="zoomOut">
      <p>-</p>
    </div>
  </div>
</template>

<script>
export default {
  computed: {
    zoomState: function () {
      return this.$store.getters.zoomState;
    },
    zoomPerStep: function () {
      return this.$store.getters.zoomPerStep;
    },
  },
  methods: {
    zoomIn: function () {
      this.$store.dispatch('updateZoomState', this.zoomState + this.zoomPerStep);
    },
    zoomOut: function () {
      this.$store.dispatch('updateZoomState', this.zoomState - this.zoomPerStep);
    },
  },
};
</script>

<style lang="scss" scoped>
.zoomButtonContainer {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: row;

  .zoomButton {
    border: 5px solid transparent;
    background-color: rgb(104, 104, 104);
    border-image: url('../../../assets/borders_modal.png') 40% stretch;
    min-width: 40px;
    height: 40px;
    color: white;
    margin: 5px;
    display: flex;
    justify-content: center;
    align-items: center;
    p {
      font-size: 34px;
      margin: 0;
      padding: 0;
    }
  }
  .zoomButton:hover {
    opacity: 0.8;
  }
}
</style>
