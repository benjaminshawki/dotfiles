<template>
  <div class="overlayModals">
    <building-time-modal v-show="isVillage" />
    <units-in-village-modal v-show="isVillage" />
    <incoming-attacks-modal v-show="isVillage" />
    <zoom-modal class="zoomModal" v-show="isVillage" />
    <world-map-settings-modal class="worldMapSettingsModal" v-if="isWorldMap && !isVillage" />
  </div>
</template>

<script>
export default {
  props: ['isVillage', 'isWorldMap'],
};
</script>

<style lang="scss">
.overlayModals {
  display: flex;
  flex-direction: column;
  position: fixed;
  top: 100px;
  z-index: 1;

  .zoomModal {
    bottom: 100px;
    position: fixed;
    right: 100px;
  }
  .worldMapSettingsModal {
    bottom: 50px;
    position: fixed;
    right: 50px;
  }
}
</style>
