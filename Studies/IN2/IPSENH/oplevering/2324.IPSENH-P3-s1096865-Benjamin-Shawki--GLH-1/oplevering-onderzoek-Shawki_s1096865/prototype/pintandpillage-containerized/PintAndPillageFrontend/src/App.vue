<template>
  <div id="app">
    <div v-if="isMobile != true">
      <game-header
        @showModal="showModal($event)"
        v-if="this.$route.path === '/' || this.$route.path === '/world'"
      ></game-header>
    </div>
    <div v-else>
      <game-header-mobile
        @showModal="showModal($event)"
        v-if="this.$route.path === '/' || this.$route.path === '/world'"
      ></game-header-mobile>
    </div>

    <overlay-modals :is-world-map="isWorldMapView()" :isVillage="isVillageView()" />

    <transition name="component-fade" mode="out-in">
      <router-view ref="village"></router-view>
    </transition>
  </div>
</template>

<script>
import { isMobile } from 'mobile-device-detect';
import * as moment from 'moment';

export default {
  data: function () {
    return {
      isMobile: false,
      interval: null,
    };
  },
  created: function () {
    this.isMobile = isMobile;
    this.setCurrentSeason();
    this.interval = setInterval(() => {
      this.updateTimers(this.village);
    }, 1000);
  },
  computed: {
    village: function () {
      return this.$store.getters.village;
    },
  },
  beforeDestroy() {
    clearInterval(this.interval);
  },
  methods: {
    showModal: function (modalName) {
      switch (modalName) {
        case 'Settings':
          this.$refs.village.showSettings();
          break;
        case 'Logs':
          this.$refs.village.showLogs();
          break;
        case 'Tutorial':
          this.$refs.village.showTutorial();
          break;
        case 'Combat':
          this.$refs.village.showModal({ name: 'Combat' });
          break;
        case 'Quest':
          this.$refs.village.showModal({ name: 'Quest' });
          break;
      }
    },
    isVillageView: function () {
      if (this.$route.path === '/') {
        return true;
      }
      return false;
    },
    isWorldMapView: function () {
      console.log(this.$route.path);
      if (this.$route.path === '/world') {
        return true;
      }
      return false;
    },
    setCurrentSeason: function () {
      let seasonsEnabled = localStorage.getItem('seasons_enabled');
      if (seasonsEnabled === null) {
        localStorage.setItem('seasons_enabled', 'true');
        seasonsEnabled = 'true';
      }

      this.$store.commit('seasons_enabled', seasonsEnabled === 'true');

      const currentMonth = new Date().getMonth() + 1;
      const winterMonths = [12, 1, 2];
      if (winterMonths.includes(currentMonth)) {
        this.$store.commit('current_season', 'winter');
      }
    },
    updateTimers(obj) {
      if (!this.village) {
        return;
      }

      // let propNames = ['constructionTimeLeft','researchTimeLeft','totalTimeToProduce', 'traveltimeLeft'];
      const propNames = [
        'constructionTimeLeft',
        'totalTimeToProduce',
        'researchTimeLeft',
        'travelTimeLeft',
      ];
      for (const prop in obj) {
        if (Object.prototype.hasOwnProperty.call(obj, prop)) {
          if (typeof obj[prop] === 'object') {
            // In the production queue only the first item is actually counting down, so to avoid
            // all of them counting we only update the first one.
            if (prop === 'productionQueue') {
              this.updateTimers(obj[prop][0]);
              continue;
            }

            this.updateTimers(obj[prop]);
            continue;
          }
          if (propNames.includes(prop)) {
            if (!obj[prop] || obj[prop] === '00:00:00') continue;
            if (this.convertTimeToSeconds(obj[prop]) > 1) {
              obj[prop] = this.addSecond(obj[prop], -1);
            } else {
              setTimeout(this.updateVillage, 1000);
            }
          }
        }
      }
    },
    addSecond: function (prop, secs) {
      let seconds = this.convertTimeToSeconds(prop);
      seconds += secs;
      return this.convertSecondsToTime(prop, seconds);
    },
    convertTimeToSeconds: function (prop) {
      // let splittedTime = prop.split(':');
      // let seconds = 0;
      // if (splittedTime[0].includes('.')) {
      //     let dayandHour = splittedTime[0].split('.');
      //     splittedTime[0] = dayandHour[1];
      //     seconds += dayandHour[0] * 24 * 60 * 60;
      // }
      //
      // seconds += (+splittedTime[0]) * 60 * 60 + (+splittedTime[1]) * 60 + (+splittedTime[2]);
      return moment.duration(prop).asSeconds();
    },
    convertSecondsToTime: function (prop, seconds) {
      const days = Math.floor(seconds / (3600 * 24));
      seconds -= days * 3600 * 24;
      const hrs = Math.floor(seconds / 3600);
      seconds -= hrs * 3600;
      const mnts = Math.floor(seconds / 60);
      seconds -= mnts * 60;

      const formattedString =
        hrs.toString().padStart(2, '0') +
        ':' +
        mnts.toString().padStart(2, '0') +
        ':' +
        seconds.toString().padStart(2, '0');

      if (days === 0) {
        return formattedString;
      }

      return days.toString().padStart(2, '0') + '.' + formattedString;
    },
    updateVillage: function () {
      const villageId = this.$store.getters.village.villageId;
      this.$store.dispatch('fetchVillage', villageId);
    },
  },
};
</script>

<style lang="scss">
#app {
  height: 100%;
}
body {
  height: 100%;
  margin: 0;
  padding: 0;
  background-color: #c0c0c0;
  user-select: none;
}
* {
  font-family: 'Fjord One', serif;
}
*:focus {
  outline: 0 !important;
}
button {
  cursor: pointer;
}
button:hover {
  opacity: 0.75;
}
button:disabled {
  filter: grayscale(1);
  color: #7f7f7f;
  -webkit-filter: grayscale(1);
  opacity: 1;
  cursor: auto;
}
p {
  font-size: 14px;
}
h2 {
  font-size: 17px;
}
h1 {
  font-size: 22px;
}
h3 {
  font-size: 15px;
}
.baseButton {
  color: white;
  background-color: #15636c;
  border-radius: 3px;
  height: 35px;
  font-size: 14px;
  width: 105px;
  border: 3px solid #0f3b43;
  min-width: 105px;
  margin-right: 35px;
}
.component-fade-enter-active,
.component-fade-leave-active {
  transition: opacity 0.3s;
}
.component-fade-enter, .component-fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}
.tooltip {
  display: block !important;
  z-index: 10000;
  font-size: 12px;

  .tooltip-inner {
    background: black;
    color: white;
    border-radius: 8px;
    padding: 5px 10px 4px;
  }

  .tooltip-arrow {
    width: 0;
    height: 0;
    border-style: solid;
    position: absolute;
    margin: 5px;
    border-color: black;
    z-index: 1;
  }

  &[x-placement^='top'] {
    margin-bottom: 5px;

    .tooltip-arrow {
      border-width: 5px 5px 0 5px;
      border-left-color: transparent !important;
      border-right-color: transparent !important;
      border-bottom-color: transparent !important;
      bottom: -5px;
      left: calc(50% - 5px);
      margin-top: 0;
      margin-bottom: 0;
    }
  }

  &[x-placement^='bottom'] {
    margin-top: 5px;

    .tooltip-arrow {
      border-width: 0 5px 5px 5px;
      border-left-color: transparent !important;
      border-right-color: transparent !important;
      border-top-color: transparent !important;
      top: -5px;
      left: calc(50% - 5px);
      margin-top: 0;
      margin-bottom: 0;
    }
  }

  &[x-placement^='right'] {
    margin-left: 5px;

    .tooltip-arrow {
      border-width: 5px 5px 5px 0;
      border-left-color: transparent !important;
      border-top-color: transparent !important;
      border-bottom-color: transparent !important;
      left: -5px;
      top: calc(50% - 5px);
      margin-left: 0;
      margin-right: 0;
    }
  }

  &[x-placement^='left'] {
    margin-right: 5px;

    .tooltip-arrow {
      border-width: 5px 0 5px 5px;
      border-top-color: transparent !important;
      border-right-color: transparent !important;
      border-bottom-color: transparent !important;
      right: -5px;
      top: calc(50% - 5px);
      margin-left: 0;
      margin-right: 0;
    }
  }

  &[aria-hidden='true'] {
    visibility: hidden;
    opacity: 0;
    transition: opacity 0.15s, visibility 0.15s;
  }

  &[aria-hidden='false'] {
    visibility: visible;
    opacity: 1;
    transition: opacity 0.15s;
  }
}
::-webkit-scrollbar {
  width: 10px;
  height: 10px;
}
::-webkit-scrollbar-track {
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.1);
}
::-webkit-scrollbar-thumb {
  background-color: darkgrey;
  outline: 1px solid slategrey;
}
.scrollerFirefox {
  scrollbar-width: thin;
  scrollbar-color: darkgrey transparent;
}
input:invalid {
  box-shadow: none;
}
input[type='number']::-webkit-outer-spin-button,
input[type='number']::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

input[type='number'] {
  -moz-appearance: textfield;
}
input[type='range']::-moz-range-progress {
  background-color: #15bf17;
}
input[type='range']::-moz-range-track {
  background-color: #a2a2a2;
}
</style>
