<template>
  <a class="highscore-item-container">
    <p class="highscore-item-element">
      {{ index }}
    </p>
    <p class="highscore-item-element">
      {{ data.username }}
    </p>
    <p class="highscore-item-element">
      {{ data.totalPoints }}
    </p>
  </a>
</template>

<script>
/* eslint-disable */
    export default {
        props: {
            data: Object,
            index: Number,
        },
    }
</script>

<style lang="scss">
    .highscore-item-container{
        display: flex;
        flex-direction: row;
        border: 7px solid transparent;
        border-image: url("../../assets/borders_modal.png") 40% stretch;

        .highscore-item-element{
            margin: 17px 13px 17px 14px;
            min-width: 80px;
            color: white;
        }
        p{
            font-size: 12px;
            user-select: none;
        }
    }
</style>
