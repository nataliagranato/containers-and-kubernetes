# Etapa de construção
FROM cgr.dev/chainguard/python:latest-dev@sha256:8822335948a77f0ad8025c9f83f82fb4b1e266b3d48d3991d20c5f2b2248af55 as build

# Definir o diretório de trabalho
WORKDIR /app

# Copiar arquivos para o diretório de trabalho
COPY . /app

# Instalar dependências
RUN pip install -r requirements.txt --user

# Etapa final
FROM cgr.dev/chainguard/python:latest@sha256:f5e8b018012c8767141cce3d14fd065bcbf20034239bd7f750a3d4cee49ce1d2

# Definir o diretório de trabalho
WORKDIR /app

COPY --from=build /home/nonroot/.local/lib/python3.12/site-packages /home/nonroot/.local/lib/python3.12/site-packages

# Copiar o diretório de trabalho da etapa de construção para o diretório de trabalho da etapa final
COPY --from=build /app /app

# Definir o comando padrão do contêiner
ENTRYPOINT ["python", "-m", "flask", "run", "--host=0.0.0.0"]