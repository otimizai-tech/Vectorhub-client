# Guia de Configuração do Cliente VectorHub

Este guia fornece instruções para configurar e executar o ambiente Docker Compose do `VectorHub` usando o arquivo de imagem `vectorhub.tar` fornecido após clonar o repositório.

## Pré-requisitos

- **Docker**: Certifique-se de que o Docker esteja instalado em seu sistema. [Guia de Instalação do Docker](https://docs.docker.com/get-docker/).
- **Docker Compose**: Verifique se o Docker Compose está instalado. Geralmente, ele vem junto com o Docker, mas você pode verificar ou instalá-lo usando este [Guia de Instalação do Docker Compose](https://docs.docker.com/compose/install/).
- **Git**: Certifique-se de que o Git esteja instalado para clonar o repositório. Caso contrário, instale-o em [Instalação do Git](https://git-scm.com/downloads).

## Passos para Instalação

1. **Clone o Repositório**

   Clone o repositório do Cliente VectorHub para sua máquina local:
   ```bash
   git clone https://github.com/otimizai-tech/Vectorhub-client.git
   cd Vectorhub-client
   ```
2 **Baixe a Imagem Docker**
    Faça o login no azure pelo terminal utilizando as credenciais do login temporario(solicite estas credenciais)

3. **Carregue a Imagem Docker**

    Logado no ambiente da azure carregue a imagem com o comando:

       ```bash
   docker pull otimizai.azurecr.io/vectorhubclient:latest
   ```

4. **Verifique a Imagem**

   Confirme se a imagem foi carregada com sucesso listando suas imagens Docker:
   ```bash
   docker images
   ```

   Você deverá ver uma imagem chamada `otimizai.azurecr.io/vectorhubclient` com a tag `latest` na lista.

2.2 **Baixe a Imagem Docker(segunda opção)**

   Baixe o arquivo `vectorhub.tar` da versão mais recente do GitHub:
   [Baixar vectorhub.tar](https://github.com/otimizai-tech/Vectorhub-client/releases/download/v0.2.4/vectorhub.tar)

   Alternativamente, você pode usar a linha de comando para baixar o arquivo diretamente:
   ```bash
   wget https://github.com/otimizai-tech/Vectorhub-client/releases/download/v0.2.4/vectorhub.tar
   ```

3.2 **Carregue a Imagem Docker(segunda opção)**

   Após baixar o arquivo `vectorhub.tar`, carregue-o no Docker usando o seguinte comando:
   ```bash
   docker load -i vectorhub.tar
   ```

   Este comando importa a imagem `otimizai/vectorhub-client:latest` para o seu ambiente Docker.

4.2 **Verifique a Imagem(segunda opção)**

   Confirme se a imagem foi carregada com sucesso listando suas imagens Docker:
   ```bash
   docker images
   ```

   Você deverá ver uma imagem chamada `otimizai/vectorhub-client` com a tag `latest` na lista.

5. **Execute a Configuração do Docker Compose**

   Inicie a pilha de aplicativos completa usando o Docker Compose com o seguinte comando:
   ```bash
   docker-compose up -d
   ```

   Este comando iniciará todos os serviços definidos no seu arquivo `docker-compose.yml`, incluindo Redis, EdgeDB, Qdrant e a API VectorHub.


6. **Verifique a API e Acesse a Interface de Administração**

   Após os serviços estarem em execução, você pode verificar se a API está rodando em:
   ```
   http://localhost:8081
   ```

   ou na porta especificada no seu arquivo `.env`.

   Após verificar a API, vá para [vectorhub.tech/admin](http://vectorhub.tech/admin), insira a senha como variável `SECRET_KEY_ADMIN` especificada no arquivo `.env` e copie o token ao logar em `http://vectorhub.tech/admin`. Este token será usado como um Bearer Token para autenticação e acesso à interface UI do VectorHub.


## Parando os Serviços

Para parar todos os serviços em execução, use o seguinte comando:
```bash
docker-compose down
```

Este comando irá parar e remover todos os contêineres definidos na sua configuração do Docker Compose.

## Solução de Problemas

- **Conflitos de Porta**: Se você encontrar conflitos de porta, certifique-se de que as portas especificadas no seu arquivo `.env` não estejam sendo usadas por outros serviços na sua máquina.
- **Imagem Não Encontrada**: Se o Docker Compose não conseguir encontrar a imagem, certifique-se de que você baixou e carregou o arquivo `vectorhub.tar` conforme descrito nos Passos 2 e 3.

---

# **Documentação da API para `POST /query`**

## **Endpoint**
**`POST /query`**

### **Autorização**
O endpoint requer um cabeçalho **Authorization** com um token Bearer válido. Exemplo:

```http
Authorization: Bearer {TOKEN}
```

## **Corpo da Requisição**
O corpo da requisição deve estar no formato JSON. Abaixo estão as variáveis aceitas:

### **Variáveis**

| **Variável**       | **Tipo**   | **Obrigatório** | **Padrão** | **Descrição**                                                                                   |
|---------------------|------------|-----------------|------------|---------------------------------------------------------------------------------------------------|
| `query`            | `string`   | Sim             | `None`     | A string de consulta de pesquisa usada para realizar a operação principal.                         |
| `collection_name`  | `string`   | Sim             | `None`     | O nome da coleção para consultar.                                                                |
| `with_payload`     | `boolean`  | Não             | `True`     | Determina se a resposta deve incluir payloads adicionais associados aos resultados da consulta. |
| `score_threshold`  | `float`    | Não             | `None`     | A pontuação mínima que um resultado deve alcançar para ser incluído na resposta.                  |
| `limit_wo_XID`     | `integer`  | Não             | `1`        | O número máximo de resultados a serem retornados quando o atributo `X_ID` não está presente na consulta. |
| `limit_w_XID`      | `integer`  | Não             | `1`        | O número máximo de resultados a serem retornados quando o atributo `X_ID` está presente na consulta. |
| `limit_w_hits`     | `integer`  | Não             | `10`       | O número máximo de resultados a serem retornados quando a consulta corresponde a itens baseados em hits. |
| `query_filter`     | `object`   | Não             | `None`     | Critérios de filtragem adicionais aplicados à consulta para refinar os resultados.                |

---

## **Exemplo de Requisição**

### **Cabeçalho da Requisição**
```http
POST {endpoint}/query 
Authorization: Bearer YOUR_TOKEN
Content-Type: application/json
```

### **Corpo da Requisição**
```json
{
    "query": "teste",
    "collection_name": "teste",
    "with_payload": true,
    "score_threshold": 0.5,
    "limit_wo_XID": 5,
    "limit_w_XID": 2,
    "limit_w_hits": 15,
    "query_filter": {
        "must": [
            { "key": "system_metadata.tags_name", "match": { "value": "contract" }}
        ]
    }
}
```

### **Resultado**

Quando o endpoint `/query` é chamado com sucesso, ele retorna uma resposta JSON estruturada. Este documento fornece uma explicação detalhada dos campos de resposta e sua importância.

---

### **Estrutura da Resposta**

```json
{
  "status": true,
  "message": "query: <pergunta da consulta>",
  "data": [
    {
      "id": "UUID",
      "payload": {...},
      "score": 0.67
      },
      ...
  ]
}
```

---

### **Campos de Nível Superior**

| **Campo**    | **Tipo**   | **Descrição**                                                                                           |
|--------------|------------|-----------------------------------------------------------------------------------------------------------|
| `status`     | `boolean`  | Indica se a consulta foi processada com sucesso.                                                        |
| `message`    | `string`   | Fornece contexto ou feedback sobre a operação de consulta, geralmente ecoando a consulta ou descrevendo erros. |
| `data`       | `object`   | Contém os resultados principais da consulta semântica, incluindo `states`, `refs` e `edges`.           |

---

### **Explicação Detalhada de `data`**

#### **1. `states`**
- **Tipo:** Objeto
- **Descrição:** Contém os resultados reais da pesquisa semântica.
- **Estrutura:** 
  - Cada chave em `states` representa um índice (baseado em `refs`).
  - Cada índice contém:
    - **`payload`**: Inclui `metadata` e `pageContent`—o texto recuperado ou conteúdo associado.
    - **`system_metadata`**: Detalhes adicionais sobre o arquivo ou contexto do sistema, como:
      - `X_ID`: UUIDs relacionados ao conteúdo.
      - `path`: O caminho do arquivo ou documento.
      - `filename`: Nome do arquivo.
      - `isEnabled`: Indica se o resultado está atualmente ativo ou válido.
      - `tags_name`: Tags categorizando o conteúdo.
      - `database_name`: Nomes de bancos de dados relacionados.
- **Exemplo:**
  ```json
  "states": {
    "0": {
      "payload": {
        "metadata": {},
        "pageContent": "LIBERAÇÃO Cadastral..."
      },
      "system_metadata": {
        "X_ID": ["65bdf61a-bcaf-11ef-8362-67a57d644ab2"],
        "path": "/root/Passo_á_Passo_Imovel_Atualizado.md",
        "filename": "Passo_á_Passo_Imovel_Atualizado.md",
        "isEnabled": false,
        "tags_name": ["new", "general", "temp"],
        "database_name": ["redis"]
      }
    }
  }
  ```

---

#### **2. `refs`**
- **Tipo:** Objeto
- **Descrição:** Fornece um mapeamento índice-para-UUID para facilitar a referência e interpretação dos resultados.
- **Exemplo:**
  ```json
  "refs": {
    "65c073e0-bcaf-11ef-8362-836697a80014": 0,
    "65be218a-bcaf-11ef-8362-97215ca72835": 1
  }
  ```
- **Uso:** Cada UUID corresponde a um índice em `states`, permitindo que você localize resultados detalhados.

---

#### **3. `edges`**
- **Tipo:** Array
- **Descrição:** Representa conexões entre resultados (indexados em `refs`) e seus relacionamentos semânticos.
- **Estrutura:**
  - Cada aresta é representada como `[score, from, to]`:
    - **`score`**: Valor de similaridade semântica (quanto maior, mais próximo da correspondência).
    - **`from`**: Índice do nó de origem.
    - **`to`**: Índice do nó de destino.
- **Exemplo:**
  ```json
  "edges": [
    [0.07045968, 1, 0],
    [0.06461066, 2, 0]
  ]
  ```
- **Uso:** Usado para analisar relacionamentos entre resultados, particularmente ao agrupar ou explorar itens relacionados.

---

### **Exemplo de Resposta Completa**

```json
{
  "status": true,
  "message": "query: teste",
  "data": {
    "states": {
      "0": {
        "payload": {
          "metadata": {},
          "pageContent": "LIBERAÇÃO Cadastral..."
        },
        "system_metadata": {
          "X_ID": ["65bdf61a-bcaf-11ef-8362-67a57d644ab2"],
          "path": "/root/Passo_á_Passo_Imovel_Atualizado.md",
          "filename": "Passo_á_Passo_Imovel_Atualizado.md",
          "isEnabled": false,
          "tags_name": ["new", "general", "temp"],
          "database_name": ["redis"]
        }
      }
    },
    "refs": {
      "65c073e0-bcaf-11ef-8362-836697a80014": 0,
      "65be218a-bcaf-11ef-8362-97215ca72835": 1
    },
    "edges": [
      [0.07045968, 1, 0],
      [0.06461066, 2, 0]
    ]
  }
}
```

---

### **Resumo**

- **`states`**: Os resultados principais da pesquisa com informações detalhadas sobre cada resultado.
- **`refs`**: Um mapeamento entre UUIDs e seus índices em `states`.
- **`edges`**: Conexões semânticas entre resultados, definidas por pontuações de similaridade e índices.

---
## **Documentação da API para POST `/extensions/query`**

## **Endpoint**
**`POST /extensions/query`**

### **Autorização**
O endpoint requer um cabeçalho **Authorization** com um token Bearer válido. Exemplo:

```http
Authorization: Bearer {TOKEN}
```

## **Corpo da Requisição**
O corpo da requisição deve estar no formato JSON. As variáveis aceitas são as mesmas que em `POST /query` mas possui uma chave adicional no qual possibilita retornar um número máximo de resultados em formato de lista.


| **Variável**       | **Tipo**   | **Obrigatório** | **Padrão** | **Descrição**                                                                                   |
|---------------------|------------|-----------------|------------|---------------------------------------------------------------------------------------------------|
| `limit`            | `integer`  | Não             | `None`     | O número máximo de resultados a serem retornados, substituindo outros limites em `POST /query`.                   |

---

## **Exemplo de Requisição**

### **Cabeçalho da Requisição**
```http
POST http://localhost:8081/extensions/query 
Authorization: Bearer YOUR_TOKEN
Content-Type: application/json
```

### **Corpo da Requisição**
```json
{
    "query": "teste",
    "collection_name": "teste",
    "with_payload": true,
    "score_threshold": 0.5,
    "limit": 10,
    "query_filter": {
        "must": [
            { "key": "system_metadata.tags_name", "match": { "value": "contract" }}
        ]
    }
}
```

### **Resultado**

Quando o endpoint http://localhost:8081/extensions/query é chamado com sucesso, ele retorna uma resposta JSON estruturada. Este documento fornece uma explicação detalhada dos campos de resposta e sua importância.

---

### **Estrutura da Resposta**

```json
{
  "status": true,
  "message": "query: <pergunta da consulta>",
  "data": [
    {
      "id": "UUID",
      "payload": {...},
      "score": 0.67
    },
    ...
  ]
}
```

---

### **Campos de Nível Superior**

| **Campo**    | **Tipo**   | **Descrição**                                                                                           |
|--------------|------------|-----------------------------------------------------------------------------------------------------------|
| `status`     | `boolean`  | Indica se a consulta foi processada com sucesso.                                                        |
| `message`    | `string`   | Fornece contexto ou feedback sobre a operação de consulta, geralmente ecoando a consulta ou descrevendo erros. |
| `data`       | `array`    | Contém os resultados principais da consulta semântica, incluindo `id`, `payload` e `score`.           |

---

### **Exemplo de Resposta Completa**

```json
{
  "status": true,
  "message": "query: teste",
  "data": [
    {
      "id": "UUID",
      "payload": {
        "metadata": {},
        "pageContent": "LIBERAÇÃO Cadastral..."
      },
      "score": 0.67
    },
    ...
  ]
}
```

---

### **Resumo**

- **`status`**: Indica o sucesso da consulta.
- **`message`**: Fornece feedback sobre a consulta.
- **`data`**: Contém os resultados da consulta, incluindo `id`, `payload` e `score`.

---

# Filtros de Consulta

Os recursos de filtragem disponíveis podem ser aplicados tanto a `system_metadata` quanto a `metadata`.

- **`system_metadata`**: São variáveis padrão, predefinidas, fornecidas pelo VectorHub, oferecendo atributos padronizados para filtragem.
- **`metadata`**: São variáveis personalizadas especificadas pelo usuário, permitindo critérios de filtragem personalizados com base em dados definidos pelo usuário dentro do VectorHub.

### **Campos Disponíveis em `system_metadata`**

| **Campo**           | **Tipo**    | **Descrição**                                                                            | **Exemplo**                                 |
|----------------------|------------|--------------------------------------------------------------------------------------------|---------------------------------------------|
| `X_ID`              | `array`    | Lista de UUIDs associados ao resultado.                                                  | `["65bdf61a-bcaf-11ef-8362-67a57d644ab2"]` |
| `path`              | `string`   | Caminho do arquivo ou documento onde o resultado está armazenado.                          | `"/root/Passo_á_Passo_Imovel_Atualizado.md"` |
| `filename`          | `string`   | Nome do arquivo contendo o resultado.                                                   | `"Passo_á_Passo_Imovel_Atualizado.md"`      |
| `isEnabled`         | `boolean`  | Indica se o resultado está ativo ou válido.                                                | `false`                                     |
| `tags_name`         | `array`    | Lista de tags categorizando o conteúdo.                                                     | `["new", "general", "temp"]`                |
| `dashboard_on`      | `array`    | Informações sobre dashboards associados.                                                  | `[]`                                        |
| `database_name`     | `array`    | Lista de bancos de dados associados ao conteúdo.                                            | `["redis"]`                                 |

---

### **Exemplos de Filtros**

Para mais detalhes sobre como usar filtros, consulte [https://qdrant.tech/documentation/concepts/filtering/](https://qdrant.tech/documentation/concepts/filtering/)

Aqui estão exemplos de filtros no estilo Qdrant baseados em campos `system_metadata`:

#### **Filtrar por Tag**
Para filtrar resultados com uma tag específica:
```json
{
    "query_filter": {
        "must": [
            { "key": "system_metadata.tags_name", "match": { "value": "contract" }}
        ]
    }
}
```

#### **Filtrar por Caminho**
Para filtrar resultados de um caminho de arquivo específico:
```json
{
    "query_filter": {
        "must": [
            { "key": "system_metadata.path", "match": { "value": "/root/Passo_á_Passo_Imovel_Atualizado.md" }}
        ]
    }
}
```

### **Combinando Filtros**

Para combinar múltiplas condições, use as cláusulas `must`, `should` ou `must_not`:

```json
{
    "query_filter": {
        "must": [
            { "key": "system_metadata.tags_name", "match": { "value": "contract" }},
            { "key": "system_metadata.isEnabled", "match": { "value": true }}
        ],
        "must_not": [
            { "key": "system_metadata.database_name", "match": { "value": "redis" }}
        ]
    }
}
```

---


# **Documentação Simplificada da API**

## **1. Inserindo Dados na API** (`/insert`)

A API `/insert` é utilizada para enviar *chunks* de texto para armazenamento, vinculando pais e filhos através do campo `X_ID`.

### **Estrutura do Payload**

- `qdrant_payloads`: Lista de *child chunks* (filhos) contendo `X_ID`, que referencia o ID do *parent chunk* correspondente.
- `redis_payloads`: Lista de *parent chunks* (pais) armazenados no banco de dados.

### **Exemplo de Requisição**

```python
import requests
import json

token = "SEU_TOKEN"
url = "http://localhost:8081/insert"
headers = {"Authorization": f"Bearer {token}"}

# Exemplo de dados a serem enviados
payload = {
    "filename": "exemplo.md",
    "description": "",
    "fileType": "general",
    "path": "",
    "collection_name": "ExemploCollection",
}

data = {
    "qdrant_payloads": [
        {
            "id": "child-uuid-123",
            "payload": {
                "metadata": {},
                "pageContent": "Conteúdo do chunk filho",
                "X_ID": "parent-uuid-456"
            }
        }
    ],
    "redis_payloads": [
        {
            "id": "parent-uuid-456",
            "payload": "Conteúdo do chunk pai"
        }
    ]
}

files = {"file": json.dumps(data, ensure_ascii=False, indent=0)}

response = requests.post(url, data=payload, files=files, headers=headers)
print(response.json())
```

### **Explicação**
- `X_ID` dentro de `qdrant_payloads` cria uma ligação entre os chunks filhos e seus respectivos pais.
- Cada *chunk* pai possui um `id` único e seu texto armazenado no Redis.
- Os *chunks* filhos possuem o `X_ID` referenciando um pai e estão armazenados no Qdrant.

---

## **2. Consultando Dados na API** (`/query`)

A API `/query` permite buscar informações na base, retornando chunks de texto relevantes com ligação entre pais e filhos através de `X_ID` e `edges`.

### **Estrutura do Payload**

- `collection_name`: Nome da coleção de dados.
- `query`: Texto da pesquisa.
- `limit_w_XID`: Número máximo de *chunks* filhos a serem retornados.
- `limit_w_hits`: Número máximo de relações (*edges*) retornadas.
- `with_payload`: Campos adicionais a serem incluídos na resposta.
- `query_filter`: Filtros para restringir os resultados.

### **Exemplo de Requisição**

```python
url = "http://localhost:8081/query"
headers = {"Authorization": f"Bearer {token}"}

query_payload = {
    "collection_name": "ExemploCollection",
    "query": "O que é um chunk?",
    "limit_w_XID": 2,
    "limit_w_hits": 4,
    "return_hits": False,
    "with_payload": ["pageContent"],
    "query_filter": {
        "must": [
            {"key": "system_metadata.tags_name", "match": {"value": "general"}}
        ]
    }
}

response = requests.post(url, json=query_payload, headers=headers)
print(response.json())
```

### **Exemplo de Resposta**

```json
{
  "status": true,
  "message": "query: teste",
  "data": {
    "states": {
      "0": {
        "payload": {
          "metadata": {},
          "pageContent": "Texto do chunk encontrado"
        },
        "system_metadata": {
          "X_ID": ["parent-uuid-456"],
          "path": "caminho/do/arquivo.md",
          "filename": "arquivo.md",
          "isEnabled": false,
          "tags_name": ["general"],
          "database_name": ["redis"]
        }
      }
    },
    "refs": {
      "uuid-ref-1": 0,
      "uuid-ref-2": 1
    },
    "edges": [
      [0.07, 1, 0],
      [0.06, 2, 0]
    ]
  }
}
```

### **Explicação dos Campos**
- **`X_ID`**: Indica que o chunk retornado está relacionado a um pai (se houver).
- **`edges`**: Representa a conexão entre chunks filhos (*from*) e chunks pais (*to*), baseada em similaridade semântica.
  - **`score`**: Quanto maior, mais similar o filho é ao pai.
  - **`from`**: Index do chunk filho.
  - **`to`**: Index do chunk pai.

Exemplo:
```json
"edges": [
  [0.07, 1, 0],
  [0.06, 2, 0]
]
```
Aqui, o chunk com index `1` (é um filho) está vinculado ao chunk com index `0` (pai), com similaridade `0.07`.

---

## **Conclusão**
- Para **inserir** dados, use `/insert` com *chunks* pais no Redis e *chunks* filhos no Qdrant, ligando-os por `X_ID`.
- Para **buscar** dados, use `/query`, onde os *chunks* relacionados serão retornados com `X_ID` e suas conexões podem ser analisadas pelos `edges`.

Isso permite recuperar informações contextualizadas e estruturadas, garantindo uma busca eficiente e organizada.

## **Exemplo 2** (`/query`)

### **Exemplo de Requisição utilizando cURL**

```sh
curl -X POST "http://localhost:8081/query" \
     -H "Authorization: Bearer SEU_TOKEN" \
     -H "Content-Type: application/json" \
     -d '{
        "collection_name": "ExemploCollection",
        "query": "O que é um chunk?",
        "limit_wo_XID": 2,
        "limit_w_XID": 2,
        "with_payload": ["pageContent"]
     }'
```

### **Como acessar os `pageContent`**

O resultado da consulta retorna um dicionário JSON dentro da chave `data`. Os *chunks* estão dentro da chave `states`. Para extrair todos os textos de `pageContent`, basta iterar sobre os valores de `states`.

#### **Exemplo de Extração em Python**

```python
import requests
import json

token = "SEU_TOKEN"
url = "http://localhost:8081/query"
headers = {"Authorization": f"Bearer {token}"}

query_payload = {
    "collection_name": "ExemploCollection",
    "query": "O que é um chunk?",
    "limit_wo_XID": 2,
    "limit_w_XID": 2,
    "with_payload": ["pageContent"]
}

response = requests.post(url, json=query_payload, headers=headers)
data = response.json()

# Extraindo todos os conteúdos de pageContent
todos_os_textos = [item["payload"]["pageContent"] for item in data["data"]["states"].values()]

print(todos_os_textos)
```

### **Conclusão**
- Para **inserir** dados, use `/insert` com *chunks* pais no Redis e *chunks* filhos no Qdrant, ligando-os por `X_ID`.
- Para **buscar** dados, use `/query`, especificando `limit_wo_XID` e `limit_w_XID` para controlar a busca por pais e filhos.
- Utilize `with_payload: ["pageContent"]` para retornar apenas os textos dos *chunks*, sem metadados.
- Os textos podem ser extraídos iterando sobre `data["states"]` no JSON retornado.