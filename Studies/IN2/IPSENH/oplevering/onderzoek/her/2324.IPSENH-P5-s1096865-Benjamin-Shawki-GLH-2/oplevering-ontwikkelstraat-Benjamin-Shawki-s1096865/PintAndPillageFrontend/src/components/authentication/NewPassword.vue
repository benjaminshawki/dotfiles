<template>
  <div class="newPassowrd" @keydown.enter="resetPassword">
    <div class="newPasswordBox">
      <div class="newPasswordInputBox">
        <p style="font-size: 24px">Pick a new password</p>
        <input
          class="inputField"
          id="newPasswordInputField1"
          type="password"
          v-model.trim="password"
          placeholder="Password"
        />
        <input
          class="inputField"
          id="newPasswordInputField2"
          type="password"
          v-model.trim="repeatPassword"
          placeholder="Repeat password"
        />
        <button class="submitButton" id="newPasswordButton" @click="resetPassword">
          Reset password
        </button>
      </div>
    </div>
  </div>
</template>

<script>
/* eslint-disable */
    import { required, sameAs, minLength } from 'vuelidate/lib/validators'
    export default {
        data(){
            return {
                password : "",
                repeatPassword: "",
            }
        },
        validations: {
            password: {
                required,
                minLength: minLength(8),
            },
            repeatPassword: {
                required,
                sameAsPassword: sameAs('password')
            }
        },
        methods: {
            validateForm: function() {
                let validations = [
                    [this.$v.password.required, 'Password is required'],
                    [this.$v.password.minLength, `Password must have at least ${this.$v.password.$params.minLength.min} characters`],
                    [this.$v.repeatPassword.required, 'Password confirmation is required'],
                ];
                for (let i = 0; i < validations.length; i++) {
                    if (!validations[i][0]) {
                        this.$toaster.error(validations[i][1]);
                    }
                }
                return !this.$v.$invalid;
            },
            resetPassword: function() {
                if (this.validateForm()) {
                    let data = {
                        newPassword: this.password,
                        userId: this.$route.query.userId,
                        token: this.$route.query.token,
                    };
                    this.$store.dispatch('newPassword', data)
                        .then(() => this.updateRoute('Login'))
                        .catch(err => {
                            this.$toaster.error('Something went wrong');
                            console.log(err)
                        }
                    );
                }
            },
            updateRoute: function(to){
                this.$emit('updateRoute' ,to)
            },
        }
    }
</script>

<style lang="scss">
    .newPasswordBox{
        background: url("../../assets/backdrop-login.png") no-repeat center;
        height: 600px;
        width: 800px;
        background-size: 580px 80%;
        margin-top: 1.5%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }
    .newPasswordInputBox{
        margin-top: 60px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        p{
            margin-top: 80px;
            font-weight: bold;
            text-align: center;
            font-size: 30px;
            width: 400px;
        }
    }
    #newPasswordInputField1{
        margin-top: 0;
    }
    #newPasswordInputField2{
        margin-top: 5%;
    }
    #newPasswordButton{
        margin-top: 40px;
    }

</style>
