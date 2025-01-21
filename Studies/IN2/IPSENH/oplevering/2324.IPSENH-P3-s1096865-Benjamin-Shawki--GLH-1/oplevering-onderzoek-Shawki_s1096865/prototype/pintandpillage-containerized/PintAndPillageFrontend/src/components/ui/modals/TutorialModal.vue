<template>
  <div class="tutorialBaseModal" @click="close">
    <div class="tutorialModalBackdrop" @click.stop>
      <div class="tutorialTextDiv">
        <h1>Elwrick Pintbreaker</h1>
        <hr align="left" width="40%" />
        <h2 v-if="firstPage">
          Hi there my fellow Viking! My name is Elwrick Pintbreaker and I'm having a wee bit of a
          problem... You see, me and some of my Viking lads and lasses got banished from our clan,
          for say 'being too lazy, only drinking beer and wanting to pillage all the time"' So we
          have decided to start our own clan and take over the world! By drinking pints of beer and
          pillaging of course...
        </h2>
        <h2 v-else>
          So here is where you come in. We need someone to guide us to our well deserved GLORY! So
          what do you say my fellow Viking, lets Pint and Pillage! I will help you getting started
          by giving you some objectives to complete, you can see those by clicking on the ! in the
          right corner. Time to get our new village rolling!
        </h2>
      </div>
      <button class="baseButton" @click="nextPage" v-if="firstPage">Continue</button>
      <button class="baseButton" @click="openQuestsLog" v-else>Lets do this!</button>
    </div>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      firstPage: true,
    };
  },
  methods: {
    close: function () {
      this.$emit('close');
    },
    nextPage: function () {
      this.firstPage = false;
    },
    openQuestsLog: function () {
      this.$store.state.firstLogin = false;
      this.$store.state.questsOpened = true;
    },
  },
};
</script>

<style lang="scss">
.tutorialBaseModal {
  position: fixed;
  min-width: 100%;
  min-height: 100%;
  max-width: 100%;
  max-height: 100%;
  z-index: 500;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: rgba(0, 0, 0, 0.47);
  .tutorialModalBackdrop {
    background: url('../../../assets/ui-items/tutorial_modal.png') no-repeat;
    background-size: 850px 420px;
    height: 420px;
    width: 850px;
    margin-bottom: 140px;
    display: flex;
    flex-direction: column;
    z-index: 510;
    .tutorialTextDiv {
      max-width: 490px;
      text-align: center;
      margin-top: 112px;
      margin-left: 210px;
      h1,
      h2 {
        color: white;
        text-align: left;
      }
    }
    button {
      justify-self: flex-end;
      align-self: flex-end;
      margin-right: 140px;
      height: 49px;
      width: 140px;
      font-size: 16.8px;
    }
  }
}
</style>
