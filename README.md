# Must Watch API
Este projeto é uma API construída com **FastAPI** e **MySQL** para gerenciar informações de séries de TV, incluindo operações de CRUD (Create, Read, Update, Delete) para séries, categorias, atores, avaliações e motivos para assistir.
 
 
## Estrutura do Projeto
- `main.py`  
  Define as rotas da API (controllers).
- `series.py`  
  Implementa a lógica de negócio (`MustWatch`), decodifica operações CRUD e monta comandos SQL.
- `database.py`  
  Cuida da conexão com o banco MySQL usando `mysql-connector-python` e `python-dotenv`.
- `must_watch.sql`  
  Script SQL com DDL e dados de exemplo para criação do banco `must_watch`.
 
 
## Pré-requisitos
- Python 3.9+
- MySQL Server 8.0+
- Git
 
 
## Instalação e Setup
`bash`
# 1. Clone o repositório
git clone https://github.com/seu-usuario/must-watch-api.git
cd must-watch-api
# 2. Crie e ative um ambiente virtual
python -m venv .venv
source .venv/bin/activate     # Linux/macOS
.\\.venv\\Scripts\\activate   # Windows
# 3. Instale as dependências
pip install --upgrade pip
pip install -r requirements.txt
 
## Configuração do .env
Crie um arquivo .env na raiz do projeto com o seguinte conteúdo:
DB_HOST=localhost
DB_USER=seu_usuario
DB_PSWD=sua_senha
DB_NAME=must_watch
 
## Banco de Dados
No MySQL, execute:
CREATE DATABASE must_watch;
 
Em seguida, importe o script de estrutura e dados de exemplo:
-> mysql -u seu_usuario -p must_watch < must_watch.sql
 
## Executando a API
uvicorn main:app --reload
 
 
## Acesse a documentação interativa em:
 
Swagger UI: http://127.0.0.1:8000/docs
Redoc: http://127.0.0.1:8000/redoc
 
Endpoints
| Método  |     Rota     |           Descrição         |
|--------|--------------|------------------------------|
| GET    | /    |  Exibe uma mensagem introdutória
| GET    | /serie |  Retorna todas as séries
| GET    | /serie/{id}  |  Retorna uma série por ID    
| POST   | /serie |  Cria uma nova série    
| PUT    | /serie/{id}  |  Atualiza uma série existente
| DELETE | /serie/{id}  |  Remove uma série            
 
 
Substitua serie por qualquer tabela permitida: categoria, ator, motivo_assistir, avaliacao_serie, ator_serie.
 
## Atualizar uma série
curl -X PUT "http://127.0.0.1:8000/serie/1"
 
     -H "Content-Type: application/json" \
 
     -d '{"titulo":"Título Atualizado"}'
 
## Excluir uma série
 
curl -X DELETE "http://127.0.0.1:8000/serie/1"
 
## Teste por meio do ThunderClient
 
-> Opção 1: Testes com Thunder Client (VS Code)
  Abra o projeto no VS Code.
  Vá até a aba Extensões e instale Thunder Client.
  Acesse a aba lateral Thunder Client.
  Crie requisições GET, POST, PUT, DELETE para as rotas da API.
  Preencha os dados em JSON e envie — o resultado será exibido abaixo.
 
-> Exemplo de corpo JSON para POST /serie:
 
jsonCopiarEditar{"titulo": "Nova Série","descricao": "Descrição da série","ano_lancamento": 2025,"idcategoria": 1 }
 
 
 
## Boas Práticas e Próximos Passos
 
-> Adicionar Pydantic para validação de payloads e definição de response_model.
-> Implementar decorator ou context manager para centralizar abertura/fechamento de conexão ao banco.
-> Configurar logging para registros estruturados de erro e informação.
-> Criar testes automatizados com pytest e FastAPI TestClient.
-> Elaborar um README mais detalhado com diagramas de arquitetura e fluxos de dados.
 
## Licença
Este projeto está licenciado sob a MIT License.
 
 