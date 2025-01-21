<template>
  <div class="tileWorldMap">
    <img height="30" :src="require('../../../assets/worldmap/' + grassname + '.png')" />
  </div>
</template>

<script>
/* eslint-disable no-console */

export default {
  props: ['grassname'],
};
</script>

<style lang="scss">
.tileWorldMap {
  img {
    width: 40px;
    height: 40px;
  }
}
</style>
