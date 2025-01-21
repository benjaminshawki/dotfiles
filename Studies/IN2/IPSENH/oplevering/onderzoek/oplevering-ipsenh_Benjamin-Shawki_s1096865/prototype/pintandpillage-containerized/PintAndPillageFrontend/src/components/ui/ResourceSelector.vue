<template>
  <div>
    <div class="resourceSelector" @click="dropedDown = !dropedDown" v-click-outside="closeDropDown">
      <div class="selectedResource">
        <img
          :src="require('../../assets/ui-items/' + currentResource + '.png')"
          class="currentResourceImg"
        />
        <p>{{ currentResource }}</p>
      </div>
    </div>
    <div class="dropdownContainer" v-show="dropedDown">
      <div v-for="resource in resources" :key="resource">
        <div v-if="resource !== currentResource" @click="setCurrentResource(resource)">
          <div class="resourceDropdownItems">
            <img
              :src="require('../../assets/ui-items/' + resource + '.png')"
              width="21px"
              height="21px"
            />
            <p>{{ resource }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ResourceSelector',
  props: ['resources'],
  data: function () {
    return {
      currentResource: null,
      dropedDown: false,
    };
  },
  created: function () {
    this.currentResource = this.resources[0];
    this.$emit('selectedUpdate', this.currentResource);
  },
  methods: {
    setCurrentResource: function (resource) {
      this.currentResource = resource;
      this.$emit('selectedUpdate', this.currentResource);
      this.dropedDown = false;
    },
    closeDropDown: function () {
      this.dropedDown = false;
    },
  },
};
</script>

<style lang="scss">
.resourceSelector,
.dropdownContainer {
  user-select: none;
  border: 7px solid transparent;
  border-image: url('../../assets/borders_modal.png') 40% stretch;
  position: relative;
  z-index: 200;
  .currentResourceImg {
    width: 21px;
    height: 21px;
    min-width: 21px;
  }
}

.resourceDropdownItems,
.selectedResource {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  width: 98px;
  text-align: center;
  height: 35px;
  background-color: #7f7f7f;
  font-size: 14px;
  cursor: pointer;
  position: relative;
  z-index: 200;
  img {
    margin-left: 14px;
  }
}
.resourceDropdownItems:hover {
  background-color: #646464;
}
</style>
