<template>
  <div>
    <div class="homePageBody">
      <div class="homePage">
        <h1 class="homePageTitle">Welcome Viking!</h1>
        <div class="homepageContent">
          <div class="sliderHomePageDiv">
            <slider
              animation="fade"
              v-model="sliderValue"
              :interval="5000"
              :speed="1000"
              class="sliderHomePage"
            >
              <sliderItem v-for="(i, index) in list" :key="index" @click="changeIndex(1)">
                <img :src="i.imgUrl" width="420px" height="280px" />
              </sliderItem>
            </slider>
          </div>
          <div class="homePageText">
            <p>
              Welcome to Pint and Pillage, a real time strategy and massive multiplayer online game
              set in the time of the Vikings. <br /><br />

              Create your own village, upgrade your buildings and create massive armies to pillage
              all others.
              <br /><br />
              Register now to Pint and Pillage!
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { Slider, SliderItem } from 'vue-easy-slider';

/* eslint-disable */
    export default {
        created() {
            this.$store.dispatch('logout');
        },
        components: {
            Slider,
            SliderItem,
        },
        data(){
            return {
                list: [
                    { imgUrl: require('../../assets/slider-images/slider_01.png') },
                    { imgUrl: require('../../assets/slider-images/slider_02.png') },
                    { imgUrl: require('../../assets/slider-images/slider_03.png') },
                    { imgUrl: require('../../assets/slider-images/slider_04.png') },
                ],
                sliderValue: 2
            }
        },
        methods: {
        }
    }
</script>

<style lang="scss">
    .homePageBody{
        display: flex;
        justify-content: center;
        align-items: center;
        user-select: none;
        .homePageTitle{
            margin-top: 430px;
            margin-bottom: 0px;
            font-size: 30px;
            color: white;
        }
        .homePage{
            background-image: url("../../assets/home_page.gif");
            background-size: 1300px 1100px;
            width: 1300px;
            height: 1100px;
            margin-top: -210px;
            z-index: 0;
            /*background-color: #7d898d;*/
            display: flex;
            align-items: center;
            flex-direction: column;
            color: black;
        }
        .homepageContent{
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-items: flex-start;
            width: 100%;
            .sliderHomePageDiv{
                width: 420px;
                height: 280px;
                margin-top: 60px;
                margin-left: 220px;
                margin-right: 100px;
                .sliderHomePage{
                    height: 280px !important;
                    width: 420px !important;
                    border: 10px solid transparent;
                    border-image: url("../../assets/borders_modal.png") 40% stretch;
                }
            }
            .homePageText{
                margin-top: 20px;
                background-color: #4a5052;
                color: white;
                border: 10px solid transparent;
                border-image: url("../../assets/borders_modal.png") 40% stretch;
                height: 360px;
                width: 300px;
                p{
                    margin: 20px;
                    font-size: 18px;
                    user-select: none;
                }
            }
        }
    }
</style>
