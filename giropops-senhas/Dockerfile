# Etapa de construção
FROM cgr.dev/chainguard/python:latest-dev@sha256:d36bdbff6a1a6e4bdb2a09dbd962457948b8cd1f4b2c1952a72cc235697a27a1 as build

# Definir o diretório de trabalho
WORKDIR /app

# Copiar arquivos para o diretório de trabalho
COPY . /app

# Instalar dependências
RUN pip install -r requirements.txt --user

# Etapa final
FROM cgr.dev/chainguard/python:latest@sha256:a4c167ce35fdf4b7edb33084709f5d29906e3326e9cf13d1809ec032c847fad6

# Definir o diretório de trabalho
WORKDIR /app

COPY --from=build /home/nonroot/.local/lib/python3.12/site-packages /home/nonroot/.local/lib/python3.12/site-packages

# Copiar o diretório de trabalho da etapa de construção para o diretório de trabalho da etapa final
COPY --from=build /app /app

# Definir o comando padrão do contêiner
ENTRYPOINT ["python", "-m", "flask", "run", "--host=0.0.0.0"]