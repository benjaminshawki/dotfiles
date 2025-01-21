<template>
  <div class="questModal" v-if="currentQuest">
    <div class="questComponents">
      <h1>Quests</h1>
      <hr width="80%" />
      <h2>{{ currentQuest.title }}</h2>
      <h3>Description</h3>
      <p class="questDescription">{{ currentQuest.description }}</p>
      <h2>Quest Objectives</h2>
      <div
        v-for="objectives in currentQuest.objectives"
        :key="objectives.key"
        class="objectiveList"
      >
        <p
          :style="[
            objectives.isCompleted
              ? { textDecoration: 'line-through' }
              : { textDecoration: 'none' },
          ]"
        >
          - {{ objectives.description }}
        </p>
        <p class="questCompleted" v-if="objectives.isCompleted">- Completed!</p>
      </div>
      <div class="questRewards">
        <h2>Rewards:</h2>
        <resource-item
          class="resourceItemQuestModal"
          :resources="currentQuest.resourcesOnCompletion"
          :checkAvailability="checkAvailability"
        ></resource-item>
      </div>
      <button
        :disabled="!currentQuest.isCompleted"
        @click="finishQuest"
        class="baseButton"
        id="questButton"
      >
        Collect Reward
      </button>
    </div>
  </div>
  <div v-else class="noQuestsDisplay">
    <h1>Quests</h1>
    <hr width="80%" />
    <p>There are no more quests to display</p>
  </div>
</template>

<script>
export default {
  computed: {
    currentQuest: function () {
      return this.$store.getters.village.quest;
    },
  },
  data: function () {
    return {
      checkAvailability: false,
      mockQuests: {
        questId: 3,
        title: 'Other stuff',
        description:
          'Almost every building requires population, we will need lots of them so build a house and level it up.We will also need storage to store all those pints, so build one of those too.',
        name: 'House',
        objectives: [
          {
            buildingName: 'Storage',
            description: 'Build a Storage',
          },
          {
            buildingName: 'House',
            level: 2,
            description: 'Level a House to level 2',
          },
        ],
        resourcesOnCompletion: {
          Wood: 150,
          Stone: 150,
          Beer: 150,
        },
        isCompleted: false,
      },
    };
  },
  methods: {
    finishQuest: function () {
      const villageId = this.$store.getters.village.villageId;
      this.$store.dispatch('finishQuest', villageId).then(() => {
        this.$toaster.success('Resources Added');
      });
    },
  },
};
</script>

<style lang="scss">
.questModal {
  display: flex;
  justify-content: center;
  align-self: center;
  flex-direction: column;
  width: 100%;
  text-align: center;
  margin-top: -50px;
  .objectiveList {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: row !important;
    width: 100%;
    .questCompleted {
      color: #48bf25;
      margin-left: 10px;
    }
  }

  .questComponents {
    display: flex;
    height: 100%;
    justify-content: center;
    align-self: center;
    width: 100%;
    flex-direction: column;
  }
  .questDescription {
    max-width: 500px;
    display: flex;
    align-self: center;
    justify-self: center;
  }
  .objectiveList {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: left !important;
  }
  .questRewards {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    h2 {
      margin-bottom: 20px;
    }
  }
  #questButton {
    height: 35px;
    width: 119px;
    display: flex;
    justify-self: center;
    align-self: center;
    margin-top: 14px;
    margin-right: 0px;
  }

  h1,
  h2,
  p,
  h3 {
    margin-bottom: 0px;
  }
  .resourceItemQuestModal {
    p {
      margin-bottom: 20px !important;
    }
  }
  button {
    text-align: center;
    display: flex;
    justify-content: center;
    align-items: center;
  }
}
.noQuestsDisplay {
  display: flex;
  justify-content: center;
  align-self: center;
  width: 100%;
  flex-direction: column;
  text-align: center;
  margin-top: -50px;
}
</style>
