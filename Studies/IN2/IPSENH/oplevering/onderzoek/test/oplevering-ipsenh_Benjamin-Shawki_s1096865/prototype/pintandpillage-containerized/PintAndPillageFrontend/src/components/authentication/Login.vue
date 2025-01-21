<template>
  <div class="login" @keydown.enter="login" v-if="isCompatibleBrowser()">
    <div class="loginBox">
      <div class="loginInputBox">
        <input
          id="login-email"
          class="inputField"
          type="text"
          v-model.trim="username"
          placeholder="Email"
        />
        <input
          id="login-password"
          class="inputField"
          type="password"
          v-model.trim="password"
          placeholder="Password"
        />
        <a class="redirects" @click="updateRoute('ResetPassword')">Reset password</a>
        <a class="redirects" @click="updateRoute('Register')">Create new account</a>
        <button id="login-button" class="submitButton" @click="login">Login</button>
      </div>
    </div>
  </div>

  <div v-else>
    <div class="uncompatibleBrowser">
      <img src="../../assets/login-logo.png" />
      <h1>Hi there,</h1>
      <h3>
        We are detecting that you are currently not using a compatible browser for this application.
        This is really annoying right? Well blame Internet Explorer for not joining in the latest
        trends and features of modern browsers. If you want to enjoy the spoils of Pint and Pillage
        head over to Chrome, Firefox or Edge. We look forward to your pillaging! <br /><br />
        Regards, <br />
        <br />
        Pint and Pillage Development Team
      </h3>
      <img src="../../assets/ui-items/logsHeadIcon_mouth.png" width="200px" />
    </div>
  </div>
</template>

<script>
/* eslint-disable */
import { required } from 'vuelidate/lib/validators';

export default {
  created() {
    this.$store.dispatch('logout');
  },
  data() {
    return {
      username: '',
      password: '',
    };
  },
  validations: {
    username: {
      required,
    },
    password: {
      required,
    },
  },
  methods: {
    isCompatibleBrowser: function () {
      let currentBrowser = navigator.userAgent;
      if (
        currentBrowser.indexOf('Chrome') != -1 ||
        currentBrowser.indexOf('Edge') != -1 ||
        currentBrowser.indexOf('Firefox') != -1
      ) {
        return true;
      }

      return false;
    },
    validateForm: function () {
      let validations = [
        [this.$v.username.required, 'Username is required'],
        [this.$v.password.required, 'Password is required'],
      ];
      for (let i = 0; i < validations.length; i++) {
        if (!validations[i][0]) {
          this.$toaster.error(validations[i][1]);
        }
      }
      return !this.$v.$invalid;
    },
    login: function () {
      if (this.validateForm()) {
        let data = {
          username: this.username,
          password: this.password,
        };
        this.$store
          .dispatch('login', data)
          .then(() => this.$router.push('/'))
          .catch((err) => {
            if (err.response.status === 401) {
              this.$toaster.error('Invalid credentials');
            } else {
              this.$toaster.error('Something went wrong');
            }
          });
      }
    },
    updateRoute: function (to) {
      this.$emit('updateRoute', to);
    },
  },
};
</script>

<style lang="scss">
.loginBox {
  background: url('../../assets/login_backdrop_with_torches.gif') no-repeat center;
  width: 700px;
  height: 600px;
  background-size: 700px 600px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.loginInputBox {
  margin-top: 100px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.uncompatibleBrowser {
  text-align: center;
  color: white;
  margin-left: 100px;
  margin-right: 100px;
  img {
    margin-top: 50px;
  }
}
</style>
