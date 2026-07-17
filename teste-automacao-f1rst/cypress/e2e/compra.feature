# language: pt
Funcionalidade: Busca, carrinho e pagamento
  Como usuario logado
  Quero buscar produtos e adicionar no carrinho
  Para finalizar a compra

  Contexto:
    Dado que o usuario de teste existe
    E que estou logado

  Cenário: Buscar um produto
    Quando busco pelo produto "Blue Top"
    Então a lista de resultados deve mostrar o produto "Blue Top"

  Cenário: Incluir produto no carrinho
    Quando busco pelo produto "Blue Top"
    E adiciono o primeiro resultado no carrinho
    Então o carrinho deve conter o produto "Blue Top"

  Cenário: Validar produto do carrinho na tela de pagamento
    Quando busco pelo produto "Blue Top"
    E adiciono o primeiro resultado no carrinho
    E sigo do carrinho para o checkout
    Então a tela de pagamento deve mostrar o produto "Blue Top"
