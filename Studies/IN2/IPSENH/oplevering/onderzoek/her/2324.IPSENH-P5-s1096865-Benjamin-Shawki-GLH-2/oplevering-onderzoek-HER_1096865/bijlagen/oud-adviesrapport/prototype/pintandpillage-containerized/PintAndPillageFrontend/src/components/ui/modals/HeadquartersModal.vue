<template>
  <div class="headquartersFrame">
    <div class="headquartersContainer">
      <div class="headquartersTitleContainer">
        <img src="../../../assets/ui-items/headquarters_icon.png" width="98px" height="84px" />
        <div
          style="
            display: flex;
            flex-direction: column;
            justify-content: left;
            align-items: flex-start;
          "
        >
          <h1>{{ building.name }} - Lv {{ building.level }}</h1>
          <h2>Morale: {{ villageMorale }}</h2>
          <h3>Replenishes {{ building.moralePerHour }} morale back per hour</h3>
        </div>
      </div>
    </div>

    <div class="headquartersContainer headquartersEditVillageNameContainer">
      <h2>Change the name of your village</h2>
      <div class="headquartersEditVillageNameInputContainer">
        <input
          class="inputField"
          type="text"
          v-model.trim="newVillageName"
          placeholder="New Village Name"
        />
        <button @click="updateVillageName">Update</button>
      </div>
    </div>
    <level-up-building
      @close="close"
      @buildingFetched="building = $event"
      :buildingId="buildingId"
    ></level-up-building>
  </div>
</template>

<script>
/* eslint-disable */
    import { required, minLength, maxLength} from 'vuelidate/lib/validators'
    export default {
        props: ['buildingId'],
        data: function () {
            return{
                newVillageName: '',
            }
        },
        computed: {
            building: function(){
                return this.$store.getters.building(this.buildingId);
            },
            villageMorale: function () {
                return this.$store.getters.village.morale;
            }
        },
        validations: {
            newVillageName: {
                required,
                minLength: minLength(1),
                maxLength: maxLength(30),
            }
        },
        methods:{
            close: function() {
                this.$emit('close');
            },
            updateVillageName: function() {
                if (this.validateForm()) {
                    let newVillageData = {
                        newName: this.newVillageName,
                    };
                    let villageId = this.$store.getters.village.villageId;
                    this.$store.dispatch('updateVillageName', {'newVillageData': newVillageData, 'villageId': villageId})
                        .then(() => {
                            this.$toaster.success('Village name has been updated successfully');
                            this.updateVillageList();
                        })
                        .catch(err => {
                            this.$toaster.error('Something went wrong');
                            console.log(err)
                        })
                }
            },
            validateForm: function() {
                let validations = [
                    [this.$v.newVillageName.required, 'Village name is required'],
                    [this.$v.newVillageName.minLength, `Village name must have at least ${this.$v.newVillageName.$params.minLength.min} characters`],
                    [this.$v.newVillageName.maxLength, `Village name must have no more than ${this.$v.newVillageName.$params.maxLength.max} characters`],
                ];
                for (let i = 0; i < validations.length; i++) {
                    if (!validations[i][0]) {
                        this.$toaster.error(validations[i][1]);
                    }
                }
                return !this.$v.$invalid;
            },
            updateVillageList: function () {
                this.$store.dispatch('fetchVillageList').then(()=>{
                    console.log('fetched')
                }).catch(e =>{
                    console.log(e)
                })
            }
        }
    }
</script>

<style lang="scss">
    .headquartersFrame {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        .headquartersContainer {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 56px;
            flex-direction: column;
            min-width: 385px;
            min-height: 105px;
            border: 12px solid transparent;
            border-image: url("../../../assets/borders_modal.png") 40% stretch;
            background-color: #434343;
            h2, h3{
                margin-top: 0px;
            }
            .headquartersTitleContainer {
                display: flex;
                flex-direction: row;
                justify-content: center;
                align-items: center;
                padding-top: 10px;
                h1, h2, h3 {
                    margin-left: 28px;
                    margin-top: 0;
                    margin-bottom: 0;
                }
                h3{
                    color: #50b524;
                }
            }
        }
        .headquartersEditVillageNameContainer {
            flex-direction: column;
            .headquartersEditVillageNameInputContainer{
                display: flex;
                justify-content: center;
                align-items: center;
                flex-direction: row;
                input {
                    margin: 0 28px 0 35px;
                }
                button {
                    color: white;
                    background-color: #15636c;
                    border-radius: 3.5px;
                    height: 35px;
                    font-size: 14px;
                    width: 105px;
                    border: 2.5px solid #0f3b43;
                    min-width: 105px;
                    margin-right: 35px;
                }
            }
        }
    }
</style>
