FROM cgr.dev/chainguard/python:latest-dev as builder
WORKDIR /app
COPY . /app
RUN pip install --no-cache-dir -r requirements.txt --user

FROM cgr.dev/chainguard/python:latest-dev 
WORKDIR /app
COPY --from=builder /home/nonroot/.local/lib/python3.12/site-packages /home/nonroot/.local/lib/python3.12/site-packages
COPY --from=builder /app /app

ENV REDIS_HOST="redis-server"
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl --fail http://localhost:5000/health || exit 1
ENTRYPOINT ["python", "-m", "flask", "run", "--host=0.0.0.0"]