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
   [Download vectorhub.tar](https://github.com/otimizai-tech/Vectorhub-client/releases/download/v0.2/vectorhub.tar)

   Alternatively, you can use the command line to download the file directly:
   ```bash
   wget https://github.com/otimizai-tech/Vectorhub-client/releases/download/v0.2.1/vectorhub.tar
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

# API

**POST** `/<path>`

Use `Authorization: Bearer <TOKEN>`, where the token is generated in the application interface at `http://<appendpoint>/admin`. For security reasons, you must set a unique password in your `.env` file before accessing this endpoint.

### Important Note:
- **Ensure that you **change the default admin password** in the `.env` file before using `docker compose up`, use this feature to avoid unauthorized access. **

To generate the token:
1. Go to `http://<appendpoint>/admin`.
2. Use the admin password specified in your `.env` file.
3. Generate the token to use with your API requests.

---

# `get_chunks` API Documentation

## Overview

The `get_chunks` API is used to retrieve chunks of data based on the given parameters. It is intended to filter and query specific pieces of content from the database using various filters and query options.

## Endpoint

**POST** `/chat`
use Authorization: Bearer <TOKEN>, where the token generated is generated in the application http://<appendpoint>/admin - pass the password admin, and generate the token

### Request Payload

The request payload should be in JSON format and contain the function name (`fun`) and a `data` object with the relevant parameters.

```json
{
  "fun": "get_chunks",
  "data": {
    "main_content": "<string>",
    "query_user": "<string>",
    "collection_name": "<string>",
    "filter": [
      ["metadata.tags", "value"]
    ],
    "limit": <int>,
    "with_payload": <bool>,
    "return_adj": <bool>,
    "return_id": <bool>,
    "return_Xid": <bool>,
    "join_id_Xid_null": <bool>,
    "return_metadata_Xid": <bool>
  }
}
```

### Parameters

| Parameter             | Type                    | Required | Default | Description                                                                                                                                                                                                                                                                    |
| --------------------- | ----------------------- | -------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `main_content`        | `string`                | Yes      | -       | The main content to retrieve the chunks from.                                                                                                                                                                                                                                  |
| `query_user`          | `string`                | Yes      | -       | The user's query used to determine the chunk.                                                                                                                                                                                                                                  |
| `collection_name`     | `string`                | No       | ""      | The name of the collection to query from.                                                                                                                                                                                                                                      |
| `filter`              | `list[tuple(str, str)]` | No       | `None`  | A list of filters to apply to the payload, e.g., `[ ("metadata.tags", "value") ]`.                                                                                                                                                                                             |
| `limit`               | `int`                   | No       | `4`     | The maximum number of chunks to return.                                                                                                                                                                                                                                        |
| `with_payload`        | `bool`                  | No       | `True`  | Whether to include payload data in the response.                                                                                                                                                                                                                               |
| `return_adj`          | `bool`                  | No       | `False` | Whether to return adjacent content. If there is a connection, this will contain the UUID of each connection along with the score. If there is no connection, only the `id` with `False` for `Xid` will be returned in the list of results.                                     |
| `return_id`           | `bool`                  | No       | `False` | Whether to return the unique identifier of the chunk.                                                                                                                                                                                                                          |
| `return_Xid`          | `bool`                  | No       | `False` | Whether to return the Xid associated with the chunk.                                                                                                                                                                                                                           |
| `join_id_Xid_null`    | `bool`                  | No       | `True`  | Whether to return all entries in the `Xid` dictionary if `adj` has `False` for the associated `Xid`. This means that when there is no valid connection (`Xid` is `False`), the corresponding entries from `id` and `Xid` are joined to provide more comprehensive information. |
| `return_metadata_Xid` | `bool`                  | No       | `False` | Whether to return metadata related to Xid.                                                                                                                                                                                                                                     |

### Example Request

Here is an example of how to make a POST request to the `get_chunks` API using HTTPX:

```json
curl -X POST http://0.0.0.0:8081/chat \
-H "Content-Type: application/json" \
-d '{
  "fun": "get_chunks",
  "data": {
    "main_content": "pageContent",
    "query_user": "quais os tipos de consorcio ?",
    "collection_name": "teste",
    "filter": [
      ["system_metadata.tags_name", ["FAQ"]],
      ["system_metadata.tags_name", ["new"]]
      ],
    "limit": 1,
    "with_payload": ["pageContent"],
    "return_adj": true,
    "return_id": true,
    "return_Xid": true,
    "return_metadata_Xid": true,
    "join_id_Xid_null": true
  }
}'
```

### Example Response

The response will contain the chunks of data retrieved based on the parameters provided.

```json
{
  "status": true,
  "message": "query: quais os tipos de consorcio ?",
  "data": [
    {
      "adj": [
        {
          "score": 0.7682048,
          "id/XiD": [
            "a55970be-8745-11ef-ae83-af3dcb07e505",
            false
          ]
        }
      ],
      "id": {
        "a55970be-8745-11ef-ae83-af3dcb07e505": {
          "pageContent": "5.  Quais são os tipos de consórcio disponíveis?\n\n  consórcio de bens móveis, consórcio de imóveis e serviços. ",
          "system_metadata": {
            "X_ID": []
          }
        }
      },
      "Xid": {
        "a55970be-8745-11ef-ae83-af3dcb07e505": {
          "pageContent": "5.  Quais são os tipos de consórcio disponíveis?\n\n  consórcio de bens móveis, consórcio de imóveis e serviços. ",
          "system_metadata": {
            "X_ID": []
          }
        }
      }
    }
  ]
}
```

### Response Schema

Below is a schema of the response to help understand its structure:

- `status` (boolean): Indicates whether the request was successfully processed.
- `message` (string): Provides additional context about the query performed.
- `data` (list of objects): Contains the chunks and their relevant metadata.
  - Each object in `data`:
    - `adj` (list of objects): Represents adjacent content.
      - Each object in `adj`:
        - `score` (float): The score associated with the adjacent connection.
        - `id/XiD` (list): A list containing the ID and a boolean indicating if `Xid` is present. If `Xid` is `False`, only the ID is returned.
    - `id` (object): Represents the main identifier (may be empty if no valid connection).
    - `Xid` (object): Contains the detailed information related to `Xid`.
      - Each key in `Xid` is an ID (UUID), with the value being an object containing:
        - `pageContent` (string): The content of the page.
        - `system_metadata` (object): Metadata related to the content.
          - `X_ID` (list): A list of additional metadata identifiers.
          - `as_X_ID` (list): A list of associated X\_IDs.
          - `dashboard_on` (list): Dashboard information.
          - `database_name` (list): Names of associated databases.
          - `filename` (string): The filename of the content.
          - `isEnabled` (boolean): Whether the content is isEnabled.
          - `path` (string): The path to the content.
          - `tags_name` (list of strings): Tags associated with the content.
        - `metadata` (object): Contains the metadata provided by the user.

### Notes

- The `filter` parameter accepts a list of tuples to filter results based on metadata tags or other properties.
- Depending on the boolean flags (`with_payload`, `return_adj`, etc.), different data will be included in the response.
- The `status` field in the response indicates whether the request was successfully processed.
- The `message` field provides additional context about the query performed.
- The `data` field contains the chunks and their relevant metadata, including `adj` (adjacent content), `id/XiD` pairs, and detailed content with metadata.



----


# `insert_chunks` API Documentation

## Overview

The `insert_chunks` API is used to insert chunks of data into a specified collection. The data is divided into multiple payloads, which can be stored in different storage services (e.g., Qdrant, Redis). This API allows adding content to a collection along with system metadata.

## Endpoint

**POST** `/chat`

### Request Payload

The request payload should be in JSON format and contain the function name (`fun`) and a `data` object with the relevant parameters.

```json
{
  "fun": "insert_chunks",
  "data": {
    "chunks": [
      {
        "qdrant_payloads": [
          {
            "id": "<string>",
            "payload": {
              "X_ID: [<string>],
              "metadata": {<object>},
              "pageContent": "<string>"
            }
          }
        ],
        "redis_payloads": [
          {
            "id": "<string>",
            "payload": "<string>"
          }
        ]
      }
    ],
    "collection_id": "<string>",
    "system_metadata": {
      "isEnabled": <bool>,
      "tags": [<string>]
    }
  }
}
```

### Parameters

| Parameter         | Type           | Required | Description                                                                                                       |
| ----------------- | -------------- | -------- | ----------------------------------------------------------------------------------------------------------------- |
| `chunks`          | `list[object]` | Yes      | A list of chunks to be inserted. Each chunk contains payloads for different storage services, including metadata. |
| `collection_id`   | `string`       | Yes      | The ID of the collection where the chunks should be inserted.                                                     |
| `system_metadata` | `object`       | No       | Metadata about the insertion, including tags and status.                                                          |

#### Chunk Schema

- Each item in `chunks` contains:
  - `qdrant_payloads` (list of objects): Payloads specific to Qdrant storage.
    - `id` (string): The unique identifier for the payload.
    - `payload` (object):
      - `X_ID` (string): A unique identifier for metadata linkage.
      - `metadata` (object): Contains additional metadata.
      - `pageContent` (string): The content to be inserted.
  - `redis_payloads` (list of objects): Payloads specific to Redis storage as X_ID.
    - `id` (string): The unique identifier for the payload.
    - `payload` (string): The content to be inserted.

#### System Metadata Schema

- **`system_metadata`** object contains metadata attributes related to the management and classification of chunks being inserted into databases like Qdrant and Redis. Each field serves a specific role in organizing and controlling the data:

  - **`X_ID`** (`list of strings`): Represents a list of unique identifiers associated with the chunks or data entries.
  - **`as_X_ID`** (`list of strings`): Contains alternate or alias identifiers related to the `X_ID`.
  - **`dashboard_on`** (`list of strings`): Indicates the dashboards or views where these data entries are actively displayed or monitored.
  - **`database_name`** (`list of strings`): Names of the databases where the chunks are stored or referenced.
  - **`filename`** (`string`): The name of the file associated with the data entry or chunk.
  - **`isEnabled`** (`boolean`): A flag indicating if the system is enabled for handling the specific chunks being inserted into the databases.
  - **`path`** (`string`): The file path or directory location relevant to the chunk or data entry.
  - **`tags_name`** (`list of strings`): Tags used to classify and categorize the inserted chunks for easier organization and retrieval.


```json
{
    "system_metadata": {
        "X_ID": [<string>],
        "as_X_ID": [<string>],
        "dashboard_on": [<string>],
        "database_name": [<string>],
        "filename": <string>,
        "isEnabled": <bool>,
        "path": <string>,
        "tags_name": [<string>],
    }
}
```


### Example Request

Here is an example of how to make a POST request to the `insert_chunks` API using cURL:

```json
curl -X POST http://0.0.0.0:8081/chat \
-H "Content-Type: application/json" \
-d '{
  "fun": "insert_chunks",
  "data": {
    "chunks": [
      {
        "qdrant_payloads": [
          {
            "id": "dca46ca0-ab49-4b35-9653-dd8813e5b7f6",
            "payload": {
              "X_ID": "c65bf39d-d5ee-4672-abf8-2a807f5fb90d",
              "metadata": {},
              "pageContent": "# CONSTRUÇÃO\n## Posso usar meu FGTS para comprar um imóvel. Como funciona?\n### Processo de Utilização do FGTS:\n#### Análise e Liberação:\n\nApós a análise e verificação de que todos os requisitos foram atendidos, faremos a liberação do FGTS junto à Caixa Econômica Federal. A liberação será efetuada após a assinatura do cliente nos Termos Específicos."
            }
          }
        ],
        "redis_payloads": [
          {
            "id": "c65bf39d-d5ee-4672-abf8-2a807f5fb90d",
            "payload": "# CONSTRUÇÃO\n## Posso usar meu FGTS para comprar um imóvel. Como funciona?\n### Processo de Utilização do FGTS:\n#### Análise e Liberação:\n\nApós a análise e verificação de que todos os requisitos foram atendidos, faremos a liberação do FGTS junto à Caixa Econômica Federal. A liberação será efetuada após a assinatura do cliente nos Termos Específicos."
          }
        ]
      }
    ],
    "collection_id": "82544898-859a-11ef-b6f9-dffb34b23632",
    "system_metadata": {"isEnabled": false, "tags": ["api"]}
  }
}'
```

### Notes

- The `chunks` parameter is a list that contains data structured for different storage types (`qdrant_payloads` and `redis_payloads`).
- The `system_metadata` allows for tagging and controlling the status of the inserted chunks with the same schema of `Response Schema get_chunks`.

