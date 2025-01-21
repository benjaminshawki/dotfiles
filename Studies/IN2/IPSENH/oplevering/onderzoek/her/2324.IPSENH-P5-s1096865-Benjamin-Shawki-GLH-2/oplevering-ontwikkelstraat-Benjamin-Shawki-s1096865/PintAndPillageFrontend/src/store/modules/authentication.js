import axios from 'axios';

const state = {
  status: null,
  token: localStorage.getItem('token') || null,
  user: {},
};

const getters = {
  /* eslint-disable */
    isLoggedIn: (state) => !!state.token,
    authStatus: (state) => state.status,
};

const mutations = {
    auth_request(state) {
        state.status = "loading";
    },
    auth_success(state, token, user) {
        state.status = "success";
        state.token = token;
        state.user = user;
    },
    auth_error(state) {
        state.status = "error";
    },
    logout(state) {
        state.status = null;
        state.token = null;
    },
};

const actions = {
    /* eslint-disable */
    login({ commit }, user) {
        return new Promise((resolve, reject) => {
            commit("auth_request");
            axios({ url: "/api/auth/login", data: user, method: "POST" })
                .then((resp) => {
                    const token = resp.data.token;
                    const user = resp.data.user;
                    const firstTimeLogin = resp.data.isFirstTimeLoggedIn;
                    localStorage.setItem("token", token);
                    commit("auth_success", token, user);
                    commit("firstTimeLogin", firstTimeLogin);
                    resolve(resp);
                })
                .catch((err) => {
                    commit("auth_error");
                    localStorage.removeItem("token");
                    reject(err);
                });
        });
    },
    register({ commit }, user) {
        return new Promise((resolve, reject) => {
            commit("auth_request");
            axios({ url: "/api/auth/register", data: user, method: "POST" })
                .then((resp) => {
                    const token = resp.data.token;
                    const user = resp.data.user;
                    localStorage.setItem("token", token);
                    axios.defaults.headers.common["Authorization"] = token;
                    commit("auth_success", token, user);
                    resolve(resp);
                })
                .catch((err) => {
                    commit("auth_error", err);
                    localStorage.removeItem("token");
                    reject(err);
                });
        });
    },
    resetPassword({ commit }, data) {
        return new Promise((resolve, reject) => {
            axios({ url: "/api/auth/reset", data: data, method: "POST" })
                .then((resp) => {
                    resolve(resp);
                })
                .catch((err) => {
                    reject(err);
                });
        });
    },
    newPassword({ commit }, data) {
        return new Promise((resolve, reject) => {
            axios({ url: "/api/auth/newPassword", data: data, method: "POST" })
                .then((resp) => {
                    resolve(resp);
                })
                .catch((err) => {
                    reject(err);
                });
        });
    },
    logout({ commit }) {
        // eslint-disable-next-line no-unused-vars
        return new Promise((resolve, reject) => {
            commit("logout");
            localStorage.removeItem("token");
            delete axios.defaults.headers.common["Authorization"];
            resolve();
        });
    },
    confirm({ commit }, confirmdata) {
        return new Promise((resolve, reject) => {
            axios({
                url: "/api/auth/confirm",
                data: confirmdata,
                method: "POST",
                headers: { "Content-Type": "application/json" },
            }).then((resp) => {
                const token = resp.data.token;
                const user = resp.data.user;
                localStorage.setItem("token", token);
                commit("auth_success", token, user);
                resolve(resp);
            });
        });
    },
};
/* eslint-disable */
export default {
    state,
    getters,
    mutations,
    actions,
};
