<template>
  <div>
    <modal
      :building-name="modalName"
      :properties="villageProperties"
      v-if="isModalVisible"
      @close="closeModal"
    />
    <settings-modal v-if="settingsOpened" @close="closeModal" />
    <logs-modal v-if="logsOpened" @close="closeModal" />
    <tutorial-modal v-if="tutorialOpened" @close="closeModal" />
    <combat-logs-modal v-if="combatLogOpen" @close="closeModal" />
    <world-map @toggleModal="showModal($event)"></world-map>
  </div>
</template>

<script>
/* eslint-disable no-console */
import WorldMap from '../components/WorldMap';
export default {
  name: 'World',
  components: { WorldMap },
  data: function () {
    return {
      isModalVisible: false,
      settingsOpened: false,
      tutorialOpened: false,
      combatLogOpen: false,
      modalName: null,
      logsOpened: false,
      villageProperties: null,
    };
  },
  methods: {
    closeModal() {
      this.isModalVisible = false;
      this.settingsOpened = false;
      this.logsOpened = false;
      this.tutorialOpened = false;
      this.combatLogOpen = false;
    },
    showModal(modal) {
      this.modalName = modal.name;
      this.isModalVisible = true;
      this.villageProperties = modal.properties;
    },
    showSettings: function () {
      this.isModalVisible = false;
      this.settingsOpened = true;
    },
    showLogs: function () {
      this.isModalVisible = false;
      this.logsOpened = true;
    },
    showTutorial: function () {
      this.isModalVisible = false;
      this.tutorialOpened = true;
    },
    showCombatLog: function () {
      this.isModalVisible = false;
      this.combatLogOpen = true;
    },
  },
};
</script>

<style scoped lang="scss"></style>
