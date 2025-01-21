/** @type {import("eslint").Linter.Config} */
module.exports = {
  extends: ['plugin:vue/essential', 'eslint:recommended', '@vue/standard', '@vue/prettier'],
  env: { es6: true, node: true },
  root: false,
  parserOptions: {
    parser: '@babel/eslint-parser',
  },
  rules: {
    camelcase: 'off',
  },
  overrides: [
    {
      files: ['**/__tests__/*.{j,t}s?(x)', '**/tests/unit/**/*.spec.{j,t}s?(x)'],
      env: {
        jest: true,
      },
    },
  ],
};
