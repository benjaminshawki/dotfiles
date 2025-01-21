import Vue from 'vue';
import App from './App.vue';
import 'v-toaster/dist/v-toaster.css';
import axios from 'axios';
import BackgroundTile from './components/tiles/BackgroundTile';
import Barracks from './components/tiles/Barracks';
import BarracksModal from './components/ui/modals/BarracksModal';
import BaseTile from './components/tiles/BaseTile';
import BuildingListItem from './components/ui/BuildingListItem';
import BuildingTile from './components/tiles/BuildingTile';
import CombatLogs from './components/ui/logs/CombatLogs';
import CombatModal from './components/ui/modals/CombatModal';
import ConstructingModal from './components/ui/modals/ConstructingModal';
import ConstructionTile from './components/tiles/ConstructionTile';
import DefenceTower from './components/tiles/DefenceTower';
import DefenceTowerModal from './components/ui/modals/DefenceTowerModal';
import Farm from './components/tiles/Farm';
import GameHeader from './components/ui/GameHeader';
import GameHeaderMobile from './components/ui/GameHeaderMobile';
import Harbor from './components/tiles/Harbor';
import HarborModal from './components/ui/modals/HarborModal';
import Headquarters from './components/tiles/Headquarters';
import HeadquartersModal from './components/ui/modals/HeadquartersModal';
import House from './components/tiles/House';
import LandTileWorldMap from './components/tiles/worldmap/LandTileWorldMap';
import LevelUpBuilding from './components/ui/LevelUpBuilding';
import LogsModal from './components/ui/modals/LogsModal';
import Lumberyard from './components/tiles/Lumberyard';
import MakeMarketOffer from './components/ui/market/MakeMarketOffer';
import VillageTrades from './components/ui/market/VillageTrades';
import Market from './components/tiles/Market';
import MarketModal from './components/ui/modals/MarketModal';
import MarketTrades from './components/ui/market/OpenMarketOffers';
import MarketTravels from './components/ui/market/MarketTravels';
import Mine from './components/tiles/Mine';
import Modal from './components/ui/modals/BaseModal';
import OpenMarketOffers from './components/ui/market/MarketTrades';
import PopulationFrame from './components/ui/PopulationFrame';
import PopulationModal from './components/ui/modals/PopulationModal';
import ResearchBox from './components/ui/ResearchBox';
import ResourceItem from './components/ui/ResourceItem';
import Resources from './components/ui/Resources';
import ResourcesModal from './components/ui/modals/ResourcesModal';
import router from './router';
import ScoutModal from './components/ui/modals/ScoutModal';
import SeaTileWorldMap from './components/tiles/worldmap/SeaTileWorldMap';
import Smith from './components/tiles/Smith';
import SmithModal from './components/ui/modals/SmithModal';
import Storage from './components/tiles/Storage';
import StorageModal from './components/ui/modals/StorageModal';
import store from './store/index';
import TabNavigation from './components/ui/TabNavigation';
import Tavern from './components/tiles/Tavern';
import TimerOverlay from './components/tiles/TimerOverlay';
import Toaster from 'v-toaster';
import Unit from './components/ui/barracks/Unit';
import UnitList from './components/ui/barracks/UnitList';
import UnitsInProgress from './components/ui/barracks/UnitsInProgress';
import UnitMovementLogs from './components/ui/logs/UnitMovementLogs';
import VillageGridComponent from './components/VillageGrid';
import VillageLogs from './components/ui/logs/VillageLogs';
import VillageModal from './components/ui/modals/VillageModal';
import VillageSelector from './components/ui/VillageSelector';
import VillageTileWorldMap from './components/tiles/worldmap/VillageTileWorldMap';
import OwnedVillageTileWorldMap from './components/tiles/worldmap/OwnedVillageTileWorldMap';
import SelectedVillageTileWorldMap from './components/tiles/worldmap/SelectedVillageTileWorldMap';
import VTooltip from 'v-tooltip';
import VueDragscroll from 'vue-dragscroll';
import Vuelidate from 'vuelidate';
import WaterCornerTile from './components/tiles/WaterCornerTile';
import WaterTile from './components/tiles/WaterTile';
import World from './views/World';
import SettingsModal from './components/ui/modals/SettingsModal';
import HighScoreModal from './components/ui/modals/HighscoreModal';
import TutorialModal from './components/ui/modals/TutorialModal';
import Wall from './components/tiles/Wall';
import WallRight from './components/tiles/WallRight';
import WallLeft from './components/tiles/WallLeft';
import WallRightEnd from './components/tiles/WallRightEnd';
import WallLeftEnd from './components/tiles/WallLeftEnd';
import NatureForest_1 from './components/tiles/NatureForest_1';
import NatureForest_2 from './components/tiles/NatureForest_2';
import SettleModal from './components/ui/modals/SettleModal';
import QuestModal from './components/ui/modals/QuestModal';
import TimeFrame from './components/ui/TimeFrame';
import BuildingTimeModal from './components/ui/modals/BuildingTimeModal';
import Timer from './components/ui/Timer';
import EasySlider from 'vue-easy-slider';
import UnitsInVillageModal from './components/ui/modals/UnitsInVillageModal';
import IncomingAttacksModal from './components/ui/modals/IncomingAttacksModal';
import OverlayModals from './components/ui/modals/OverlayModals';
import CombatLogsModal from './components/ui/modals/CombatLogsModal';
import ServerDown from './components/ServerDown';
import CombatLogEntry from './components/ui/combatlogs/CombatLogEntry';
import CombatLog from './components/ui/combatlogs/CombatLog';
import UnitBlock from './components/ui/combatlogs/UnitBlock';
import ScoutLog from './components/ui/combatlogs/ScoutLog';
import ZoomModal from './components/ui/modals/ZoomModal';
import WorldMapSettingsModal from './components/ui/modals/WorldMapSettingsModal';
import SettleTileWorldMap from './components/tiles/worldmap/SettleTileWorldMap';
import VuejsDialog from 'vuejs-dialog';
// import VuejsDialogMixin from 'vuejs-dialog/dist/vuejs-dialog-mixin.min.js'; // only needed in custom components
// include the default style
import 'vuejs-dialog/dist/vuejs-dialog.min.css';

Vue.use(VuejsDialog);
Vue.config.productionTip = false;
Vue.use(VueDragscroll);
Vue.component('BackgroundTile', BackgroundTile);
Vue.component('Barracks', Barracks);
Vue.component('BarracksModal', BarracksModal);
Vue.component('BaseTile', BaseTile);
Vue.component('BuildingListItem', BuildingListItem);
Vue.component('BuildingTile', BuildingTile);
Vue.component('CombatLogs', CombatLogs);
Vue.component('CombatModal', CombatModal);
Vue.component('CombatModal', CombatModal);
Vue.component('ConstructingModal', ConstructingModal);
Vue.component('ConstructionTile', ConstructionTile);
Vue.component('ConstructionTile', ConstructionTile);
Vue.component('DefenceTower', DefenceTower);
Vue.component('DefenceTowerModal', DefenceTowerModal);
Vue.component('Farm', Farm);
Vue.component('GameHeader', GameHeader);
Vue.component('GameHeaderMobile', GameHeaderMobile);
Vue.component('Harbor', Harbor);
Vue.component('Harbor', Harbor);
Vue.component('HarborModal', HarborModal);
Vue.component('Headquarters', Headquarters);
Vue.component('HeadquartersModal', HeadquartersModal);
Vue.component('House', House);
Vue.component('LandTileWorldMap', LandTileWorldMap);
Vue.component('LandTileWorldMap', LandTileWorldMap);
Vue.component('LevelUpBuilding', LevelUpBuilding);
Vue.component('LogsModal', LogsModal);
Vue.component('Lumberyard', Lumberyard);
Vue.component('MakeMarketOffer', MakeMarketOffer);
Vue.component('Market', Market);
Vue.component('MarketModal', MarketModal);
Vue.component('MarketTrades', MarketTrades);
Vue.component('MarketTravels', MarketTravels);
Vue.component('Mine', Mine);
Vue.component('Modal', Modal);
Vue.component('OpenMarketOffers', OpenMarketOffers);
Vue.component('PopulationFrame', PopulationFrame);
Vue.component('PopulationFrame', PopulationFrame);
Vue.component('PopulationModal', PopulationModal);
Vue.component('ResearchBox', ResearchBox);
Vue.component('ResearchBox', ResearchBox);
Vue.component('ResourceItem', ResourceItem);
Vue.component('Resources', Resources);
Vue.component('ResourcesModal', ResourcesModal);
Vue.component('ScoutModal', ScoutModal);
Vue.component('SeaTileWorldMap', SeaTileWorldMap);
Vue.component('SettingsModal', SettingsModal);
Vue.component('HighScoreModal', HighScoreModal);
Vue.component('Smith', Smith);
Vue.component('SmithModal', SmithModal);
Vue.component('Storage', Storage);
Vue.component('StorageModal', StorageModal);
Vue.component('TabNavigation', TabNavigation);
Vue.component('Tavern', Tavern);
Vue.component('TimerOverlay', TimerOverlay);
Vue.component('Unit', Unit);
Vue.component('UnitList', UnitList);
Vue.component('UnitsInProgress', UnitsInProgress);
Vue.component('UnitMovementLogs', UnitMovementLogs);
Vue.component('villagegrid-component', VillageGridComponent);
Vue.component('VillageLogs', VillageLogs);
Vue.component('VillageModal', VillageModal);
Vue.component('VillageModal', VillageModal);
Vue.component('VillageSelector', VillageSelector);
Vue.component('VillageTileWorldMap', VillageTileWorldMap);
Vue.component('OwnedVillageTileWorldMap', OwnedVillageTileWorldMap);
Vue.component('SelectedVillageTileWorldMap', SelectedVillageTileWorldMap);
Vue.component('VillageTrades', VillageTrades);
Vue.component('WaterCornerTile', WaterCornerTile);
Vue.component('WaterTile', WaterTile);
Vue.component('WaterTile', WaterTile);
Vue.component('World', World);
Vue.component('Wall', Wall);
Vue.component('WallRight', WallRight);
Vue.component('WallRightEnd', WallRightEnd);
Vue.component('WallLeft', WallLeft);
Vue.component('WallLeftEnd', WallLeftEnd);
Vue.component('NatureForest_1', NatureForest_1);
Vue.component('NatureForest_2', NatureForest_2);
Vue.component('SettleModal', SettleModal);
Vue.component('TimeFrame', TimeFrame);
Vue.component('QuestModal', QuestModal);
Vue.component('TutorialModal', TutorialModal);
Vue.component('BuildingTimeModal', BuildingTimeModal);
Vue.component('Timer', Timer);
Vue.component('OverlayModals', OverlayModals);
Vue.component('UnitsInVillageModal', UnitsInVillageModal);
Vue.component('CombatLogsModal', CombatLogsModal);
Vue.component('ServerDown', ServerDown);
Vue.component('CombatLogEntry', CombatLogEntry);
Vue.component('CombatLog', CombatLog);
Vue.component('UnitBlock', UnitBlock);
Vue.component('ScoutLog', ScoutLog);
Vue.component('IncomingAttacksModal', IncomingAttacksModal);
Vue.component('ZoomModal', ZoomModal);
Vue.component('SettleTileWorldMap', SettleTileWorldMap);
Vue.component('WorldMapSettingsModal', WorldMapSettingsModal);

axios.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token');
    if (token) {
      config.headers.Authorization = 'Bearer ' + token;
    }
    return config;
  },

  (error) => {
    return Promise.reject(error);
  },
);
axios.interceptors.response.use(
  function (response) {
    return response;
  },
  function (error) {
    if (error.response.status === 401) {
      store.dispatch('logout');
      router.push('/login');
    } else if (error.response.status === 500) {
      router.push('/woeps');
    }
    return Promise.reject(error);
  },
);
/* eslint-disable */
Vue.directive('click-outside', {
  bind: function (el, binding, vnode) {
    window.event = function (event) {
      if (!(el === event.target || el.contains(event.target))) {
        vnode.context[binding.expression](event);
      }
    };
    document.body.addEventListener('click', window.event);
  },
  unbind: function (el) {
    document.body.removeEventListener('click', window.event);
  },
});
Vue.mixin({
  methods: {
    validateNumberInput: function (maxInputValue, inputEvent) {
      let inputAsciiValue = inputEvent.keyCode;
      let inputValue = parseInt(inputEvent.target.value);
      this.checkNegativeValue(inputValue, inputEvent);
      this.checkOverMaxValue(inputValue, inputEvent, maxInputValue);
      this.checkAsciiValue(inputAsciiValue, inputEvent);
    },
    checkNegativeValue: function (inputValue, inputEvent) {
      if (inputValue < 1) {
        inputEvent.preventDefault();
      }
    },
    checkOverMaxValue: function (inputValue, inputEvent, maxInputValue) {
      if (inputValue + inputEvent.key > maxInputValue) {
        inputEvent.preventDefault();
      }
    },
    checkAsciiValue: function (inputAsciiValue, inputEvent) {
      if (inputAsciiValue < 48 || inputAsciiValue > 57) {
        inputEvent.preventDefault();
      }
    },
  },
});

Vue.use(Toaster, { timeout: 5000 });
Vue.use(Toaster, { limit: 4 });
Vue.use(Vuelidate);
Vue.use(VTooltip);
Vue.use(EasySlider);
Vue.use(require('vue-moment'));

Vue.config.performance = true;

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount('#app');
