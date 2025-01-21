<template>
  <div>
    <h3>{{ time }}</h3>
  </div>
</template>

<script>
import { clearInterval } from 'timers';

export default {
  props: ['time'],
  data: function () {
    return {
      currentTime: null,
      interval: null,
    };
  },
  created: function () {
    this.currentTime = this.time;
    this.addSecond(3);
  },
  mounted: function () {
    // this.interval = setInterval(this.timer_loop, 1000)
  },
  methods: {
    close: function () {
      this.$destroy();
    },
    timer_loop: function () {
      if (this.currentTime !== '00:00:01') {
        this.addSecond(-1);
      } else {
        this.addSecond(-1);
        clearInterval(this.interval);
        this.updateVillage();
        this.close();
      }
    },
    addSecond: function (secs) {
      let seconds = this.convertTimeToSeconds(this.currentTime);
      seconds += secs;
      this.convertSecondsToTime(seconds);
    },
    convertTimeToSeconds: function () {
      const splittedTime = this.currentTime.split(':');
      const secondsConverted =
        +splittedTime[0] * 60 * 60 + +splittedTime[1] * 60 + +splittedTime[2];
      return secondsConverted;
    },
    convertSecondsToTime: function (seconds) {
      const date = new Date(null);
      date.setSeconds(seconds);
      const timeString = date.toISOString().substr(11, 8);
      this.currentTime = timeString;
    },
    updateVillage: function () {
      const villageId = this.$store.getters.village.villageId;
      this.$store.dispatch('fetchVillage', villageId);
    },
  },
};
</script>

<style lang="scss"></style>
