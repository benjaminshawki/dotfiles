import Vue from 'vue';
import Vuex from 'vuex';
import axios from 'axios';
import authentication from './modules/authentication';
import market from './modules/market';
import village_state from './modules/village_state';
import worldmap_state from './modules/worldmap_state';

Vue.use(Vuex);
/* eslint-disable */
export default new Vuex.Store({
  state: {
    status: null,
    village: {},
    newLogAvailable: false,
    villageUpdate: false,
    villageList: {},
    firstLogin: false,
    questsOpened: false,
    seasonsEnabled: true,
    currentSeason: null,
    allCombatLogs: [],
  },
  mutations: {
    village_fetched(state, village) {
      state.village = village;
    },
    village_update_new_log_status(state, logStatus) {
      state.newLogAvailable = logStatus;
    },
    village_updated(state) {
      state.villageUpdate = true;
    },
    create_building(state, villageUpdate) {
      state.status = 'succes';
      state.villageUpdate = villageUpdate;
    },
    village_list_fetched(state, villageList) {
      state.status = 'succes';
      state.villageList = villageList;
    },
    firstTimeLogin(state, firstLogin) {
      state.status = 'succes';
      state.firstLogin = firstLogin;
    },
    seasons_enabled(state, value) {
      state.seasonsEnabled = value;
    },
    current_season(state, value) {
      state.currentSeason = value;
    },
    combat_logs_fetched(state, logs) {
      state.allCombatLogs = logs;
    },
  },
  actions: {
    createUnit({ commit }, unit) {
      return new Promise((resolve, reject) => {
        axios({ url: '/api/production/train/', data: unit, method: 'POST' })
          .then((resp) => {
            commit('village_fetched', resp);
            commit('create_building', true);
            resolve(resp);
          })
          .catch((err) => {
            commit('auth_error', err);
            reject(err);
          });
      });
    },
    getWorldmap() {
      return new Promise((resolve, reject) => {
        axios({ url: '/api/world', method: 'GET' })
          .then((resp) => {
            resolve(resp);
          })
          .catch((err) => {
            reject(err);
          });
      });
    },
    fetchHighscore() {
      return new Promise((resolve, reject) => {
        axios({ url: '/api/world/highscore', method: 'GET' })
          .then((resp) => {
            resolve(resp);
          })
          .catch((err) => {
            reject(err);
          });
      });
    },
    startResearch({ commit }, research) {
      return new Promise((resolve, reject) => {
        axios({ url: '/api/research/', data: research, method: 'POST' })
          .then((resp) => {
            commit('village_fetched', resp);
            resolve(resp);
          })
          .catch((err) => {
            reject(err);
          });
      });
    },
    attackVillage({ commit }, attackData) {
      return new Promise((resolve, reject) => {
        axios({ url: '/api/combat', data: attackData, method: 'POST' })
          .then((resp) => {
            commit('village_fetched', resp);
            resolve(resp);
          })
          .catch((err) => {
            reject(err);
          });
      });
    },
    SettleLand({ commit }, SettleData) {
      return new Promise((resolve, reject) => {
        axios({ url: '/api/village/startNew', data: SettleData, method: 'POST' })
          .then((resp) => {
            resolve(resp);
          })
          .catch((err) => {
            reject(err);
          });
      });
    },
    finishQuest({ commit }, villageId) {
      return new Promise((resolve, reject) => {
        axios({ url: '/api/village/finishQuest/' + villageId, method: 'POST' })
          .then((resp) => {
            commit('village_fetched', resp);
            resolve(resp);
          })
          .catch((err) => {
            reject(err);
          });
      });
    },
  },
  getters: {
    village: (state) => {
      return state.village.data;
    },
    villageList: (state) => {
      return state.villageList.data;
    },
    newLogAvailable: (state) => {
      return state.newLogAvailable;
    },
    resources: (state, getters) => {
      if (getters.village) {
        return state.village.data.villageResources;
      }
      return null;
    },
    building: (state) => (id) => {
      let village = state.village.data;
      for (let i = 0; i < village.buildings.length; i++) {
        if (village.buildings[i].buildingId === id) {
          return village.buildings[i];
        }
      }
    },
    firstLogin: (state) => {
      return state.firstLogin;
    },
    questCompleted: (state, getters) => {
      if (getters.village && getters.village.quest) {
        return state.village.data.quest.isCompleted;
      }
      return null;
    },
    buildingList: (state, getters) => {
      if (getters.village) {
        return state.village.data.buildings;
      }
      return null;
    },
    unitsList: (state, getters) => {
      if (getters.village) {
        return state.village.data.unitsInVillage;
      }
      return null;
    },
    quests: (state, getters) => {
      if (getters.village) {
        return state.village.data.quest;
      }
    },
    combatLogs: (state) => {
      return state.allCombatLogs;
    },
    incomingAttacks: (state, getters) => {
      if (!getters.village) {
        return [];
      }
      return getters.village.incomingAttacks;
    },
    outgoingAttacks: (state, getters) => {
      if (!getters.village) {
        return [];
      }
      return getters.village.outgoingAttacks;
    },

    returningCombatTravels: (state, getters) => {
      if (!getters.village) {
        return [];
      }
      return getters.village.returningCombatTravels;
    },
  },
  modules: {
    village_state,
    worldmap_state,
    authentication,
    market,
  },
});
