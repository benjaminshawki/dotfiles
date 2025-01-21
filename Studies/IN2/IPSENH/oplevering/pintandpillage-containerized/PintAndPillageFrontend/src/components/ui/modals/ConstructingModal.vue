<template>
  <div class="constructionModal scrollerFirefox">
    <h1>Building List</h1>
    <hr style="width: 80%; margin-bottom: 10px" />
    <div class="buildingList">
      <div v-for="building in villageBuildings" :key="building.key">
        <building-list-item
          :building="building"
          :position="position"
          @close="close"
        ></building-list-item>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['position', 'allowedBuilding'],
  data: function () {
    return {
      inputValue: '',
      villageBuildings: [],
    };
  },
  computed: {
    allBuildingsThatCanBeBuild: function () {
      return this.$store.getters.village.buildingsThatCanBeBuild;
    },
  },
  created: function () {
    this.fillBuildingsThatCanBeBuildList();
  },
  methods: {
    close: function () {
      this.$emit('close');
    },
    fillBuildingsThatCanBeBuildList: function () {
      this.villageBuildings = [];
      if (this.allowedBuilding) {
        this.filterBuildingList(this.allowedBuilding);
      } else {
        for (let i = 0; i < this.allBuildingsThatCanBeBuild.length; i++) {
          if (
            this.allBuildingsThatCanBeBuild[i].name !== 'Harbor' &&
            this.allBuildingsThatCanBeBuild[i].name !== 'Wall'
          ) {
            this.villageBuildings.push(this.allBuildingsThatCanBeBuild[i]);
          }
        }
      }
    },
    filterBuildingList: function (buildingName) {
      for (let i = 0; i < this.allBuildingsThatCanBeBuild.length; i++) {
        if (this.allBuildingsThatCanBeBuild[i].name === buildingName) {
          this.villageBuildings.push(this.allBuildingsThatCanBeBuild[i]);
        }
      }
    },
  },
};
</script>

<style>
.constructionModal {
  background-color: rgb(68, 68, 68);
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 80%;
  margin-top: 14px;
}
.buildingList {
  max-height: 455px;
  overflow: auto;
  margin-right: 35px;
  margin-left: 35px;
  height: 100%;
}
</style>
