const { Given, When, Then } = require("@badeball/cypress-cucumber-preprocessor");

Given("que estou na pagina de login", () => {
  cy.visit("/login");
  cy.contains("Login to your account").should("be.visible");
});

When("informo email e senha validos", () => {
  cy.fixture("usuario").then((usuario) => {
    cy.get('[data-qa="login-email"]').type(usuario.email);
    cy.get('[data-qa="login-password"]').type(usuario.senha, { log: false });
    cy.get('[data-qa="login-button"]').click();
  });
});

When("informo email valido e senha errada", () => {
  cy.fixture("usuario").then((usuario) => {
    cy.get('[data-qa="login-email"]').type(usuario.email);
    cy.get('[data-qa="login-password"]').type("senhaerrada123");
    cy.get('[data-qa="login-button"]').click();
  });
});

Then("devo ver que estou logado no topo da pagina", () => {
  cy.contains("Logged in as").should("be.visible");
});

Then("deve aparecer a mensagem de login invalido", () => {
  cy.contains("Your email or password is incorrect!").should("be.visible");
});
