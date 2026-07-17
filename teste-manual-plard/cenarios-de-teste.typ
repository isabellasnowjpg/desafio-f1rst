#set page(margin: 2.4cm)
#set text(size: 11pt, lang: "pt")
#set heading(numbering: "1.")

#show raw.where(block: true): it => block(
  fill: rgb("#f4f4f4"),
  inset: 8pt,
  radius: 3pt,
  width: 100%,
  text(size: 9pt, it),
)

#align(center)[
  #text(size: 17pt, weight: "bold")[Teste de QA Manual -- Web e API]

  #text(size: 11pt)[Cenários de teste em Gherkin -- Advantage Online Shopping]

  #text(size: 10pt, fill: gray)[Julho de 2026]
]

#v(1em)

= Objetivo

Este documento reúne os cenários de teste do desafio de QA manual. O site testado foi o Advantage Online Shopping (https://advantageonlineshopping.com) e a API de busca de produtos (`/catalog/api/v1/products/search`). Os cenários estão escritos em Gherkin, em português.

No final do documento tem a evidência da execução da API de busca. A requisição também foi montada numa collection do Postman, que esta na pasta `evidencias` junto com o retorno completo da API.

= Cenários Web

== Busca de produtos

```
Funcionalidade: Busca de produtos

  Cenário: Buscar um produto existente
    Dado que estou na página inicial do site
    Quando pesquiso por "laptop" no campo de busca
    Então devem ser listados apenas produtos relacionados a "laptop"
    E cada produto deve exibir nome e preço

  Cenário: Buscar um produto que não existe
    Dado que estou na página inicial do site
    Quando pesquiso por "xyzabc" no campo de busca
    Então nenhum produto deve ser listado
    E deve ser exibida uma mensagem informando que não há resultados

  Cenário: Buscar com o campo vazio
    Dado que estou na página inicial do site
    Quando clico na busca sem digitar nada
    Então nenhum resultado deve ser exibido
```

== Carrinho de compras

```
Funcionalidade: Carrinho de compras

  Cenário: Incluir produto no carrinho
    Dado que pesquisei por "laptop"
    E abri a página do produto "HP Pavilion 15t Touch Laptop"
    Quando clico em "ADD TO CART"
    Então o ícone do carrinho deve mostrar 1 item
    E o produto deve aparecer no carrinho com o preço correto

  Cenário: Incluir mais de uma unidade do mesmo produto
    Dado que estou na página do produto "HP Pavilion 15t Touch Laptop"
    Quando altero a quantidade para 2
    E clico em "ADD TO CART"
    Então o carrinho deve mostrar o produto com quantidade 2
    E o valor deve ser o dobro do preço unitário

  Cenário: Incluir produtos diferentes no carrinho
    Dado que adicionei o produto "HP Pavilion 15t Touch Laptop" no carrinho
    Quando adiciono também o produto "HP Stream - 11-d020nr Laptop"
    Então o carrinho deve mostrar os 2 produtos
    E o total deve ser a soma dos dois preços

  Cenário: Remover produto do carrinho
    Dado que tenho um produto no carrinho
    Quando removo o produto na tela do carrinho
    Então o carrinho deve ficar vazio
```

== Tela de pagamento

```
Funcionalidade: Validação do carrinho na tela de pagamento

  Contexto:
    Dado que estou logado no site

  Cenário: Validar produtos incluídos no carrinho na tela de pagamento
    Dado que adicionei o produto "HP Pavilion 15t Touch Laptop" no carrinho
    Quando clico em "CHECKOUT" no carrinho
    Então a tela de pagamento deve exibir o produto "HP Pavilion 15t Touch Laptop"
    E o preço exibido deve ser o mesmo da página do produto
    E a quantidade deve ser a mesma que foi adicionada

  Cenário: Validar total do pedido na tela de pagamento
    Dado que adicionei 2 produtos diferentes no carrinho
    Quando avanço para a tela de pagamento
    Então os 2 produtos devem estar listados
    E o valor total deve ser a soma dos itens do carrinho
```

= Cenários API

API testada: `GET https://www.advantageonlineshopping.com/catalog/api/v1/products/search?name={termo}`

A documentação das APIs fica em https://www.advantageonlineshopping.com/api/docs/.

```
Funcionalidade: API de busca de produtos

  Cenário: Buscar produto existente
    Dado que a API de busca está disponível
    Quando envio um GET para /catalog/api/v1/products/search com name "laptop"
    Então o status code da resposta deve ser 200
    E a lista deve conter somente produtos com "laptop" no nome
    E cada produto deve ter os campos productId, productName e price

  Cenário: Buscar produto sem resultado
    Dado que a API de busca está disponível
    Quando envio um GET para /catalog/api/v1/products/search com name "xyzabc"
    Então o status code da resposta deve ser 200
    E a lista de produtos deve vir vazia

  Cenário: Buscar ignorando maiúsculas e minúsculas
    Dado que a API de busca está disponível
    Quando envio um GET com name "LAPTOP"
    E envio outro GET com name "laptop"
    Então as duas respostas devem trazer os mesmos produtos
```

= Execução da API

A execução foi feita com o curl (mesma função do Postman, via linha de comando). A collection pronta para importar no Postman está no arquivo `evidencias/colecao_postman.json`.

*Requisição:*

```
GET https://www.advantageonlineshopping.com/catalog/api/v1/products/search?name=laptop
```

*Resultado:*

- Status code retornado: *200 OK*
- A resposta trouxe 1 categoria (LAPTOPS) com 7 produtos
- Todos os produtos retornados contêm "Laptop" no nome, ou seja, a lista exibe somente produtos conforme a busca

Trecho da resposta (o retorno completo esta em `evidencias/resposta_busca_laptop.json`):

```
[
  {
    "categoryId": 1,
    "categoryName": "LAPTOPS",
    "products": [
      { "productId": 1, "productName": "HP Pavilion 15t Touch Laptop", "price": 519.99 },
      { "productId": 2, "productName": "HP Pavilion 15z Laptop", "price": 549.99 },
      { "productId": 3, "productName": "HP Pavilion 15z Touch Laptop", "price": 449.99 },
      { "productId": 5, "productName": "HP Stream - 11-d020nr Laptop", "price": 179.99 },
      { "productId": 6, "productName": "HP ENVY x360 - 15t Laptop", "price": 699.99 },
      { "productId": 7, "productName": "HP ENVY - 17t Touch Laptop", "price": 849.99 },
      { "productId": 11, "productName": "HP Pavilion x360 - 11t Touch Laptop", "price": 319.99 }
    ]
  }
]
```

Também foi executada a busca com um termo inexistente (`name=xyzabc`): o serviço respondeu *200* com a lista vazia, conforme esperado no cenário de busca sem resultado.
