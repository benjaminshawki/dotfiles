<template>
  <div class="highscoreModal scrollerFirefox" @click="closeHighscore">
    <div class="highscores" @click.stop>
      <ul class="highscore-list" v-if="highscoreData">
        <h1>Highscores</h1>
        <hr width="80%" />
        <div class="highscoreColumnNames">
          <p>Place</p>
          <p>Player</p>
          <p>Points</p>
        </div>
        <li v-for="(element, index) in this.highscoreData" :key="index">
          <Item :data="element" :index="index + 1"></Item>
        </li>
      </ul>
      <h2 v-if="!highscoreData" class="loadingMessage">Loading highscores...</h2>
      <button class="baseButton" @click="closeHighscore">Back</button>
    </div>
  </div>
</template>

<script>
/* eslint-disable */
    import Item from "../../highscore/Item";
    export default {
        name: "Highscores",
        components: {Item},
        data() {
            return{
                highscoreData: null,
            }
        },
        created() {
            this.fetchHighscore();
        },
        methods: {
            fetchHighscore: function() {
                this.$store.dispatch('fetchHighscore')
                    .then(highscoreData => {
                        this.highscoreData =  highscoreData.data.sort((a, b) => (a.totalPoints < b.totalPoints) ? 1 : -1);
                    })
                    .catch(err => {
                            this.$toaster.error('Something went wrong');
                        }
                    );
            },
            closeHighscore: function () {
                this.$emit('closeHighscores');
            }
        },
    }
</script>


<style lang="scss">
    .highscoreModal{
        position: fixed;
        min-width: 100%;
        min-height: 100%;
        max-width: 100%;
        max-height: 100%;
        z-index: 500;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        .highscores{
            background: url("../../../assets/highscore_backdrop.png") no-repeat center;
            background-size: 600px 700px;
            height: 700px;
            width: 600px;
            margin-top: 1.4%;
            display: flex;
            flex-direction: column;
            align-items: center;
            .loadingMessage{
                margin-top: 210px;
                color: white;
            }
            ul{
                padding: 0;
            }
            button{
                margin: 0;
            }
            h1{
                text-align: center;
                color: white;
            }
            .highscore-list{
                list-style: none;
                margin-top: 175px;
                height: 315px;
                overflow-y: auto;
                overflow-x: hidden;
                .highscoreColumnNames{
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    flex-direction: row;
                    color: white;
                    p{
                        font-size: 12px;
                        margin: 25px 20px 10px 20px;
                        min-width: 70px;
                    }
                }
            }
        }
    }
</style>
