# Etapa de construção
FROM cgr.dev/chainguard/python:latest-dev@sha256:da05d36d8450c8dbc560eb0becf38e6c989b9b0af89770fa42437d4f6b479649 as build

# Definir o diretório de trabalho
WORKDIR /app

# Copiar arquivos para o diretório de trabalho
COPY . /app

# Instalar dependências
RUN pip install -r requirements.txt --user

# Etapa final
FROM cgr.dev/chainguard/python:latest@sha256:1e753aa0ea651af8aaf7dd675d9dcfc2139bf13acd2cceb2dba3c39286a6172f

# Definir o diretório de trabalho
WORKDIR /app

COPY --from=build /home/nonroot/.local/lib/python3.12/site-packages /home/nonroot/.local/lib/python3.12/site-packages

# Copiar o diretório de trabalho da etapa de construção para o diretório de trabalho da etapa final
COPY --from=build /app /app

# Definir o comando padrão do contêiner
ENTRYPOINT ["python", "-m", "flask", "run", "--host=0.0.0.0"]