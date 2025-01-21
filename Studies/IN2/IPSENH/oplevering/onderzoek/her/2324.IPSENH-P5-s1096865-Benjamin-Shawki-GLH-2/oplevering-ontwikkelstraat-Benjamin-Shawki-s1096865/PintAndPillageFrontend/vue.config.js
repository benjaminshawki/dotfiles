const { defineConfig } = require('@vue/cli-service');
const NodePolyfillPlugin = require('node-polyfill-webpack-plugin');

module.exports = defineConfig({
  transpileDependencies: true,
  lintOnSave: false,
  configureWebpack: {
    plugins: [new NodePolyfillPlugin()],
    optimization: {
      splitChunks: {
        chunks: 'all',
      },
    },
  },
  devServer: {
    proxy: {
      '/api': {
        target: process.env.VUE_APP_BACKEND_URL || 'http://backend:8080',
        secure: false,
      },
    },
  },
});
