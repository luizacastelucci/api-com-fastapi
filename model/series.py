from model.database import Database
from fastapi import HTTPException

tabelas_permitidas = {
        'serie' : 'idserie',
        'categoria' : 'idcategoria',
        'ator' : 'idator',
        'motivo_assistir' : 'idmotivo_assistir',
        'avaliacao_serie' : 'idavaliacao_serie',
        'ator_serie' : 'idator_serie',
}

db = Database()

class MustWatch:
    def __init__(self, table_name: str, item: dict, item_id: int = None):
        """Construtor da classe Serie."""
        self.table_name = table_name
        self.item = item
        self.item_id = item_id
        self.coluna_id = tabelas_permitidas.get(table_name)
        
    def consultarSerie(self):
        """Consulta uma tabela específica no banco de dados pelo ID."""
        db.conectar()

        try:
            if self.table_name not in tabelas_permitidas:
                raise HTTPException(status_code=406, detail="Tabela não encontrada")
                # Erro 406: Not Acceptable 

            if self.item_id is None:
                sql = f"SELECT * FROM {self.table_name}"
                params = ()
            else:
                sql = f"SELECT * FROM {self.table_name} WHERE {self.coluna_id} = %s"
                params = (self.item_id,)

            resultado = db.consultar(sql, params)

            if not resultado:
                raise HTTPException(status_code=404, detail="Item não encontrado")
                # Erro 404: Not Found

            return resultado
        
        except Exception as e:
            raise HTTPException(status_code=500, detail=f"Erro ao consultar o banco de dados: {str(e)}")
            # Erro 500: Internal Server Error
        
        finally:
            db.desconectar()

    def inserirSerie(self):
        """Adiciona um item a uma tabela específica no banco de dados."""
        db.conectar()

        try:
            if not self.item:
                raise HTTPException(status_code=400, detail="Nenhum dado fornecido para adicionar")
            # Erro 400: Bad Request

            colunas = ', '.join(self.item.keys())
            valores = ', '.join(['%s'] * len(self.item))
            sql = f"INSERT INTO {self.table_name} ({colunas}) VALUES ({valores})"
            params = tuple(self.item.values())
            

            db.executar(sql, params)
            db.desconectar()
        
        except Exception as e:
            db.desconectar()
            raise HTTPException(status_code=500, detail=f"Erro ao adicionar o item: {str(e)}")
            # Erro 500: Internal Server Error
        
    def removerSerie(self):
        '''Remove um item de alguma lista do banco de dados'''
        db.conectar()

        try:
            if self.coluna_id is None:
                raise HTTPException(status_code=406, detail="Mudança não permitida (Não foi atribuído um ID)")
                # Erro 406: Not Acceptable
            sql = f"DELETE FROM {self.table_name} WHERE {self.coluna_id} = %s"
            params = (self.item_id,)

            db.executar(sql, params)
            db.desconectar()

        except Exception as e:
            db.desconectar()
            raise HTTPException(status_code=500, detail=f"Erro ao remover o item: {str(e)}")
        
    def atualizarSerie(self):
        '''Atualiza um item de alguma lista do banco de dados'''
        db.conectar()

        try:
            if self.coluna_id is None:
                raise HTTPException(status_code=406, detail="Mudança não permitida (Não foi atribuído um ID)")
                # Erro 406: Not Acceptable
            if not self.item:
                raise HTTPException(status_code=400, detail="Nenhum dado fornecido para atualização")
                # Erro 400: Bad Request
            
            set_clause = ", ".join([f"{key} = %s" for key in self.item.keys()]) # para cada chave do dicionário, cria uma string no formato "chave = %s", separando por vírgula
            sql = f"UPDATE {self.table_name} SET {set_clause} WHERE {self.coluna_id} = %s"
            params = tuple(self.item.values()) + (self.item_id,)

            db.executar(sql, params)
            db.desconectar()
        except Exception as e:
            db.desconectar()
            raise HTTPException(status_code=500, detail=f"Erro ao atualizar o item: {str(e)}")