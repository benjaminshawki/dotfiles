<template>
  <div class="tabNavigationContainer">
    <div class="tabs">
      <a
        v-for="tab in tabList"
        :key="tab.key"
        :style="[
          isCurrentTab(tab) ? { backgroundColor: '#696969' } : { backgroundColor: '#494949' },
        ]"
        @click="changeTabView(tab)"
      >
        {{ tab.name }}
        <hr v-if="isCurrentTab(tab)" width="80%" />
      </a>
    </div>
    <div class="tabBody">
      <component v-bind:is="loadedTab.componentName" :properties="properties"></component>
    </div>
  </div>
</template>

<script>
export default {
  props: ['tabList', 'properties'],
  data: function () {
    return {
      loadedTab: null,
    };
  },
  created: function () {
    this.loadedTab = this.tabList[0];
  },
  methods: {
    changeTabView: function (tab) {
      this.loadedTab = tab;
    },
    isCurrentTab: function (tab) {
      return tab.name === this.loadedTab.name;
    },
  },
};
</script>

<style lang="scss">
.tabNavigationContainer {
  min-width: 700px;
  display: flex;
  flex-direction: column;
  min-height: 420px;
  .tabs {
    display: flex;
    flex-direction: row;
    background-color: #434343;
    border: 10.5px solid transparent;
    border-image: url('../../assets/borders_modal.png') 40% stretch;
    a {
      background-color: #434343;
      height: 21px;
      color: white;
      font-size: 17px;
      text-align: center;
      padding: 14px;
      cursor: pointer;
      user-select: none;
      border-right: 10.5px solid transparent;
      border-image: url('../../assets/borders_modal.png') 40% stretch;
    }
    a:hover {
      background-color: #696969 !important;
    }
    a:focus {
      outline: none !important;
      border: none;
    }
  }
  .tabBody {
    min-height: 280px;
    height: 280px;
    background-color: #434343;
  }
}
</style>
