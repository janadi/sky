
FROM python:3.8-slim

# Arbeitsverzeichnis setzen
WORKDIR /app

# Installiere benötigte Python-Pakete
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Kopiere den restlichen Code
COPY . .

# Flask App starten
CMD ["python", "app.py"]
