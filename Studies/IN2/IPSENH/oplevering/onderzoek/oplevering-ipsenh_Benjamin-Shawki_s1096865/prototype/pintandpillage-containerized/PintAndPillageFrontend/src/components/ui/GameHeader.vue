<template>
  <div class="header">
    <div class="resources">
      <resources />
    </div>
    <div class="villageSelectorComp">
      <village-selector :villageList="this.villageList" />
    </div>
    <div class="buttonDiv">
      <button
        class="mapButton"
        @click="showWorldMap"
        :class="{ villageButton: isOnWorldMap }"
      ></button>
      <button class="combatButtonHeader" @click="showModal('Combat')"></button>
      <button
        v-if="quests"
        v-bind:class="fetchQuestButtonCssClass()"
        @click="showModal('Quest')"
      ></button>
      <button class="settingsButton" @click="showModal('Settings')"></button>
      <button
        v-bind:class="fetchLogButtonCssClass()"
        @click="showModalAndUpdateNewLogAvailableToFalse('Logs')"
      ></button>
    </div>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      isOnWorldMap: false,
    };
  },
  created: function () {
    this.isOnWorldMap = this.$route.path !== '/';
  },
  computed: {
    newLogAvailable: function () {
      return this.$store.getters.newLogAvailable;
    },
    questCompleted: function () {
      return this.$store.getters.questCompleted;
    },
    firstTimeLoggedInQuestOpened: function () {
      return this.$store.state.questsOpened;
    },
    village: function () {
      return this.$store.getters.village;
    },
    villageList: function () {
      return this.$store.getters.villageList;
    },
    currentSeason: function () {
      return this.$store.state.currentSeason;
    },
    isSeasonEnabled: function () {
      return this.$store.state.seasonsEnabled;
    },
    quests: function () {
      return this.$store.getters.quests;
    },
  },
  watch: {
    village: function () {
      if (this.questCompleted) {
        this.showModal('Quest');
      }
    },
    firstTimeLoggedInQuestOpened: function () {
      if (this.firstTimeLoggedInQuestOpened) {
        this.showModal('Quest');
        this.$store.state.questsOpened = false;
      }
    },
  },
  methods: {
    fetchLogButtonCssClass: function () {
      if (this.currentSeason === 'winter' && this.isSeasonEnabled) {
        if (this.newLogAvailable) {
          return 'gameLogsButtonBlinkWinter';
        }
        return 'gameLogsButtonWinter';
      } else {
        if (this.newLogAvailable) {
          return 'gameLogsButtonBlink';
        }
        return 'gameLogsButton';
      }
    },
    fetchQuestButtonCssClass: function () {
      if (this.questCompleted) {
        return 'questBlinking';
      }
      return 'questButton';
    },
    showModalAndUpdateNewLogAvailableToFalse: function (modalName) {
      this.showModal(modalName);
      this.updateNewLogAvailableToFalse();
    },
    updateNewLogAvailableToFalse: function () {
      this.$store.state.newLogAvailable = false;
    },
    showWorldMap: function () {
      if (this.$route.path === '/') {
        this.$router.push('/world');
        this.isOnWorldMap = true;
      } else {
        this.isOnWorldMap = false;
        const villageId = this.$store.getters.village.villageId;
        this.$store.dispatch('fetchVillage', villageId);
        this.$router.push('/');
      }
    },
    showModal: function (modalName) {
      this.$emit('showModal', modalName);
    },
  },
};
</script>

<style lang="scss" scoped>
@-webkit-keyframes blinking {
  from {
    filter: drop-shadow(0px 0px 12px rgb(247, 156, 0));
  }
  to {
    filter: none;
  }
}
.header {
  width: 100%;
  height: 85px;
  background: transparent url('../../assets/ui-items/header_img.png');
  background-size: 100% 85px;
  display: flex;
  flex-direction: row;
  position: absolute !important;
  z-index: 200;
}
.resources {
  margin-left: 2%;
  margin-top: -35px;
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
}

.villageSelectorComp {
  position: fixed;
  margin-top: 30px;
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  /*margin: auto 5% auto auto;*/
}
.buttonDiv {
  display: flex;
  flex-direction: row;
  width: 100%;
  justify-content: flex-end;
  margin-right: 1%;
  .mapButton,
  .settingsButton,
  .villageButton,
  .questButton,
  .questBlinking,
  .combatButtonHeader {
    width: 90px;
    height: 70px;
    margin-left: 12px;
    margin-top: 30px;
    margin-right: 12px;
    background-color: transparent;
    border: none;
    background-image: url('../../assets/ui-items/map_icon.png');
    background-size: 80px 70px;
    background-repeat: no-repeat;
    z-index: 200;
  }
  .combatButtonHeader {
    background-image: url('../../assets/ui-items/combat_icon.png') !important;
  }
  .villageButton {
    background-image: url('../../assets/ui-items/village_icon.png') !important;
  }
  .settingsButton {
    background-image: url('../../assets/ui-items/settings_icon.png') !important;
  }
  .questButton {
    background-image: url('../../assets/ui-items/quest_icon.png') !important;
  }
  .questBlinking {
    background-image: url('../../assets/ui-items/quest_icon.png') !important;
    -webkit-animation-name: blinking;
    -webkit-animation-duration: 0.8s;
    -webkit-animation-iteration-count: infinite;
    -webkit-animation-timing-function: ease-in-out;
    -webkit-animation-direction: alternate;
  }
  .gameLogsButton,
  .gameLogsButtonBlink {
    width: 190px;
    height: 210px;
    display: flex;
    flex-direction: row;
    background-image: url('../../assets/ui-items/log_head.png');
    background-size: 175px 200px;
    background-color: transparent;
    border: none;
    margin-top: -20px;
    background-repeat: no-repeat;
  }
  .gameLogsButtonWinter,
  .gameLogsButtonBlinkWinter {
    width: 190px;
    height: 210px;
    display: flex;
    flex-direction: row;
    background-image: url('../../assets/ui-items/winter_ui/loghead.png');
    background-size: 175px 200px;
    background-color: transparent;
    border: none;
    margin-top: -20px;
    background-repeat: no-repeat;
  }
  .gameLogsButtonBlink,
  .gameLogsButtonBlinkWinter {
    -webkit-animation-name: blinking;
    -webkit-animation-duration: 0.8s;
    -webkit-animation-iteration-count: infinite;
    -webkit-animation-timing-function: ease-in-out;
    -webkit-animation-direction: alternate;
  }

  .mapButton:hover,
  .settingsButton:hover,
  .gameLogsButton:hover,
  .gameLogsButtonWinter:hover,
  .questButton:hover,
  .questBlinking:hover,
  .combatButtonHeader:hover {
    opacity: 1 !important;
    background-size: 90px 80px;
    height: 80px;
    width: 90px;
  }
  .gameLogsButton:hover,
  .gameLogsButtonBlink:hover {
    opacity: 1 !important;
    background-size: 190px 210px;
    width: 190px;
    height: 210px;
    background-image: url('../../assets/ui-items/logsHeadIcon_mouth.png');
  }
  .gameLogsButtonWinter:hover,
  .gameLogsButtonBlinkWinter:hover {
    opacity: 1 !important;
    background-size: 190px 210px;
    width: 190px;
    height: 210px;
    background-image: url('../../assets/ui-items/winter_ui/loghead_icon_mouth.png');
  }
}
</style>
