#!/bin/bash

# Instalar el servidor de Minecraft Bedrock si no existe
if [ ! -f bedrock_server ]; then
    echo "Downloading Minecraft Bedrock server..."
    curl -O https://minecraft.azureedge.net/bin-linux/bedrock-server-1.20.32.3.zip
    unzip bedrock-server-1.20.32.3.zip
    chmod +x bedrock_server
    rm bedrock-server-1.20.32.3.zip
fi

# Descargar Playit.gg si no está presente
if [ ! -f playit ]; then
    echo "Downloading Playit.gg tunnel..."
    curl -L -o playit https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-64
    chmod +x playit
fi

# Iniciar Playit.gg en segundo plano
echo "Starting Playit.gg tunnel..."
./playit &

# Iniciar el servidor Bedrock
echo "Starting Minecraft Bedrock server..."
./bedrock_server
