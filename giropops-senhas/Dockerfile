# Etapa de construção
FROM cgr.dev/chainguard/python:latest-dev@sha256:70f97dd84e4f7f3962ee3dc46b0c206f583981ea3317bfb7faca3d6082d4d41e as build

# Definir o diretório de trabalho
WORKDIR /app

# Copiar arquivos para o diretório de trabalho
COPY . /app

# Instalar dependências
RUN pip install -r requirements.txt --user

# Etapa final
FROM cgr.dev/chainguard/python:latest@sha256:99ee1559c4632e06f293a2f03a2677e6bff371d37b4de6e21322715cb0697055

# Definir o diretório de trabalho
WORKDIR /app

COPY --from=build /home/nonroot/.local/lib/python3.12/site-packages /home/nonroot/.local/lib/python3.12/site-packages

# Copiar o diretório de trabalho da etapa de construção para o diretório de trabalho da etapa final
COPY --from=build /app /app

# Definir o comando padrão do contêiner
ENTRYPOINT ["python", "-m", "flask", "run", "--host=0.0.0.0"]