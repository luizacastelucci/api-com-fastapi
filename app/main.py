from fastapi import FastAPI
from model.database import Database
from model.series import MustWatch
from typing import Any
 
app = FastAPI(
    title="Must Watch API",
    description="API para gerenciar séries, categorias, atores e avaliações.",
    version="1.0.0",
    openapi_tags=[
        {
            "name": "Séries",
            "description": "Operações relacionadas a séries, categorias, atores e avaliações."
        }
    ]
)
 
@app.get("/",
    summary="Página inicial",
    description="Retorna uma mensagem de boas-vindas à API Must Watch.",
    status_code=200)
def main_screen():
    return {"Series": "Must Watch"}
 
@app.get("/{table_name}/{item_id}",
    summary="Consultar item por ID",
    description="Retorna um único item da tabela especificada com base no ID.",
    status_code=200,
    response_model=Any
)
@app.get("/{table_name}",
    summary="Consultar todos os itens",
    description="Retorna todos os registros da tabela especificada.",
    status_code=200,
    response_model=Any)
def read_item(table_name: str, item_id: int = None):
    must_watch = MustWatch(table_name=table_name, item={}, item_id=item_id)
 
    resultado = must_watch.consultarSerie()
 
    return resultado
   
@app.post("/{table_name}",
    summary="Criar novo item",
    description="Insere um novo item na tabela especificada.",
    status_code=201,
    response_model=dict)
def create_item(table_name: str, item: dict):
    must_watch = MustWatch(table_name=table_name, item=item)
 
    must_watch.inserirSerie()
 
    return {"message": "Item adicionado com sucesso!"}
 
@app.delete("/{table_name}/{item_id}",
    summary="Deletar item",
    description="Remove um item da tabela com base no ID.",
    status_code=200,
    response_model=dict)
def delete_item(table_name: str, item_id: int):
    must_watch = MustWatch(table_name=table_name, item={}, item_id=item_id)
 
    must_watch.removerSerie()
 
    return {"message": "Item deletado com sucesso!"}
 
@app.put("/{table_name}/{item_id}",
    summary="Atualizar item",
    description="Atualiza os dados de um item na tabela especificada com base no ID.",
    status_code=200,
    response_model=dict)
def update_item(table_name: str, item_id: int, item: dict):
    must_watch = MustWatch(table_name=table_name, item=item, item_id=item_id)
 
    must_watch.atualizarSerie()
 
    return {"message": "Item atualizado com sucesso!"}