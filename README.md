# VectorHub Client Setup Guide

This guide provides instructions to set up and run the `VectorHub` Docker Compose environment using the provided `vectorhub.tar` image file after cloning the repository.

## Prerequisites

- **Docker**: Ensure Docker is installed on your system. [Docker Installation Guide](https://docs.docker.com/get-docker/).
- **Docker Compose**: Make sure Docker Compose is installed. It usually comes bundled with Docker, but you can verify or install it using this [Docker Compose Installation Guide](https://docs.docker.com/compose/install/).
- **Git**: Make sure Git is installed to clone the repository. If not, install it from [Git Installation](https://git-scm.com/downloads).

## Installation Steps

1. **Clone the Repository**

   Clone the VectorHub Client repository to your local machine:
   ```bash
   git clone https://github.com/otimizai-tech/Vectorhub-client.git
   cd Vectorhub-client
   ```

2. **Download the Docker Image**

   Download the `vectorhub.tar` file from the latest GitHub release:
   [Download vectorhub.tar](https://github.com/otimizai-tech/Vectorhub-client/releases/download/v0.2.4/vectorhub.tar)

   Alternatively, you can use the command line to download the file directly:
   ```bash
   wget https://github.com/otimizai-tech/Vectorhub-client/releases/download/v0.2.4/vectorhub.tar
   ```

3. **Load the Docker Image**

   Once the `vectorhub.tar` file is downloaded, load it into Docker using the following command:
   ```bash
   docker load -i vectorhub.tar
   ```

   This command imports the `otimizai/vectorhub-client:latest` image into your Docker environment.

4. **Verify the Image**

   Confirm that the image has been successfully loaded by listing your Docker images:
   ```bash
   docker images
   ```

   You should see an image named `otimizai/vectorhub-client` with the `latest` tag in the list.

5. **Run the Docker Compose Setup**

   Start the complete application stack using Docker Compose with the following command:
   ```bash
   docker-compose up -d
   ```

   This command will launch all the services defined in your `docker-compose.yml` file, including Redis, EdgeDB, Qdrant, and the VectorHub API.

6. **Access the Application**

   Once the services are up and running, you can access the VectorHub application at:
   ```
   http://localhost:8081
   ```

   or at the port specified in your `.env` file.

## Stopping the Services

To stop all running services, use the following command:
```bash
docker-compose down
```

This command will gracefully stop and remove all containers defined in your Docker Compose setup.

## Troubleshooting

- **Port Conflicts**: If you encounter port conflicts, make sure that the ports specified in your `.env` file are not being used by other services on your machine.
- **Image Not Found**: If Docker Compose fails to find the image, ensure that you have successfully downloaded and loaded the `vectorhub.tar` file as described in Steps 2 and 3.



---

# **API Documentation for POST /query**


## **Endpoint**
**`POST /query`**

### **Authorization**
The endpoint requires an **Authorization** header with a valid Bearer token. Example:

```http
Authorization: Bearer {TOKEN}
```


## **Request Body**
The request body should be in JSON format. Below are the variables accepted:

### **Variables**

| **Variable**       | **Type**   | **Required** | **Default** | **Description**                                                                                   |
|---------------------|------------|--------------|-------------|---------------------------------------------------------------------------------------------------|
| `query`            | `string`   | Yes          | `None`      | The search query string used to perform the main operation.                                      |
| `collection_name`  | `string`   | Yes          | `None`      | The name of the collection to query from.                                                       |
| `with_payload`     | `boolean`  | No           | `True`      | Determines if the response should include additional payloads associated with the query results. |
| `score_threshold`  | `float`    | No           | `None`      | The minimum score a result must achieve to be included in the response.                         |
| `limit_wo_XID`     | `integer`  | No           | `1`         | The maximum number of results to return when the `X_ID` attribute is not present in the query.  |
| `limit_w_XID`      | `integer`  | No           | `1`         | The maximum number of results to return when the `X_ID` attribute is present in the query.      |
| `limit_w_hits`     | `integer`  | No           | `10`        | The maximum number of results to return when the query matches items based on hits.             |
| `query_filter`     | `object`   | No           | `None`      | Additional filtering criteria applied to the query to refine the results.                       |

---




## **Example Request**

### **Request Header**
```http
POST {endpoint}/query 
Authorization: Bearer YOUR_TOKEN
Content-Type: application/json
```


### **Request Body**
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


### **Result**

When the `/query` endpoint is called successfully, it returns a structured JSON response. This document provides a detailed explanation of the response fields and their significance.

---

### **Response Structure**

```json
{
  "status": true,
  "message": "query: teste",
  "data": {
    "states": { ... },
    "refs": { ... },
    "edges": [ ... ]
  }
}
```

---

### **Top-Level Fields**

| **Field**    | **Type**   | **Description**                                                                                           |
|--------------|------------|-----------------------------------------------------------------------------------------------------------|
| `status`     | `boolean`  | Indicates whether the query was processed successfully.                                                   |
| `message`    | `string`   | Provides context or feedback about the query operation, typically echoing the query or describing errors. |
| `data`       | `object`   | Contains the core results of the semantic query, including `states`, `refs`, and `edges`.                |

---

### **Detailed Explanation of `data`**

#### **1. `states`**
- **Type:** Object
- **Description:** Contains the actual results of the semantic search.
- **Structure:** 
  - Each key in `states` represents an index (based on `refs`).
  - Each index contains:
    - **`payload`**: Includes `metadata` and `pageContent`—the retrieved text or associated content.
    - **`system_metadata`**: Additional details about the file or system context, such as:
      - `X_ID`: UUIDs related to the content.
      - `path`: The file or document path.
      - `filename`: Name of the file.
      - `isEnabled`: Indicates if the result is currently active or valid.
      - `tags_name`: Tags categorizing the content.
      - `database_name`: Related database names.
- **Example:**
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
- **Type:** Object
- **Description:** Provides an index-to-UUID mapping for easier reference and interpretation of results.
- **Example:**
  ```json
  "refs": {
    "65c073e0-bcaf-11ef-8362-836697a80014": 0,
    "65be218a-bcaf-11ef-8362-97215ca72835": 1
  }
  ```
- **Usage:** Each UUID corresponds to an index in `states`, allowing you to locate detailed results.

---

#### **3. `edges`**
- **Type:** Array
- **Description:** Represents connections between results (as indexed in `refs`) and their semantic relationships.
- **Structure:**
  - Each edge is represented as `[score, from, to]`:
    - **`score`**: Semantic similarity value (higher indicates closer match).
    - **`from`**: Index of the source node.
    - **`to`**: Index of the target node.
- **Example:**
  ```json
  "edges": [
    [0.07045968, 1, 0],
    [0.06461066, 2, 0]
  ]
  ```
- **Usage:** Used to analyze relationships between results, particularly when clustering or exploring related items.

---

### **Example of Full Response**

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

### **Summary**

- **`states`**: The primary search results with detailed information about each result.
- **`refs`**: A mapping between UUIDs and their indices in `states`.
- **`edges`**: Semantic connections between results, defined by similarity scores and indices.




---


## Filter 

The available filtering features can be applied to both `system_metadata` and `metadata`. 

- **`system_metadata`**: These are default, predefined variables provided by VectorHub, offering standardized attributes for filtering.  
- **`metadata`**: These are custom variables specified by the user, allowing for tailored filtering criteria based on user-defined data within VectorHub. 



### **Available Fields in `system_metadata`**



| **Field**           | **Type**    | **Description**                                                                            | **Example**                                 |
|----------------------|------------|--------------------------------------------------------------------------------------------|---------------------------------------------|
| `X_ID`              | `array`    | List of UUIDs associated with the result.                                                  | `["65bdf61a-bcaf-11ef-8362-67a57d644ab2"]` |
| `path`              | `string`   | File or document path where the result is stored.                                          | `"/root/Passo_á_Passo_Imovel_Atualizado.md"` |
| `filename`          | `string`   | Name of the file containing the result.                                                   | `"Passo_á_Passo_Imovel_Atualizado.md"`      |
| `isEnabled`         | `boolean`  | Indicates if the result is active or valid.                                                | `false`                                     |
| `tags_name`         | `array`    | List of tags categorizing the content.                                                     | `["new", "general", "temp"]`                |
| `dashboard_on`      | `array`    | Information about associated dashboards.                                                  | `[]`                                        |
| `database_name`     | `array`    | List of databases associated with the content.                                            | `["redis"]`                                 |

---

### **Example Filters**


For more datails how to use filter see https://qdrant.tech/documentation/concepts/filtering/


Here are examples of Qdrant-style filters based on `system_metadata` fields:

#### **Filter by Tag**
To filter results with a specific tag:
```json
{
    "query_filter": {
        "must": [
            { "key": "system_metadata.tags_name", "match": { "value": "contract" }}
        ]
    }
}
```

#### **Filter by Path**
To filter results from a specific file path:
```json
{
    "query_filter": {
        "must": [
            { "key": "system_metadata.path", "match": { "value": "/root/Passo_á_Passo_Imovel_Atualizado.md" }}
        ]
    }
}
```



### **Combining Filters**

To combine multiple conditions, use `must`, `should`, or `must_not` clauses:

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

# (BR) Aplicação

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

xxxxx


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

