<template>
  <div>
    <div class="villageFrame" v-if="!pillageModalOpen && !scoutModalOpen">
      <p v-if="!checkForOwnVillage()">(Own village)</p>
      <h1>{{ properties.name }}</h1>
      <h3>Player: {{ properties.villageOwnerName }}</h3>
      <h3>Points: {{ properties.points }}</h3>
      <div class="combatButtons" v-if="checkForOwnVillage()">
        <button class="pillageButton" @click="pillageModalOpen = true">Pillage!</button>
        <!--                <button @click="scoutModalOpen = true">Send Scout</button>-->
      </div>
    </div>
    <combat-modal
      @close="close"
      v-if="pillageModalOpen"
      :villageId="properties.villageId"
    ></combat-modal>
    <scout-modal
      @close="close"
      v-if="scoutModalOpen"
      :villageId="properties.villageId"
    ></scout-modal>
  </div>
</template>

<script>
export default {
  props: ['properties'],
  data: function () {
    return {
      pillageModalOpen: false,
      scoutModalOpen: false,
    };
  },
  methods: {
    close: function () {
      this.$emit('close');
    },
    checkForOwnVillage: function () {
      const currentUserId = this.$store.getters.village.villageOwnerId;
      const selectedVillageUserId = this.properties.userId;
      if (currentUserId !== selectedVillageUserId) {
        return true;
      } else {
        return false;
      }
    },
  },
};
</script>

<style lang="scss">
.villageFrame {
  user-select: none;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  .combatButtons {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    margin-top: 80px;
    .pillageButton {
      background-color: #600000;
      border: 3px solid #7d0000;
    }
    button {
      color: white;
      background-color: #15636c;
      border-radius: 3.5px;
      height: 35px;
      font-size: 14px;
      width: 105px;
      border: 2.8px solid #0f3b43;
      min-width: 105px;
      margin: 14px;
    }
  }
}
</style>
