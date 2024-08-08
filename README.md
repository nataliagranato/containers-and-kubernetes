# Gerador de Senhas com Redis

Este é um projeto de uma aplicação em Python que gera senhas aleatórias e utiliza o Redis como um banco de dados para armazenamento temporário das senhas geradas. Este README.md fornecerá instruções sobre como executar a aplicação localmente e também inclui informações sobre como dockerizar o projeto.

### Pré-requisitos

* Git
* Python3
* Pip
* Docker (opcional, se desejar executar via contêiner)

## Executando a aplicação local

1. Clone o repositório:

```
https://github.com/nataliagranato/giropops-senhas.git
```

2. Entre no diretório de trabalho:

```
cd giropops-senhas
```

3. Atualize o sistema operacional:

```
sudo apt update -y
```

4. Certifique-se de ter o Python instalado e instale o gerenciador de pacotes Pip:

```
sudo apt-get install python3-pip -y
```

5. Atualize o projeto:

```
pip install --upgrade Flask
```

**Esse passo foi necessário, pois tive o seguinte problema:**

```
flask run --host=0.0.0.0
Traceback (most recent call last):
  File "/usr/local/bin/flask", line 5, in <module>
    from flask.cli import main
  File "/usr/local/lib/python3.8/dist-packages/flask/__init__.py", line 7, in <module>
    from .app import Flask as Flask
  File "/usr/local/lib/python3.8/dist-packages/flask/app.py", line 27, in <module>
    from . import cli
  File "/usr/local/lib/python3.8/dist-packages/flask/cli.py", line 17, in <module>
    from .helpers import get_debug_flag
  File "/usr/local/lib/python3.8/dist-packages/flask/helpers.py", line 14, in <module>
    from werkzeug.urls import url_quote
ImportError: cannot import name 'url_quote' from 'werkzeug.urls' (/usr/local/lib/python3.8/dist-packages/werkzeug/urls.py)
```

Se necessário, adicione uma versão específica do Werkzeug ao arquivo requirements.txt, como Werkzeug==2.2.2, para resolver possíveis problemas de importação.

6. Instale o Redis, uma dependência do projeto:

```
sudo apt-get install redis -y
```

7. Inicie o Redis:

```
sudo systemctl start redis && systemctl status redis
```

8. Instale todas as dependências do Python:

```
pip install --no-cache-dir -r requirements.txt
```

9. Crie uma variável de ambiente para que a aplicação encontre o Redis:

```
export REDIS_HOST=localhost
```

10. Iniciando a aplicação:

```
flask run --host=0.0.0.0
```

# Dockerização do Projeto

Para dockerizar o projeto, siga estas etapas:

1. Construa a imagem docker:

```
docker build -t nataliagranato/linuxtips-giropops-senhas:1.0 .
```

2. Inicie um contêiner Redis:

```
docker container run -d -p 6000:6379 --name redis redis:alpine3.19
```

3. Descubra o IPAddress do Redis:

```
docker inspect ID_REDIS | grep IPAddress
```

4. Executando a aplicação:

```
docker run -d --name giropops-senhas -p 5000:5000 --env REDIS_HOST=IP_REDIS giropops-senhas:5.0
```

Ou

5. Use o Docker Compose para construir e iniciar os serviços:

```
docker-compose up -d
```

Isso iniciará tanto a aplicação quanto o contêiner Redis. A aplicação estará disponível em <http://localhost:5000/>.

Certifique-se de que todas as portas necessárias estejam liberadas e de que não haja conflitos com outras aplicações em execução em sua máquina.

Observação: As versões dos pacotes e dependências podem variar. Certifique-se de usar as versões mais recentes e compatíveis com seu ambiente.
