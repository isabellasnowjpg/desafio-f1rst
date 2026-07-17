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
