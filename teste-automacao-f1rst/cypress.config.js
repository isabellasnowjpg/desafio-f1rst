const { defineConfig } = require("cypress");
const createBundler = require("@bahmutov/cypress-esbuild-preprocessor");
const { addCucumberPreprocessorPlugin } = require("@badeball/cypress-cucumber-preprocessor");
const { createEsbuildPlugin } = require("@badeball/cypress-cucumber-preprocessor/esbuild");

module.exports = defineConfig({
  e2e: {
    baseUrl: "https://www.automationexercise.com",
    specPattern: "cypress/e2e/**/*.feature",
    defaultCommandTimeout: 10000,
    pageLoadTimeout: 90000,
    video: false,
    // bloqueia os anuncios do site pq atrapalham os testes
    blockHosts: [
      "*googlesyndication.com",
      "*doubleclick.net",
      "*google-analytics.com",
      "*googletagmanager.com",
      "*fundingchoicesmessages.google.com"
    ],
    async setupNodeEvents(on, config) {
      await addCucumberPreprocessorPlugin(on, config);
      on(
        "file:preprocessor",
        createBundler({ plugins: [createEsbuildPlugin(config)] })
      );
      return config;
    }
  }
});
