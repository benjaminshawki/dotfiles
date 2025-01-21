<template>
  <div class="timerOverlay">
    <h1>00:15</h1>
  </div>
</template>

<script></script>

<style lang="scss">
.timerOverlay {
  position: absolute;

  transform: rotateX(0deg) rotateY(0deg) rotateZ(-44deg);
  top: -150px;
  left: -170px;
  z-index: 2000;
  min-width: 200px;
  text-align: center;
  height: 100px;
  margin: 0;
  /*border: 20px solid transparent;*/
  /*border-image: url("../../assets/borders_modal.png") 40% stretch;*/
  color: white;
  font-size: 15px;
  margin: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  /*background-color: white;*/
  background-image: url('../../assets/ui-items/village_dropdown.png');
  background-size: 200px 100px;
  h1 {
    margin: 0px;
  }
}
</style>
