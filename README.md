# buscacep

Esa é uma api em Elixir para buscar endereços através de ceps.

##Iniciando o projeto
1. Clone o repositório na sua máquina
2. Abra o terminal na pasta do projeto `/busca_cep_api`
3. Nesta pasta, rode o comando `docker_compose_up -d` para subir um banco de dados postgress
4. Rode o comando `mix.ecto.setup` para rodar as migrations e conectar o projeto como banco de dados

#Buscando um cep
Após iniciar o processo, você pode abrir o seu navegador de preferência e colocar e acessar os endpoints do projeto em seu locallhost:4000
Coloque no navegador a seguinte url "http://localhost:4000/api/cep/{seu_cep}". Você pode substituir o {seu_cep} por um cep conhecido ou não.
Caso o cep exista, você verá na tela as informações de endereço relacionadas àquele CEP.
Caso seja um cep inválivo ou não existente, você receberá as mensagens Invalid cep ou Not Found, respectivamente.

#Importando um CSV
Para ver todos os ceps já cadastrados na api, basta colocar no navegador a seguinte url: "http://localhost:4000/api/export" e haverá um download dos registros, em CSV disponível.
