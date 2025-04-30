@echo off

:: Detenercontenedor ganadex
:: Cambiar al directorio donde están los archivos de Docker
cd ..\ganadex-docker"

if errorlevel 1 (
    echo Error: No se pudo acceder al directorio ganadex-docker
    pause
    exit /b 1
)

echo Deteniendo ganadex
docker compose down
if errorlevel 1 (
    echo Error: Fallo al detener contenedores Docker
    pause
    exit /b 1
)