@echo off
:: Ejecutar migraciones y seeder de Laravel con validación de errores

:: Cambiar al directorio donde están los archivos de Docker
cd ..\ganadex-docker"
if errorlevel 1 (
    echo Error: No se pudo acceder al directorio ganadex-docker
    pause
    exit /b 1
)

echo  Construyendo imagenes, esto puede tardar...
docker compose up -d
if errorlevel 1 (
    echo Error: Fallo al iniciar contenedores Docker
    pause
    exit /b 1
)

::Como es la primera vez que ejecuta sql, se debe esperar que inicialize sus tablas
echo .
echo Inicializando base de datos, por favor espere...
timeout /t 60 /nobreak > nul


docker compose exec php php artisan migrate
if errorlevel 1 (
    echo Error: Fallo en migraciones de la base de datos
    docker compose down
    pause
    exit /b 1
)

echo .
docker compose exec php php artisan db:seed
if errorlevel 1 (
    echo Error: Fallo en el seeder de la base de datos
    docker compose down
    pause
    exit /b 1
)

docker compose down
if errorlevel 1 (
    echo Error: Fallo al detener contenedores Docker
    pause
    exit /b 1
)

echo.
echo Ganadex instalado correctamente
pause