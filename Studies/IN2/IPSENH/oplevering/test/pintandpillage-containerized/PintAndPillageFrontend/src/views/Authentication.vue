<template>
  <div class="authentication">
    <p style="margin-bottom: 0px">Version: 1.0.1</p>
    <div class="headerLogin">
      <a
        @click="redirect('HomePage')"
        style="border-left: none !important; border-right: none !important"
      >
        Home
        <hr v-if="isCurrentTab('HomePage')" width="80%" />
      </a>
      <a @click="redirect('Login')" style="border-left: 10px solid transparent">
        Login / Register
        <hr v-if="isCurrentTab('Login')" width="80%" />
      </a>
      <a @click="redirect('PatchNotes')" style="border-right: none !important">
        What's new?
        <hr v-if="isCurrentTab('PatchNotes')" width="80%" />
      </a>
    </div>
    <component
      style="margin-left: 10px"
      @updateRoute="redirect($event)"
      v-bind:is="componentName"
    ></component>
  </div>
</template>

<script>
import Login from '../components/authentication/Login';
import Register from '../components/authentication/Register';
import ResetPassword from '../components/authentication/ResetPassword';
import NewPassword from '../components/authentication/NewPassword';
import Confirm from '../components/authentication/Confirm';
import PatchNotes from '../components/authentication/PatchNotes';
import HomePage from '../components/authentication/HomePage';

export default {
  name: 'authentication',
  components: { Login, Register, ResetPassword, NewPassword, Confirm, PatchNotes, HomePage },
  data() {
    return {
      componentName: this.page,
      currentTab: 'Login',
    };
  },
  props: {
    page: {
      type: String,
      default: 'Login',
    },
  },
  methods: {
    redirect: function (to) {
      if (this.$route.path !== '/' + to.toLowerCase()) {
        this.$router.push('/' + to.toLowerCase());
        this.componentName = to;
      }
    },
    isCurrentTab: function (tabName) {
      if (this.componentName === tabName) {
        return true;
      }
      return false;
    },
  },
};
</script>

<style lang="scss">
.inputField {
  margin-top: 14%;
  padding-left: 10px;
  height: 28px;
  width: 170px;
  color: white;
  font-size: 12px;
  background-color: #586365;
  border: 3px solid black;
}
.inputField::placeholder {
  color: #bbbbbb;
  font-style: italic;
}
.redirects {
  color: #15636c;
  font-size: 16px;
  margin: 7px;
  cursor: pointer;
}
.submitButton {
  margin-top: 10px;
  color: white;
  background-color: #15636c;
  border-radius: 3px;
  height: 35px;
  font-size: 14px;
  width: 149px;
  border: 3px solid black;
}
.submitButton:focus {
  outline: none !important;
  border: 3px solid #1e8c99;
  box-shadow: 0 0 5px #1e8c99;
}
hr {
  margin-bottom: -10px;
}
.authentication {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  width: 100%;
}

.headerLogin {
  display: flex;
  z-index: 10;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  justify-self: center;
  align-self: center;
  background-color: #646f73;
  border: 10.5px solid transparent;
  border-image: url('../assets/borders_modal.png') 40% stretch;
  margin: 0px;
  margin-top: 10px;
  user-select: none;
  a {
    background-color: #646f73;
    color: white;
    font-size: 17px;
    text-align: center;
    padding: 12px 10px;
    cursor: pointer;
    user-select: none;
    border-right: 10.5px solid transparent;
    border-image: url('../assets/border_side.png') 0% 100% stretch;
    margin-top: -1px;
    margin-bottom: -2px;
    min-width: 100px;
  }
  a:hover {
    background-color: #586366 !important;
  }
  a:focus {
    outline: none !important;
    border: none;
  }
  p {
    /*margin-left: auto;*/
    margin-right: 40px;
    color: white;
  }
}
</style>
