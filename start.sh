#!/bin/bash

# Crear carpeta temporal
mkdir -p tmp_bedrock
cd tmp_bedrock

# Obtener la URL más reciente del servidor Bedrock
echo "Obteniendo la última versión del servidor Bedrock..."
LATEST_URL=$(curl -s https://www.minecraft.net/en-us/download/server/bedrock | grep -oP 'https://minecraft.azureedge.net/bin-linux/bedrock-server-[\d\.]+\.zip' | head -n 1)

# Instalar el servidor si no existe
if [ ! -f ../bedrock_server ]; then
    echo "Descargando servidor desde: $LATEST_URL"
    curl -O "$LATEST_URL"
    unzip bedrock-server-*.zip
    chmod +x bedrock_server
    mv bedrock_server ../bedrock_server
    mv *.so ../
    mv *.json ../
    mv *.txt ../
    cd ..
    rm -r tmp_bedrock
fi

# Descargar Playit.gg si no está presente
if [ ! -f playit ]; then
    echo "Descargando Playit.gg..."
    curl -L -o playit https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-64
    chmod +x playit
fi

# Iniciar Playit.gg en segundo plano
echo "Iniciando túnel Playit.gg..."
./playit &

# Iniciar el servidor Bedrock
echo "Iniciando servidor Minecraft Bedrock..."
./bedrock_server
