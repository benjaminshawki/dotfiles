<template>
  <div>
    <div class="patchNotesBody">
      <div class="patchNotes">
        <h1 class="patchNotesTitle">Patch Notes</h1>
        <div class="notesScrollContainer scrollerFirefox">
          <div v-for="(notes, key, index) in patchNotesData" :key="index" class="notesData">
            <h2>{{ key }}</h2>
            <p v-for="(note, index) in notes" :key="index">- {{ note }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
/* eslint-disable */
    import { required } from 'vuelidate/lib/validators'
    import Patchnotes from '../../assets/patch-notes/PatchNotes'

    export default {
        created() {
            this.$store.dispatch('logout');
        },
        data(){
            return {
                patchNotesData: Patchnotes.data,
            }
        },
        validations: {
            username: {
                required,
            },
            password: {
                required,
            }
        },
        methods: {}
    }
</script>

<style lang="scss">
    .patchNotesBody{
        display: flex;
        justify-content: center;
        align-items: center;
        .patchNotesTitle{
            margin-top: 210px;
            margin-bottom: 0px;
        }
        .notesScrollContainer{
            overflow-y: scroll;
            max-height: 270px;
            margin-top: 0px;
            margin-left: 0px;
            max-width: 360px;
        }
        .patchNotes{
            background-image: url("../../assets/patch_notes_backdrop.gif");
            background-size: 700px 600px;
            width: 700px;
            height: 600px;
            /*background-color: #7d898d;*/
            display: flex;
            align-items: center;
            flex-direction: column;
            color: black;
            .notesData{
                margin-left: 20px;
            }
        }
    }
</style>
