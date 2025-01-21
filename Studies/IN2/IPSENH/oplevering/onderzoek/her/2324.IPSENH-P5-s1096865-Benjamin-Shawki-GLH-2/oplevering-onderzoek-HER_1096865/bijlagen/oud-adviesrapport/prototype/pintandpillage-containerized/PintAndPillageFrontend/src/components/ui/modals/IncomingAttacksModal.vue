<template>
  <div
    v-if="
      village &&
      (incomingAttacks.length > 0 ||
        outgoingAttacks.length > 0 ||
        returningCombatTravels.length > 0)
    "
    class="outerUnitsModal scrollerFirefox"
  >
    <div class="innerUnitsModal">
      <div v-if="incomingAttacks.length > 0">
        <h2 class="warningText">! Incoming attacks !</h2>
        <div>
          <p v-for="attack in incomingAttacks" :key="attack.id">
            Attack incoming in: {{ attack.travelTimeLeft }}
          </p>
        </div>
      </div>

      <div v-if="outgoingAttacks.length > 0">
        <h2>Outgoing attacks</h2>
        <div>
          <p v-for="attack in outgoingAttacks" :key="attack.id">
            Units arrive in: {{ attack.travelTimeLeft }}
          </p>
        </div>
      </div>

      <div v-if="returningCombatTravels.length > 0">
        <h2>Plunder return</h2>
        <div>
          <p v-for="attack in returningCombatTravels" :key="attack.id">
            Plunder arrives in: {{ attack.travelTimeLeft }}
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as moment from 'moment';

export default {
  computed: {
    village: function () {
      return this.$store.getters.village;
    },
    incomingAttacks() {
      // Create a copy of the array before sorting
      const attacksCopy = [...this.$store.getters.incomingAttacks];
      return attacksCopy.sort((a, b) => {
        return (
          moment.duration(a.travelTimeLeft).asSeconds() -
          moment.duration(b.travelTimeLeft).asSeconds()
        );
      });
    },
    outgoingAttacks() {
      // Create a copy of the array before sorting
      const attacksCopy = [...this.$store.getters.outgoingAttacks];
      return attacksCopy.sort((a, b) => {
        return (
          moment.duration(a.travelTimeLeft).asSeconds() -
          moment.duration(b.travelTimeLeft).asSeconds()
        );
      });
    },
    returningCombatTravels() {
      // Create a copy of the array before sorting
      const travelsCopy = [...this.$store.getters.returningCombatTravels];
      return travelsCopy.sort((a, b) => {
        return (
          moment.duration(a.travelTimeLeft).asSeconds() -
          moment.duration(b.travelTimeLeft).asSeconds()
        );
      });
    },
  },
  methods: {
    sortList: function (attack) {
      return attack.sort((a, b) => {
        return (
          moment.duration(a.travelTimeLeft).asSeconds() -
          moment.duration(b.travelTimeLeft).asSeconds()
        );
      });
    },
  },
};
</script>

<style scoped lang="scss">
.outerUnitsModal {
  display: flex;
  justify-content: flex-start;
  align-items: flex-start;
  user-select: none;
  flex-direction: column;
  .innerUnitsModal {
    display: flex;
    justify-content: flex-start;
    flex-direction: column;
    align-items: center;
    margin-left: 56px;
    border: 7px solid transparent;
    border-image: url('../../../assets/borders_modal.png') 40% stretch;
    min-height: 80px;
    min-width: 210px;
    background-color: #434343;

    p {
      color: white;
      margin: 4px;
    }

    .warningText {
      color: #da3c40;
    }

    h2 {
      font-size: 17px;
      text-align: center;
    }
    h3 {
      margin-bottom: 0px;
      color: white;
      margin-right: 7px;
      font-size: 13px;
    }
  }
}
</style>
