<template>
  <div>
    <div class="timeFrame">
      <img src="../../assets/ui-items/timer_icon.png" />
      <p>{{ requiredTime }}</p>
    </div>
  </div>
</template>

<script>
export default {
  props: ['requiredTime'],
};
</script>

<style lang="scss">
.timeFrame {
  display: flex;
  flex-direction: row;
  border: 5px solid transparent;
  background-color: rgb(104, 104, 104);
  border-image: url('../../assets/borders_modal.png') 40% stretch;
  min-width: 85px;
  height: 23px;
  justify-content: flex-start;
  align-items: center;
  margin-right: 5px;
  p {
    color: white;
    font-size: 11.9px !important;
  }
  img {
    width: 18px;
    height: 20px;
    margin-right: 5px;
    margin-left: 5px;
  }
}
</style>
