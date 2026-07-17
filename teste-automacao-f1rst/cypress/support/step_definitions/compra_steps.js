const { When, Then } = require("@badeball/cypress-cucumber-preprocessor");

When("busco pelo produto {string}", (produto) => {
  cy.visit("/products");
  cy.get("#search_product").type(produto);
  cy.get("#submit_search").click();
});

When("adiciono o primeiro resultado no carrinho", () => {
  // o botao fica atras do overlay do produto, por isso o force
  cy.get(".features_items .productinfo .add-to-cart").first().click({ force: true });
  cy.get("#cartModal").should("be.visible");
  cy.contains("button", "Continue Shopping").click();
});

When("sigo do carrinho para o checkout", () => {
  cy.visit("/view_cart");
  cy.contains("Proceed To Checkout").click();
});

Then("a lista de resultados deve mostrar o produto {string}", (produto) => {
  cy.contains("h2", "Searched Products").should("be.visible");
  cy.get(".features_items .productinfo p").first().should("contain.text", produto);
});

Then("o carrinho deve conter o produto {string}", (produto) => {
  cy.visit("/view_cart");
  cy.get("#cart_info_table").should("contain.text", produto);
});

Then("a tela de pagamento deve mostrar o produto {string}", (produto) => {
  cy.url().should("include", "/checkout");
  // valida o produto na revisao do pedido antes do pagamento
  cy.get("#cart_info").should("contain.text", produto);
});
