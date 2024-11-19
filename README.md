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
   [Download vectorhub.tar](https://github.com/otimizai-tech/Vectorhub-client/releases/download/v0.2.3/vectorhub.tar)

   Alternatively, you can use the command line to download the file directly:
   ```bash
   wget https://github.com/otimizai-tech/Vectorhub-client/releases/download/v0.2.3/vectorhub.tar
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

## Updated Workflow for Data Management with Qdrant

## Querying Data with Qdrant

### **Group Search by X_ID**
To perform searches that group results by `system_metadata.X_ID`, you can use the group query endpoint.

#### Request:
**Endpoint:**
```bash
POST http://localhost:6333/collections/chunks/points/query/groups (using qdrant api)
POST http://localhost:8081/qdrant?path=collections/chunks/points/query/groups (or using vectorhub proxy api)
```

**Example Payload:**
```json
{
  "query": [0.11, 0.22, 0.33],
  "group_by": "system_metadata.X_ID",
  "limit": 3,
  "group_size": 2,
  "with_lookup": {
    "collection": "X_ID",
    "with_payload": ["title", "text"],
    "with_vectors": false
  }
}
```
### **Key Parameters**
- **`query`**: The vector used for the search.
- **`group_by`**: Field used for grouping results (e.g., `system_metadata.X_ID`).
- **`limit`**: Number of groups to return.
- **`group_size`**: Number of points in each group.
- **`with_lookup`**: Specifies additional data to retrieve (e.g., payload or vectors).


**Example Response:**
```
{
    "result": {
        "groups": [
            {
                "id": 1,
                "hits": [
                    { "id": 0, "score": 0.91 },
                    { "id": 1, "score": 0.85 }
                ],
                "lookup": {
                    "id": 1,
                    "payload": {
                        "title": "Document A",
                        "text": "This is document A"
                    }
                }
            },
            {
                "id": 2,
                "hits": [
                    { "id": 1, "score": 0.85 }
                ],
                "lookup": {
                    "id": 2,
                    "payload": {
                        "title": "Document B",
                        "text": "This is document B"
                    }
                }
            }
        ]
    },
    "status": "ok",
    "time": 0.001
}
```
### **Key Parameters**
- **`lookup`**: The data inside the collection X_ID
- **`groups`**: Groups based in the unique id in X_ID.
- **`hits`**: id fo the vector and the respective score based in the query vector.


---


## Next Steps
- **Insert Data/ sync with vectorhub**

