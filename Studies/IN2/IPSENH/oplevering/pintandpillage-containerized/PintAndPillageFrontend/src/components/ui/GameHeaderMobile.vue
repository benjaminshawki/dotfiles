<template>
  <div class="headerMobile">
    <div class="resourcesMobile">
      <resources />
    </div>
    <div class="villageSelectorCompMobile">
      <village-selector :villageList="this.villageList" />
    </div>
    <div class="buttonDivMobile">
      <button
        class="mapButtonMobile"
        @click="showWorldMap"
        :class="{ villageButton: isOnWorldMap }"
      ></button>
      <button class="combatButtonHeaderMobile" @click="showModal('Combat')"></button>
      <button v-bind:class="fetchQuestButtonCssClass()" @click="showModal('Quest')"></button>
      <button class="settingsButtonMobile" @click="showModal('Settings')"></button>
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
          return 'gameLogsButtonBlinkWinterMobile';
        }
        return 'gameLogsButtonWinterMobile';
      } else {
        if (this.newLogAvailable) {
          return 'gameLogsButtonBlinkMobile';
        }
        return 'gameLogsButtonMobile';
      }
    },
    fetchQuestButtonCssClass: function () {
      if (this.questCompleted) {
        return 'questBlinkingMobile';
      }
      return 'questButtonMobile';
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
        this.$store.commit('village_updated');
        this.isOnWorldMap = false;
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
.headerMobile {
  width: 100%;
  height: 85px;
  background: transparent url('../../assets/ui-items/header_img.png');
  background-size: 100% 85px;
  display: flex;
  flex-direction: row;
  position: absolute !important;
  z-index: 200;
}
.resourcesMobile {
  margin-left: 2%;
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  margin-right: 0px;
  position: fixed;
  bottom: 100px;
  left: 10%;
  zoom: 140%;
}

.villageSelectorCompMobile {
  position: fixed;
  margin-top: 30px;
  width: 100%;
  display: flex;
  justify-content: flex-start;
  margin-left: 100px;
  align-items: center;
  /*margin: auto 5% auto auto;*/
}
.buttonDivMobile {
  display: flex;
  flex-direction: row;
  width: 100%;
  justify-content: flex-end;
  margin-right: 1%;
  .mapButtonMobile,
  .settingsButtonMobile,
  .villageButtonMobile,
  .questButtonMobile,
  .questBlinkingMobile,
  .combatButtonHeaderMobile {
    width: 80px;
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
  .combatButtonHeaderMobile {
    background-image: url('../../assets/ui-items/combat_icon.png') !important;
  }
  .villageButtonMobile {
    background-image: url('../../assets/ui-items/village_icon.png') !important;
  }
  .settingsButtonMobile {
    background-image: url('../../assets/ui-items/settings_icon.png') !important;
  }
  .questButtonMobile {
    background-image: url('../../assets/ui-items/quest_icon.png') !important;
  }
  .questBlinkingMobile {
    background-image: url('../../assets/ui-items/quest_icon.png') !important;
    -webkit-animation-name: blinking;
    -webkit-animation-duration: 0.8s;
    -webkit-animation-iteration-count: infinite;
    -webkit-animation-timing-function: ease-in-out;
    -webkit-animation-direction: alternate;
  }
  .gameLogsButtonMobile,
  .gameLogsButtonBlinkMobile {
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
  .gameLogsButtonWinterMobile,
  .gameLogsButtonBlinkWinterMobile {
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
  .gameLogsButtonBlinkMobile,
  .gameLogsButtonBlinkWinterMobile {
    -webkit-animation-name: blinking;
    -webkit-animation-duration: 0.8s;
    -webkit-animation-iteration-count: infinite;
    -webkit-animation-timing-function: ease-in-out;
    -webkit-animation-direction: alternate;
  }
  .mapButtonMobile:hover,
  .settingsButtonMobile:hover,
  .gameLogsButtonMobile:hover,
  .gameLogsButtonWinterMobile:hover,
  .questButtonMobile:hover,
  .questBlinkingMobile:hover,
  .combatButtonHeaderMobile:hover {
    opacity: 1 !important;
    background-size: 90px 80px;
    height: 80px;
    width: 90px;
  }
  .gameLogsButtonMobile:hover,
  .gameLogsButtonBlinkMobile:hover {
    opacity: 1 !important;
    background-size: 190px 210px;
    width: 190px;
    height: 210px;
    background-image: url('../../assets/ui-items/logsHeadIcon_mouth.png');
  }
  .gameLogsButtonWinterMobile:hover,
  .gameLogsButtonBlinkWinterMobile:hover {
    opacity: 1 !important;
    background-size: 190px 210px;
    width: 190px;
    height: 210px;
    background-image: url('../../assets/ui-items/winter_ui/loghead_icon_mouth.png');
  }
}
</style>
