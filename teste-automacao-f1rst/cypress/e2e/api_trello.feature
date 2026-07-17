# language: pt
Funcionalidade: API do Trello
  Consulta de uma action do Trello para validar o retorno do servico

  Cenário: Consultar action e exibir o name da estrutura list
    Quando envio um GET para o endpoint de actions do Trello
    Então o status code da resposta deve ser 200
    E o campo name da estrutura list deve ser exibido
