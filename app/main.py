from fastapi import FastAPI
from model.database import Database
from model.series import MustWatch

app = FastAPI()

db = Database()

@app.get('/')
def read_root():
    return {"Series": "Must Watch"}

@app.get("/{table_name}/{item_id}")
@app.get("/{table_name}")
def read_item(table_name: str, item_id: int = None):
    must_watch = MustWatch(table_name=table_name, item={}, item_id=item_id)

    resultado = must_watch.consultarSerie()

    return resultado
    
@app.post("/{table_name}")
def create_item(table_name: str, item: dict) :
    must_watch = MustWatch(table_name=table_name, item=item) 

    must_watch.inserirSerie()

    return {"message": "Item adicionado com sucesso!"}

@app.delete("/{table_name}/{item_id}")
def delete_item(table_name: str, item_id: int):
    must_watch = MustWatch(table_name=table_name, item={}, item_id=item_id)

    must_watch.removerSerie()

    return {"message": "Item deletado com sucesso!"}

@app.put("/{table_name}/{item_id}")
def update_item(table_name: str, item_id: int, item: dict):
    must_watch = MustWatch(table_name=table_name, item=item, item_id=item_id)

    must_watch.atualizarSerie()

    return {"message": "Item atualizado com sucesso!"}