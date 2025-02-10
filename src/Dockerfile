FROM cgr.dev/chainguard/python:latest-dev as builder
WORKDIR /app
COPY requirements.txt .

# Instalar dependências em uma única camada
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt --user

FROM cgr.dev/chainguard/python:latest
WORKDIR /app

# Copiar apenas os arquivos necessários
COPY --from=builder /usr/lib/python3.13/site-packages /usr/lib/python3.13/site-packages
COPY app.py .

ENV REDIS_HOST="redis-server"

# Definir variáveis de ambiente para Python
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

ENTRYPOINT ["python", "-m", "flask", "run", "--host=0.0.0.0"]