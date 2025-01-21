<template>
  <div class="settingsBaseModal" @click="close" v-if="!highscoreOpened">
    <div class="settingsModalBackdrop" @click.stop>
      <div class="settingsButtonsList">
        <button class="baseButton" @click="highscoreOpened = true">Highscores</button>
        <button class="baseButton" @click="changeSeason()">Seasons: {{ isSeasonsOn }}</button>
        <button class="baseButton" @click="logOut">Logout</button>
        <button class="baseButton" id="settingsCloseButton" @click="close">Close</button>
      </div>
    </div>
  </div>
  <div v-else>
    <high-score-modal @closeHighscores="highscoreOpened = false"></high-score-modal>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      highscoreOpened: false,
      isSeasonsOn: this.getIsSeasonOn(),
    };
  },
  methods: {
    close: function () {
      this.$emit('close');
    },
    logOut: function () {
      this.$store
        .dispatch('logout')
        .then(() => {
          this.$router.push('/login');
          this.$toaster.success('Logged out successfully');
        })
        .catch((e) => {
          this.$toaster.error(e);
        });
    },
    changeSeason: function () {
      if (this.$store.state.seasonsEnabled) {
        this.$store.commit('seasons_enabled', false);
        localStorage.setItem('seasons_enabled', false);
        this.isSeasonsOn = 'off';
      } else {
        this.$store.commit('seasons_enabled', true);
        localStorage.setItem('seasons_enabled', true);
        this.isSeasonsOn = 'on';
      }
    },
    getIsSeasonOn: function () {
      return this.$store.state.seasonsEnabled ? 'on' : 'off';
    },
  },
};
</script>

<style lang="scss">
.settingsBaseModal {
  position: fixed;
  min-width: 100%;
  min-height: 100%;
  max-width: 100%;
  max-height: 100%;
  z-index: 500;
  display: flex;
  justify-content: center;
  align-items: center;
  .settingsModalBackdrop {
    background: url('../../../assets/settings_backdrop.png') no-repeat;
    background-size: 588px 478px;
    height: 478px;
    width: 588px;
    margin-bottom: 140px;
    .settingsButtonsList {
      display: flex;
      justify-content: center;
      flex-direction: column;
      align-items: center;
      margin-top: 160px;
      button {
        margin-top: 20px;
        margin-right: 0px;
        font-size: 17px;
        height: 42px;
        width: 126px;
      }
      #settingsCloseButton {
        margin-top: 20px;
      }
    }
  }
}
</style>
