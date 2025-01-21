<template>
  <div class="register" @keydown.enter="register">
    <div class="registerBox">
      <transition name="fade" mode="out-in">
        <div key="1" class="registerInputBox">
          <input
            id="register-username"
            class="inputField"
            type="text"
            v-model.trim="username"
            placeholder="Username"
          />
          <input
            id="register-email"
            class="inputField"
            type="email"
            v-model.trim="email"
            placeholder="Email"
          />
          <input
            id="register-password"
            class="inputField"
            type="password"
            v-model.trim="password"
            placeholder="Password"
          />
          <input
            id="register-repeat-password"
            class="inputField"
            type="password"
            v-model.trim="repeatPassword"
            placeholder="Repeat password"
          />
          <a class="redirects" @click="updateRoute('Login')">Login</a>
          <a class="redirects" @click="updateRoute('ResetPassword')">Reset password</a>
          <button id="register-button" class="submitButton" @click="register">Register</button>
        </div>
        <!--                <div key=2 class="registerInputBox" v-else>-->
        <!--                    <p>Please check your email for the confirmation link</p>-->
        <!--                    <button class="submitButton" @click="updateRoute('Login')">Return to login</button>-->
        <!--                </div>-->
      </transition>
    </div>
  </div>
</template>

<script>
/* eslint-disable */
import { required, sameAs, email, minLength } from 'vuelidate/lib/validators';
export default {
  data() {
    return {
      username: '',
      email: '',
      password: '',
      repeatPassword: '',
      registered: false,
    };
  },
  validations: {
    username: {
      required,
    },
    email: {
      required,
      email,
    },
    password: {
      required,
      minLength: minLength(8),
    },
    repeatPassword: {
      required,
      sameAsPassword: sameAs('password'),
    },
  },
  methods: {
    validateForm: function () {
      let validations = [
        [this.$v.username.required, 'Username is required'],
        [this.$v.email.required, 'Email is required'],
        [this.$v.email.email, 'Email is invalid'],
        [this.$v.password.required, 'Password is required'],
        [
          this.$v.password.minLength,
          `Password must have at least ${this.$v.password.$params.minLength.min} characters`,
        ],
        [this.$v.repeatPassword.required, 'Password confirmation is required'],
        [this.$v.repeatPassword.sameAsPassword, "The passwords don't match"],
      ];
      for (let i = 0; i < validations.length; i++) {
        if (!validations[i][0]) {
          this.$toaster.error(validations[i][1]);
        }
      }
      return !this.$v.$invalid;
    },
    register: function () {
      if (this.validateForm()) {
        let data = {
          email: this.email,
          username: this.username,
          password: this.password,
        };
        this.$store
          .dispatch('register', data)
          .then(() => {
            this.registered = true;
            this.$toaster.success('Account successfully created, please login');
            this.updateRoute('login');
          })
          .catch((err) => {
            if (err.response.status === 409) {
              this.$toaster.error('Username is already taken');
            } else if (err.response.data === 'Invalid password') {
              this.$toaster.error(
                'Password is invalid, passwords require a captial, number and a special character.',
              );
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
.registerBox {
  background: url('../../assets/backdrop-register.png') no-repeat center;
  height: 800px;
  width: 800px;
  background-size: 580px 90%;
  margin-top: 1.5%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.registerInputBox {
  margin-top: 0;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  p {
    font-weight: bold;
    text-align: center;
    font-size: 30px;
    width: 400px;
  }
}
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s;
}
.fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}
</style>
