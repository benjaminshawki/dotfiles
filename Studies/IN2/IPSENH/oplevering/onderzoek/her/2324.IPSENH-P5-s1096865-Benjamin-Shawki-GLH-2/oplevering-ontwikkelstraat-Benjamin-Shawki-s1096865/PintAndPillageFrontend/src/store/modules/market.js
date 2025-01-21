import axios from 'axios';

const state = {
  marketOffers: null,
  offerDeleted: false,
};

const getters = {
  offers: (state) => {
    return state.marketOffers;
  },
};

const mutations = {
  offers_list_fetched(state, offersList) {
    state.marketOffers = offersList.data;
  },
  offers_deleted(state) {
    state.offerDeleted = true;
  },
};

const actions = {
  /* eslint-disable */
    makeMarketOffer({commit}, offer){
        return new Promise((resolve => {
            axios({url: '/api/market/offer', data: offer, method: 'POST' })
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
    makeVillageTrade({commit}, offer){
        return new Promise(((resolve, reject) => {
            axios({url: '/api/market/transfer', data: offer, method: 'POST' })
                .then(resp => {
                    console.log(resp)
                    commit('village_fetched', resp);
                    commit('create_building', true);
                    resolve(resp)
                })
                .catch(err => {
                    console.log(err)
                    reject(err)
                })
        }))
    },
    fetchMarketOffers({commit}){
        return new Promise((resolve => {
            axios({url: '/api/market/', method: 'GET' })
                .then(resp => {
                    commit('offers_list_fetched', resp);
                    resolve(resp)
                })
                .catch(err => {
                    console.log(err)
                })
        }))
    },
    acceptMarketOffer({commit}, acceptanceData){
        return new Promise((resolve => {
            axios({url: '/api/market/acceptOffer', data: acceptanceData, method: 'POST' })
                .then(resp => {
                    commit('village_fetched', resp);
                    resolve(resp)
                })
                .catch(err => {
                    console.log(err)
                })
        }))
    },
    deleteMarketOffer({commit}, offerId){
        return new Promise((resolve => {
            axios({url: '/api/market/offer/' + offerId, method: 'DELETE' })
                .then(resp => {
                    commit('offers_deleted', true);
                    resolve(resp)
                })
                .catch(err => {
                    console.log(err)
                })
        }))
    },
};
/* eslint-disable */
export default{
    state,
    getters,
    mutations,
    actions
}
