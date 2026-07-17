# language: pt
Funcionalidade: Login
  Como usuario do site
  Quero fazer login
  Para acessar minha conta

  Contexto:
    Dado que o usuario de teste existe

  Cenário: Login com sucesso
    Dado que estou na pagina de login
    Quando informo email e senha validos
    Então devo ver que estou logado no topo da pagina

  Cenário: Login com senha invalida
    Dado que estou na pagina de login
    Quando informo email valido e senha errada
    Então deve aparecer a mensagem de login invalido
