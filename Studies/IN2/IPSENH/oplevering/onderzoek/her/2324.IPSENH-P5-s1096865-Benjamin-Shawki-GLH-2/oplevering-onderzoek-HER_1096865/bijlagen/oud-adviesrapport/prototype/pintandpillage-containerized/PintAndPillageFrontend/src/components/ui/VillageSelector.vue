<template>
  <div>
    <div v-if="selectedVillage" style="position: relative; z-index: 2000">
      <div
        class="villageSelector"
        @click="isDroppedDown = !isDroppedDown"
        v-click-outside="closeDropdown"
      >
        <p>{{ selectedVillage.name }}</p>
      </div>
      <div class="dropdown" v-show="isDroppedDown">
        <div v-for="village in villageList" :key="village.key">
          <div @click="updateVillage(village.villageId)" class="dropdownItems">
            <div v-if="village.villageId !== selectedVillage.villageId">
              <p>{{ village.name }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
/* eslint-disable no-console */
export default {
  props: ['villageList'],
  data: function () {
    return {
      currentVillageId: '',
      isDroppedDown: false,
    };
  },
  computed: {
    selectedVillage: function () {
      if (this.villageList) {
        for (let i = 0; i < this.villageList.length; i++) {
          if (this.villageList[i].villageId === this.currentVillageId) {
            return this.villageList[i];
          }
        }
      }
      return null;
    },
  },
  created: function () {
    this.$store.dispatch('fetchVillageList').then(() => {
      let villageId = parseInt(localStorage.getItem('villageId'));
      let validVillageId = false;

      for (let i = 0; i < this.villageList.length; i++) {
        if (this.villageList[i].villageId === villageId) {
          validVillageId = true;
          break;
        }
      }

      if (!validVillageId) {
        villageId = this.villageList[0].villageId;
      }

      this.$store.dispatch('fetchVillage', villageId).then(() => {
        this.currentVillageId = villageId;
      });
    });
  },
  methods: {
    updateVillage: function (villageId) {
      if (this.$route.name === 'world') {
        this.$router.push('/');
      }
      this.$store
        .dispatch('fetchVillage', villageId)
        .then(() => {
          this.closeDropdown();
          this.currentVillageId = villageId;
          localStorage.setItem('villageId', villageId);
        })
        .catch((err) => console.log(err));
    },
    closeDropdown: function () {
      this.isDroppedDown = false;
    },
  },
};
</script>

<style lang="scss">
.villageSelector {
  width: 250px;
  background: url('../../assets/ui-items/village_dropdown.png') no-repeat right center;
  background-size: 250px 80%;
  text-align: center;
  color: white;
  margin-top: -25px;
  cursor: pointer;
  z-index: 5;
  position: relative;
  p {
    font-size: 18px;
    padding: 20px;
    margin-top: 0;
    user-select: none;
    margin-bottom: -10px;
  }
}
.dropdownItems {
  width: 220px;
  background-color: rgb(104, 104, 104);
  cursor: pointer;
  z-index: 2;

  p {
    font-size: 16px;
    padding: 5px;
    margin-top: 0;
    margin-bottom: 0;
    user-select: none;
    text-align: center;
    color: white;
    border: 1px solid rgb(61, 61, 61);
  }
  p:hover {
    background-color: rgb(144, 144, 144);
  }
}
.dropdown {
  margin-left: 10px;
  width: 220px;
  border: 6px solid transparent;
  border-image: url('../../assets/borders_modal.png') 40% stretch;
  max-height: 800px;
  overflow: auto;
}
</style>
