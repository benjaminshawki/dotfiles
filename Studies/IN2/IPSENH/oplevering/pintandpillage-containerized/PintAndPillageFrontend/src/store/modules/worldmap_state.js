import axios from 'axios';

const state = {
  showSettleTiles: false,
  jarlsNeededToSettle: 0,
  SettleableSpots: [],
};

const getters = {
  showSettleTiles: (state) => state.showSettleTiles,
  SettleableSpots: (state) => state.SettleableSpots,
  jarlsNeededToSettle: (state) => state.jarlsNeededToSettle,
};

const mutations = {
  toggleSettleTiles(state) {
    state.showSettleTiles = !state.showSettleTiles;
    if (!state.showSettleTiles) {
      state.SettleableSpots = [];
    }
  },
  SettleableSpots(state, spots) {
    state.SettleableSpots = spots;
  },
  jarlsNeededToSettle(state, jarls) {
    state.jarlsNeededToSettle = jarls;
  },
};

const actions = {
  toggleSettleTiles({ commit }, id) {
    return new Promise((resolve, reject) => {
      axios({ url: '/api/world/settlespots/' + id, method: 'GET' })
        .then((resp) => {
          resolve(resp);
          commit('toggleSettleTiles');
          commit('SettleableSpots', resp.data.validPositions);
          commit('jarlsNeededToSettle', resp.data.amountOfJarlsNeeded);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  turnShowSettleTilesOff({ commit, state }) {
    console.log(state.showSettleTiles);
    if (state.showSettleTiles) {
      commit('toggleSettleTiles');
    }
  },
};

/* eslint-disable */
export default{
    state,
    getters,
    mutations,
    actions
}
