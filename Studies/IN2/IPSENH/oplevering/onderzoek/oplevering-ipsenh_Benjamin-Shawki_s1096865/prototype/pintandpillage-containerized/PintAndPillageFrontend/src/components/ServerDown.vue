<template>
  <div class="serverDown">
    <h1>Something went wrong!</h1>
    <h2>
      It appears something technical is wrong here. <br />
      But no worries, we (might) have some very capable vikings on the job! We are sorry for the
      inconvenience! <br />
      Please try to login on a later time.
    </h2>

    <img src="../assets/elwrick_exploded.png" height="500px" />
    <button @click="navigateHome" class="baseButton">Back to login</button>
  </div>
</template>

<script>
export default {
  methods: {
    navigateHome: function () {
      this.$router.push('/login');
    },
  },
};
</script>

<style scoped lang="scss">
.serverDown {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  margin-top: 100px;
  h1,
  h2 {
    color: white;
    text-align: center;
  }
  button {
    margin-right: 0px;
    width: 150px;
    font-size: 20px;
    height: 50px;
  }
}
</style>
