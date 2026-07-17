const { When, Then } = require("@badeball/cypress-cucumber-preprocessor");

const URL_TRELLO = "https://api.trello.com/1/actions/592f11060f95a3d3d46a987a";

When("envio um GET para o endpoint de actions do Trello", () => {
  cy.request("GET", URL_TRELLO).as("respostaTrello");
});

Then("o status code da resposta deve ser 200", () => {
  cy.get("@respostaTrello").its("status").should("eq", 200);
});

Then("o campo name da estrutura list deve ser exibido", () => {
  cy.get("@respostaTrello").then((resposta) => {
    const nomeLista = resposta.body.data.list.name;
    cy.log("name da list: " + nomeLista);
    // deixa no log do terminal tbm
    console.log("name da list: " + nomeLista);
    expect(nomeLista).to.not.be.empty;
  });
});
