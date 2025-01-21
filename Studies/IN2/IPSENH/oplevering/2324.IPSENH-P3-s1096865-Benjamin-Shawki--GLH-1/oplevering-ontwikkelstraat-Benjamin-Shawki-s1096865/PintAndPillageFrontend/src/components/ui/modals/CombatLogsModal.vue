<template>
  <div class="combatLogsModal">
    <div class="combatLogBody">
      <h1>Combat Log</h1>
      <hr width="70%" />
      <div class="combatLogsContainer" v-if="combatLogs.length != 0">
        <div class="combatLogsList scrollerFirefox">
          <combat-log-entry
            v-for="logItem in combatLogs"
            :key="logItem.id"
            @log-selected="selectLog"
            :item="logItem"
          ></combat-log-entry>
        </div>
        <div class="combatLogsContent">
          <span v-if="selectedLog">
            <scout-log v-if="selectedLog.attackLog.isScoutAttack" :item="selectedLog"></scout-log>
            <combat-log v-else :item="selectedLog"></combat-log>
          </span>
        </div>
      </div>

      <div v-else>
        <h3>You didn't go in combat yet, what are you doing you lazy viking!</h3>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  computed: {
    combatLogs() {
      return this.$store.getters.combatLogs;
    },
  },
  data() {
    return {
      selectedLog: null,
    };
  },
  mounted() {
    this.getCombatLogs();
  },
  methods: {
    getCombatLogs() {
      this.$store.dispatch('fetchCombatLogs');
    },
    selectLog(item) {
      this.selectedLog = item;
    },
  },
};
</script>

<style lang="scss">
.combatLogsModal {
  display: flex;
  justify-content: center;
  align-self: center;
  flex-direction: column;
  width: 100%;
  text-align: center;
  margin-top: -40px;

  .combatLogBody {
    display: flex;
    height: 100%;
    justify-content: center;
    align-self: center;
    width: 100%;
    flex-direction: column;

    h1 {
      margin-bottom: 0px;
    }
    hr {
      margin-bottom: 20px;
    }
  }

  .combatLogsContainer {
    margin-left: 70px;
    margin-right: 70px;
    margin-bottom: 70px;
    display: flex;
    height: 525px;
    width: 725px;
  }

  .combatLogsList {
    flex: 25;
    border: 12px solid transparent;
    height: 100%;
    border-image: url('../../../assets/borders_modal.png') 40% stretch;
    overflow-y: auto;
    margin-right: 20px;
  }

  .combatLogsContent {
    flex: 75;
    height: 100%;
    border: 12px solid transparent;
    border-image: url('../../../assets/borders_modal.png') 40% stretch;
  }
}
</style>
