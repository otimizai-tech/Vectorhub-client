# Documentação - Docker Swarm

## Inicializando o Docker Swarm
Para iniciar o Docker Swarm no nó principal, execute o comando abaixo:
```sh
docker swarm init
```

## Implantando uma Stack
Para implantar uma stack utilizando um arquivo `docker-compose2.yml`, utilize o seguinte comando:
```sh
docker stack deploy -c docker-compose2.yml minha-stack
```
Substitua `docker-compose2.yml` pelo nome correto do arquivo de configuração caso necessário.

## Listando os Serviços da Stack
Para visualizar os serviços em execução dentro da stack, utilize o seguinte comando:
```sh
docker stack services minha-stack
```

## Removendo uma Stack
Caso queira remover uma stack específica, utilize o comando abaixo:
```sh
docker stack rm minha-stack
```

## Verificando a Conexão das Portas
Para testar se um serviço está respondendo em uma determinada porta, utilize o `curl`:
```sh
curl http://localhost:8081
```
Substitua `8081` pela porta configurada no serviço desejado.

## Considerações Finais
Esses comandos são fundamentais para gerenciar stacks dentro do Docker Swarm. Certifique-se de que o Docker Swarm está iniciado antes de tentar implantar uma stack.
