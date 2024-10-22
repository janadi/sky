# Verwende ein Basis-Python-Image mit zusätzlichen Abhängigkeiten
FROM python:3.11

# Installiere systemabhängige Pakete
RUN apt-get update && apt-get install -y \
    build-essential \
    libgl1-mesa-glx \
    libglib2.0-0 \
    ffmpeg \
    wget \
    git \
    cmake \
    meshlab \
    && apt-get clean

RUN git clone https://github.com/colmap/colmap.git /colmap \
    && cd /colmap \
    && git checkout main \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j$(nproc) \
    && make install
    
# Erstelle das Arbeitsverzeichnis
WORKDIR /app

# Kopiere die Anforderungen (requirements.txt) und installiere Python-Abhängigkeiten
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Kopiere den Rest der Anwendung in das Arbeitsverzeichnis
COPY . /app

# Exponiere den Port, den Flask verwendet (standardmäßig 8080)
EXPOSE 8080

ENTRYPOINT ["python"]
# Setze den Startbefehl
CMD ["python", "src/app.py"]
