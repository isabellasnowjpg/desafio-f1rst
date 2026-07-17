// o site de teste tem uns scripts de propaganda que estouram erro,
// isso aqui evita que o teste quebre por causa deles
Cypress.on("uncaught:exception", () => {
  return false;
});
