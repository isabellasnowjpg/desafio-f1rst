# Teste de Automação - F1RST

Projeto de automação de testes web e API usando Cypress + Cucumber (BDD) em JavaScript.

Obs: o site do desafio (automationpractice.com) esta fora do ar, então usei o
https://www.automationexercise.com que o próprio documento sugere como alternativa.
Como o login informado no doc era do site antigo, os testes criam um usuário próprio
pela API do site antes de rodar (se o usuário ja existir, só segue em frente).

## Pré-requisitos

- Node.js 18 ou superior
- npm

## Instalação

```
npm install
```

## Como executar

Rodar todos os testes (headless):

```
npm test
```

Abrir o Cypress no modo interativo:

```
npm run test:open
```

Rodar só os testes de API:

```
npm run test:api
```

Rodar só os testes web:

```
npm run test:web
```

## Estrutura do projeto

```
cypress/
  e2e/                          -> features em Gherkin (pt-br)
    login.feature
    compra.feature
    api_trello.feature
  support/
    step_definitions/           -> implementação dos steps
  fixtures/
    usuario.json                -> dados do usuário de teste
```

## Cenários

Web (automationexercise.com):
- Login com usuário valido
- Login com senha errada
- Busca de produto
- Incluir produto no carrinho
- Validar o produto do carrinho na tela de pagamento (checkout)

API:
- GET em https://api.trello.com/1/actions/592f11060f95a3d3d46a987a
- Valida o status code 200 e exibe o campo "name" da estrutura "list" (sai no log do teste)
