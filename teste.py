
import re
from pathlib import Path


import orjson
import requests
from uuid import uuid4


# Caminhos dos arquivos

# Função para ler e processar os arquivos
def process_file(file_path):
    if not file_path.exists():
        print(f"Arquivo não encontrado: {file_path}")
        return []

    with file_path.open("r", encoding="utf-8") as file:
        content = file.read()

    # Separar os trechos pelo delimitador
    chunks = [
        chunk.strip()
        for chunk in content.split("=========================")
        if chunk.strip()
    ]

    return chunks


# Processar os arquivos
parent_file = Path(
    "/home/zuz/Projetos/Otimizai/works/servopa/ParentChunks.txt"
)
children_file = Path(
    "/home/zuz/Projetos/Otimizai/works/servopa/ChildrenChunks.txt"
)

parent_chunks = process_file(parent_file)
children_chunks = process_file(children_file)


parents = list(zip([str(uuid4()) for _ in range(len(parent_chunks))], parent_chunks))

childrens = list(
    zip([str(uuid4()) for _ in range(len(parent_chunks))], children_chunks)
)


# Criar dicionário para armazenar pais e filhos
children_list = []
parent_list = []



for child in childrens:
    id_c, text_c = child

    for p in parents:
        id_p, text_p = p

        if text_c in text_p:
            children_list.append(
                {
                    "id": id_c,
                    "payload": {
                        "metadata": {},
                        "pageContent": text_c,
                        "X_ID": id_p,
                    },
                }
            )


parent_list = [{"id": id, "payload": text} for id, text in parents]


children_list
parent_list[0:2]


text = Path("/home/zuz/Projetos/Otimizai/works/servopa/docVicNovo250113.md")

text = process_file(text)


# text[0]


# proc = GerenalAddons()

# chunks = proc.pipe(
#     text[0],
#     chunk_size_tokens=1000,
#     chunk_overlap_tokens=50,
# )




# chunks.get("qdrant_payloads")[0:1]
# children_list[0:1]

# chunks.get("redis_payloads")[0:1]
# parent_list[0:1]


data = {"qdrant_payloads": children_list, "redis_payloads": parent_list}


data.get("qdrant_payloads")[0]

# "system_metadata": {},

chunk = {
    "metadata": {"tags_name": ["projeto1"]},
    "pageContent": "",
    "X_ID": ""
}



import json

# Rodar apenas 1 vez
url = "http://localhost:8081/insert"
files = {"file": json.dumps(data, ensure_ascii=False, indent=0)}
token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2dpbiI6dHJ1ZSwiZXhwIjoxNzUzNDg3ODc5fQ.aiC7u5I5T9kjMGkbswsa9Hzchk1xegqxx9RGssngb3g"

headers = {"Authorization": f"Bearer {token}"}
payload = {
    "filename": "docVicNovo250113.md",
    "description": "",
    "fileType": "general",
    "path": "",
    "collection_name": "Servopa",
    # 'collection_id': "5e53f442-ed74-11ef-ba33-838595bbdd87"
}

import requests
from uuid import uuid4 as uuid

# Enviar requisição POST autenticada
response = requests.post(url, data=payload, files=files, headers=headers)


response.content
print(response.json())  # Exibe a resposta da API


url = "http://localhost:8081/query"


response = requests.post(
    url,
    json={
        "collection_name": "Servopa",
        "query": "por que confiar na victorIA?",

        "limit_w_XID": 10, # menor igual 2
        "limit_wo_XID": 10, # menor igual 2  ()

        "limit_w_hits": 2, # range para achar, childs (colocar igual a soma 4)
        # "score_threshold": 0.5,
        "return_hits": True,
        "with_payload": ["pageContent"],
        # "query_filter": {
        #     "must": [
        #         {"key": "system_metadata.tags_name", "match": {"value": "teste"}}
        #     ]
        # },
    },
    headers=headers,
)


response.content.decode()

data = response.json()


from JsonFlow import query_path

from pprint import pprint

data.get("data").get("states").get("0").get("payload")


query_path(list(data.get("data").get("states").values()), "payload/pageContent")
