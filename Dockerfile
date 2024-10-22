# Verwende ein leichtgewichtiges Python-Image
FROM python:3.8-slim

# Setze das Arbeitsverzeichnis im Container
WORKDIR /app

# Kopiere die Anforderungen und installiere sie
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Kopiere den Rest der Anwendung
COPY . .

# Setze die Umgebungsvariable für Flask
ENV FLASK_APP=app.py

# Exponiere den Port 8080 (Cloud Run verwendet diesen Port)
EXPOSE 8080

# Startet die Flask-App
CMD ["python", "app.py"]
