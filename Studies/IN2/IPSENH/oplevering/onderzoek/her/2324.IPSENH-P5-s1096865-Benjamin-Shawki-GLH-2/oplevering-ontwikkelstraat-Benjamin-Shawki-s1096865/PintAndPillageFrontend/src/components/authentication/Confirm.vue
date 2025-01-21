<template>
  <div class="login" @keydown.enter="login">
    <div class="loginBoxConfirm">
      <div class="loginInputBoxConfirm">
        <p>Click on the button below to confirm your email</p>
        <button class="submitButton" @click="login">Confirm email</button>
      </div>
    </div>
  </div>
</template>

<script>
/* eslint-disable */

export default {
  methods: {
    login: function() {
    let data = {
        userId: this.$route.query.userId,
        token: this.$route.query.token,
    };
      this.$store
        .dispatch("confirm", data)
        .then(() => this.$router.push("/"))
    },
    updateRoute: function(to) {
      this.$emit("updateRoute", to);
    }
  }
};
</script>

<style>
.loginBoxConfirm {
  background: url("../../assets/backdrop-login.png") no-repeat center;
  height: 600px;
  margin-top: 2%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.loginInputBoxConfirm {
  margin-top: 100px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
</style>
