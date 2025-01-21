import axios from 'axios';

const state = {
  zoomState: 0.4,
  zoomPerStep: 0.1,
  maxZoom: 4,
  minZoom: 0.1,
};

const getters = {
  zoomState: (state) => state.zoomState,
  zoomPerStep: (state) => state.zoomPerStep,
};

const mutations = {
  changeZoom(state, newZoom) {
    if (newZoom >= state.minZoom && newZoom <= state.maxZoom) {
      state.zoomState = newZoom;
    }
  },
};

const actions = {
  /* eslint-disable */
    updateZoomState({commit}, newZoomLevel){
        commit('changeZoom', newZoomLevel);
    },
    fetchVillage({commit}, villageId){
        return new Promise((resolve) => {
            axios({url: '/api/village/' + villageId, method: 'GET' })
                .then(resp => {
                    commit('village_fetched', resp);
                    commit('village_update_new_log_status', resp.data.newLogAvailable);
                    resolve(resp)
                })
                .catch(err => {
                    console.log(err)
                })
        })
    },
    fetchVillageList({commit}){
        return new Promise((resolve => {
            axios({url: '/api/village/', method: 'GET' })
                .then(resp => {
                    commit('village_list_fetched', resp);
                    resolve(resp)
                })
                .catch(err => {
                    console.log(err)
                })
        }))
    },
    updateVillageName({commit}, newVillage){
        return new Promise((resolve, reject) => {
            axios({url: '/api/village/changename/' + newVillage.villageId, data: newVillage.newVillageData, method: 'POST' })
                .then(resp => {
                    resolve(resp)
                })
                .catch(err => {
                    reject(err)
                })
        })
    },
    createBuilding({commit}, building){
        return new Promise((resolve => {
            axios({url: '/api/building/build', data: building, method: 'POST' })
                .then(resp => {
                    commit('village_fetched', resp);
                    commit('create_building', true);
                    resolve(resp)
                })
                .catch(err => {
                    console.log(err)
                })
        }))
    },
    removeBuilding({commit}, buildingId){
        return new Promise((resolve => {
            axios({url: '/api/building/remove/' + buildingId, method: 'POST' })
                .then(resp => {
                    commit('village_fetched', resp);
                    resolve(resp)
                })
                .catch(err => {
                    console.log(err)
                })
        }))
    },
    updateBuilding({commit}, buildingId){
        return new Promise((resolve => {
            axios({url: '/api/building/levelup/' + buildingId, method: 'POST' })
                .then(resp => {
                    commit('village_fetched', resp);
                    commit('create_building', true);
                    resolve(resp)
                })
                .catch(err => {
                    console.log(err)
                })
        }))
    },
    fetchCombatLogs({commit}) {
        return new Promise(resolve => {
            axios({url: '/api/village/attackLogs', method: 'GET' })
                .then(resp => {
                    commit('combat_logs_fetched', resp.data);
                    resolve(resp)
                })
                .catch(err => {
                    console.log(err)
                })
        })
    }
};
/* eslint-disable */
export default{
    state,
    getters,
    mutations,
    actions
}
