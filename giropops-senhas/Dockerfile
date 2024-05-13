# Etapa de construção
FROM cgr.dev/chainguard/python:latest-dev@sha256:237d873a449fe2fe4859c13f56b170ba739b0f5c0422f4e139499ecf044f415c as build

# Definir o diretório de trabalho
WORKDIR /app

# Copiar arquivos para o diretório de trabalho
COPY . /app

# Instalar dependências
RUN pip install -r requirements.txt --user

# Etapa final
FROM cgr.dev/chainguard/python:latest@sha256:f910d00bf6accfa0641eb8220a674d0d2927edbe5b0f5c096fe725cb1b905a60

# Definir o diretório de trabalho
WORKDIR /app

COPY --from=build /home/nonroot/.local/lib/python3.12/site-packages /home/nonroot/.local/lib/python3.12/site-packages

# Copiar o diretório de trabalho da etapa de construção para o diretório de trabalho da etapa final
COPY --from=build /app /app

# Definir o comando padrão do contêiner
ENTRYPOINT ["python", "-m", "flask", "run", "--host=0.0.0.0"]