import Vue from 'vue';
import Router from 'vue-router';
import Authentication from './views/Authentication.vue';
import Village from './views/Village.vue';
import World from './views/World.vue';
import ServerDown from './components/ServerDown';

Vue.use(Router);
/* eslint-disable */


const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'village',
      component: Village,
    },
    {
      path: '/login',
      name: 'login',
      component: Authentication,
      props: {page: 'Login'},
    },
    {
      path: '/confirm',
      name: 'confirm',
      component: Authentication,
      props: {page: 'Confirm'},
    },
    {
      path: '/register',
      name: 'register',
      component: Authentication,
      props: {page: 'Register'},
    },
    {
      path: '/resetpassword',
      name: 'resetpassword',
      component: Authentication,
      props: {page: 'ResetPassword'},
    },
    {
      path: '/newpassword',
      name: 'newpassword',
      component: Authentication,
      props: {page: 'NewPassword'},
    },
    {
      path: '/world',
      name: 'world',
      component: World,
    },
    {
      path: '/patchnotes',
      name: 'patchnotes',
      component: Authentication,
      props: {page: 'PatchNotes'},
    },
    {
      path: '/homepage',
      name: 'homepage',
      component: Authentication,
      props: {page: 'HomePage'},
    },
    {
      path: '/woeps',
      name: 'woeps',
      component: ServerDown,
    },
  ]
});
router.beforeEach((to, from, next) => {
  const publicPages = ['/login', '/register', '/resetpassword', '/newpassword', '/confirm', '/patchnotes', '/homepage', '/woeps '];
  const authRequired = !publicPages.includes(to.path);
  const loggedIn = localStorage.getItem('token');
  if (authRequired && !loggedIn && to.fullPath != '/woeps') {
    return next('/homepage');
  }
  next();
});
export default router
