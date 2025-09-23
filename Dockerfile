# Базовый образ с Python
FROM python:3.11-slim

# Установим LibreOffice и Ghostscript (для soffice и gs)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libreoffice ghostscript fonts-dejavu && \
    rm -rf /var/lib/apt/lists/*

# Рабочая директория
WORKDIR /app

# Python-зависимости
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# По умолчанию запускаем скрипт из примонтированного каталога
CMD ["python", "pptx_unix_min.py"]
