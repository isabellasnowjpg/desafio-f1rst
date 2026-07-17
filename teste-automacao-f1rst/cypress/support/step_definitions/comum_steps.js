const { Given } = require("@badeball/cypress-cucumber-preprocessor");

Given("que o usuario de teste existe", () => {
  // cria o usuario pela api do site, se ja existir o site so avisa e segue
  cy.fixture("usuario").then((usuario) => {
    cy.request({
      method: "POST",
      url: "https://automationexercise.com/api/createAccount",
      form: true,
      body: {
        name: usuario.nome,
        email: usuario.email,
        password: usuario.senha,
        title: "Mr",
        birth_date: "10",
        birth_month: "5",
        birth_year: "1990",
        firstname: "Teste",
        lastname: "QA",
        company: "teste",
        address1: "Rua Teste 123",
        address2: "",
        country: "India",
        zipcode: "01000-000",
        state: "SP",
        city: "Sao Paulo",
        mobile_number: "11999999999"
      }
    }).its("status").should("eq", 200);
  });
});

Given("que estou logado", () => {
  cy.fixture("usuario").then((usuario) => {
    cy.visit("/login");
    cy.get('[data-qa="login-email"]').type(usuario.email);
    cy.get('[data-qa="login-password"]').type(usuario.senha, { log: false });
    cy.get('[data-qa="login-button"]').click();
    cy.contains("Logged in as").should("be.visible");
  });
});
