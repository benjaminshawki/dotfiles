const { defineConfig } = require('cypress');

module.exports = defineConfig({
  fixturesFolder: 'tests/e2e/fixtures',
  screenshotsFolder: 'tests/e2e/screenshots',
  videosFolder: 'tests/e2e/videos',
  e2e: {
    baseUrl: process.env.VUE_APP_FRONTEND_URL || 'http://frontend',
    viewportWidth: 1280,
    viewportHeight: 720,
    env: {
      VUE_APP_FRONTEND_URL: process.env.VUE_APP_FRONTEND_URL || 'http://frontend',
      VUE_APP_BACKEND_URL: process.env.VUE_APP_BACKEND_URL || 'http://backend',
    },
    // setupNodeEvents(on, config) {
    //   config.baseUrl = process.env.VUE_APP_FRONTEND_URL || config.baseUrl;
    //   return config;
    // },
  },
});
