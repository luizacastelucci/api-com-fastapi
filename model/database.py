import mysql.connector as mc # Importando a biblioteca do conector do MYSQL
from mysql.connector import Error # Importando a classe Error para tratar as mensagens de erro do código
from dotenv import load_dotenv # Importando a função load_dotenv
from os import getenv # Importando a função getenv
 
class Database:
    def __init__(self):
        load_dotenv()
        self.host = getenv('DB_HOST') # Declaração de variáveis que se referem a própria classe
        self.username = getenv('DB_USER')
        self.password = getenv('DB_PSWD')
        self.database = getenv('DB_NAME')
        self.connection = None # Inicialização da conexão -> variavel connection existe, mas não tem nada ainda. Conexão é uma ponte entre o programa e o banco de dados
        self.cursor = None # Inicialização do cursor. É o mensageiro entre o programa e o banco de dados. Ele é quem executa as instruções SQL
 
    def conectar(self):
        """Estabelece uma conexão com o banco de dados."""
        try:
            self.connection = mc.connect( # conecta a variavel da classe com o método do MYSQL.connector
                host = self.host, # self = atributo do objeto. Faz com que o objeto execute algo com ele mesmo
                database = self.database,
                user = self.username,
                password = self.password
            )
            if self.connection.is_connected():
                self.cursor = self.connection.cursor(dictionary = True)
                print("Conexão ao banco de dados realizada com sucesso!")
        except Error as e:
            print(f'Erro de conexão: {e}')
            self.connection = None
            self.cursor = None
 
    def desconectar(self):
        """Encerra a conexão com o banco de dados e o cursor, se existirem."""
        if self.cursor:
            self.cursor.close()
        if self.connection:
            self.connection.close()
        print("Conexão com o banco de dados encerrada com sucesso!")
 
    def executar(self, sql, params = None): # variável parametros existe para que as pessoas não façam destruam a dayabase
        """Executa uma instrução no banco de dados"""
        if self.connection is None and self.cursor is None:
            print('Conexão ao banco de dados não estabelecida!')
            return None
       
        try:
            self.cursor.execute(sql, params)
            self.connection.commit()
            return self.cursor
        except Error as e:
            print(f'Erro de execução: {e}')
            return None
       
    def consultar(self, sql, params = None): # variável parametros existe para que as pessoas não façam destruam a database -> proteção de MySQL Injection
        """Executa uma consulta no banco de dados"""
        if self.connection is None and self.cursor is None:
            print('Conexão ao banco de dados não estabelecida!')
            return None
        try:
            self.cursor.execute(sql, params)
            return self.cursor.fetchall()
        except Error as e:
            print(f'Erro de execução: {e}')
            return None