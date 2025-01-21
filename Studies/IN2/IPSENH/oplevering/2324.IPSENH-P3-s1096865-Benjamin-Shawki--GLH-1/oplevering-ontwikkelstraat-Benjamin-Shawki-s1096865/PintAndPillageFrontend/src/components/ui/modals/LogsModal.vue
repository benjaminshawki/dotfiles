<template>
  <div class="outerModalBox" @click="close">
    <div class="innerModalBox" @click.stop="">
      <div class="backdropInnderModal">
        <div class="closeButtonContainer">
          <button class="loginButton" id="modalButton" @click="close">X</button>
        </div>
        <div class="compContainer">
          <div class="logsContainer">
            <div class="tabContainer">
              <tab-navigation
                :tab-list="tabList"
                :properties="{ villageData: villageData }"
              ></tab-navigation>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      tabList: [
        { name: 'Village Log', componentName: 'VillageLogs' },
        { name: 'Combat Log', componentName: 'CombatLogs' },
        { name: 'Unit Movement', componentName: 'UnitMovementLogs' },
      ],
    };
  },
  computed: {
    villageData: function () {
      return this.$store.getters.village;
    },
  },
  methods: {
    close: function () {
      this.$emit('close');
    },
  },
};
</script>

<style lang="scss">
.logsInfo {
  font-size: 16.8px;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  h1 {
    margin-top: 0px;
    margin-bottom: 14px;
  }
}
.tabContainer {
  margin-left: 70px;
  margin-right: 70px;
  margin-bottom: 70px;
}

.logsContainer {
  margin-left: 28px;
  margin-right: 28px;
}
.logList {
  li:nth-child(odd) {
    background-color: #696969;
  }
  list-style: none;
  height: 385px;
  width: 700px;
  overflow-y: auto;
  overflow-x: hidden;
  border: 10.5px solid transparent;
  border-image: url('../../../assets/borders_modal.png') 40% stretch;
  padding: 0;
  li {
    p {
      font-size: 22px;
      padding: 15px;
      margin: 2px;
    }
  }
}
.logErrors {
  font-size: 15.4px;
  text-align: center;
}
</style>
