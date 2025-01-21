<template>
  <div class="outerModalBox" @click="close">
    <div class="innerModalBox" @click.stop="">
      <div class="backdropInnderModal">
        <div class="closeButtonContainer">
          <button class="loginButton" id="modalButton" @click="close">X</button>
        </div>
        <div class="compContainer">
          <component
            v-bind:is="modalType"
            :position="position"
            :allowedBuilding="allowedBuilding"
            :buildingId="buildingId"
            :properties="properties"
            @close="close"
          ></component>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'modal',
  props: [
    'componentName',
    'buildingName',
    'position',
    'buildingId',
    'allowedBuilding',
    'properties',
  ],
  modalType: '',
  methods: {
    close: function () {
      this.$emit('close');
    },
  },
  created: function () {
    switch (this.buildingName) {
      case 'BuildingTile':
        this.modalType = 'ConstructingModal';
        break;
      case 'Mine':
      case 'Farm':
      case 'Lumberyard':
      case 'Tavern':
        this.modalType = 'ResourcesModal';
        break;
      case 'House':
        this.modalType = 'PopulationModal';
        break;
      case 'Storage':
        this.modalType = 'StorageModal';
        break;
      case 'Market':
        this.modalType = 'MarketModal';
        break;
      case 'Barracks':
        this.modalType = 'BarracksModal';
        break;
      case 'DefenceTower':
      case 'Wall':
        this.modalType = 'DefenceTowerModal';
        break;
      case 'Headquarters':
        this.modalType = 'HeadquartersModal';
        break;
      case 'Village':
        this.modalType = 'VillageModal';
        break;
      case 'Harbor':
        this.modalType = 'HarborModal';
        break;
      case 'Smith':
        this.modalType = 'SmithModal';
        break;
      case 'Logs':
        this.modalType = 'LogsModal';
        break;
      case 'Settle':
        this.modalType = 'SettleModal';
        break;
      case 'Quest':
        this.modalType = 'QuestModal';
        break;
      case 'Combat':
        this.modalType = 'CombatLogsModal';
        break;
      default:
        this.modalType = 'ResourcesModal';
        break;
    }
  },
};
</script>

<style lang="scss">
.outerModalBox {
  position: fixed;
  min-width: 100%;
  min-height: 100%;
  max-width: 100%;
  max-height: 100%;
  z-index: 500;
  display: flex;
  justify-content: center;
  align-items: center;
  user-select: none;
}

.innerModalBox {
  box-shadow: 10px 10px 5px 0px rgba(26, 26, 26, 0.5);
  background: url('../../../assets/ui-items/backdrop_modal.png') no-repeat;
  color: white;
  border: 12px solid transparent;
  border-image: url('../../../assets/borders_modal.png') 40% stretch;
  background-size: 100% 100%;
  min-width: 590px;
  min-height: 350px;

  .backdropInnderModal {
    background-color: rgba(0, 0, 0, 0.35);
    min-height: 350px;
    width: 100%;
    padding-bottom: 20px;

    .compContainer {
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
    }

    .closeButtonContainer {
      display: flex;
      justify-content: flex-end;
      align-items: flex-end;
      margin-top: 0px;
      margin-right: -2px;
      height: 49px;

      #modalButton {
        margin-bottom: 2%;
        width: 35px;
        border-radius: 3px;
        color: white;
        height: 35px;
        font-size: 14px;
        background-color: #600000;
        border: 2px solid #a80000;
        z-index: 100;
      }
    }
  }
}
</style>
