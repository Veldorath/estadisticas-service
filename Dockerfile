# Dockerfile — estadisticas-service (FastAPI, puerto 8006)
# Imagen liviana, capas limpias, usuario NO root.
FROM python:3.12-slim

# No escribir .pyc y salida sin buffer (logs en vivo)
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# 1) Dependencias primero (mejor cache de capas)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 2) Codigo de la aplicacion
COPY app/ ./app/

# 3) Usuario no root
RUN useradd --create-home appuser
USER appuser

EXPOSE 8006

# Arranque con uvicorn
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8006"]
