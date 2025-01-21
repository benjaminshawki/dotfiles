<template>
  <div class="resetPassowrd" @keydown.enter="resetPassword">
    <div class="resetPasswordBox">
      <div class="resetPasswordInputBox">
        <input class="inputField" type="email" v-model.trim="email" placeholder="Email" />
        <a class="redirects" @click="updateRoute('Login')">Login</a>
        <a class="redirects" @click="updateRoute('Register')">Create new account</a>
        <button class="submitButton" @click="resetPassword">Reset password</button>
      </div>
    </div>
  </div>
</template>

<script>
/* eslint-disable */
    import { required, email } from 'vuelidate/lib/validators'
    export default {
        data(){
            return {
                email : "",
            }
        },
        validations: {
            email: {
                required,
                email
            },
        },
        methods: {
            validateForm: function() {
                let validations = [
                    [this.$v.email.required, 'Email is required'],
                    [this.$v.email.email, 'Email is invalid'],
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
                        email: this.email,
                    };
                    this.$store.dispatch('resetPassword', data)
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

<style>
    .resetPasswordBox{
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
    .resetPasswordInputBox{
        margin-top: 60px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }
</style>
