FROM python:3.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    libreoffice \
    ghostscript \
    fonts-dejavu \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY ./requirements/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY flask_pptx_converter.py .

EXPOSE 8081

# Запуск сервера
CMD ["python", "flask_pptx_converter.py"]
