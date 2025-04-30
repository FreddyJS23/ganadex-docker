@echo off

:: Iniciar contenedor ganadex
:: Cambiar al directorio donde están los archivos de Docker
cd ..\ganadex-docker"

if errorlevel 1 (
    echo Error: No se pudo acceder al directorio ganadex-docker
    pause
    exit /b 1
)

echo Iniciando ganadex
docker compose up -d
if errorlevel 1 (
    echo Error: Fallo al iniciar contenedores Docker
    pause
    exit /b 1
)
echo .
echo Abriendo navegador
timeout /t 10 /nobreak > nul


:: URL personalizada 
set "APP_URL=http://ganadex.localhost:3000"

:: Abrir navegador con la URL
start "" "%APP_URL%"