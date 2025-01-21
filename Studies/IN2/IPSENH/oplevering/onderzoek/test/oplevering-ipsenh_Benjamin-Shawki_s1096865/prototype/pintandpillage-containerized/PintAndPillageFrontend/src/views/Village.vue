<template>
  <div class="village">
    <modal
      v-if="isModalVisible"
      :buildingName="buildingName"
      :buildingId="buildingId"
      :position="position"
      :allowed-building="allowedBuilding"
      @close="closeModal"
    />

    <settings-modal v-if="settingsOpened" @close="closeModal" />

    <tutorial-modal v-if="firstTimeLoggedIn" @close="closeModal" />

    <logs-modal v-if="logsOpened" @close="closeModal" />

    <combat-logs-modal v-if="combatLogOpen" @close="closeModal" />
    <villagegrid-component
      class="villageComp"
      @toggleModal="showModal($event)"
    ></villagegrid-component>
  </div>
</template>

<script>
import TutorialModal from '../components/ui/modals/TutorialModal';
export default {
  name: 'home',
  components: { TutorialModal },
  data() {
    return {
      isModalVisible: false,
      settingsOpened: false,
      logsOpened: false,
      tutorialOpened: false,
      combatLogOpen: false,
      buildingName: '',
      buildingId: '',
      position: '',
      allowedBuilding: '',
    };
  },
  computed: {
    firstTimeLoggedIn: function () {
      return this.$store.getters.firstLogin;
    },
  },

  methods: {
    closeModal: function () {
      this.isModalVisible = false;
      this.settingsOpened = false;
      this.logsOpened = false;
      this.tutorialOpened = false;
      this.combatLogOpen = false;
    },
    showModal: function (tileData) {
      this.isModalVisible = false;
      this.isModalVisible = true;
      this.buildingName = tileData.name;
      if (tileData.buildingId) {
        this.buildingId = tileData.buildingId;
      }
      this.allowedBuilding = tileData.allowedBuilding;
      this.position = tileData.position;
    },
    showSettings: function () {
      this.isModalVisible = false;
      this.settingsOpened = true;
    },
    showTutorial: function () {
      this.isModalVisible = false;
      this.tutorialOpened = true;
    },
    showLogs: function () {
      this.isModalVisible = false;
      this.logsOpened = true;
    },
    showCombatLog: function () {
      this.isModalVisible = false;
      this.combatLogOpen = true;
    },
  },
};
</script>

<style lang="scss">
.village {
  background-color: transparent;
}

.gameHeader {
  background-color: transparent;
  /*position: fixed;*/
  position: relative;
  z-index: 100;
}

.villageComp {
  position: relative;
  z-index: 0;
}
</style>
