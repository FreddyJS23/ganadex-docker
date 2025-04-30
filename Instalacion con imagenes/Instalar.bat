@echo off
:: Script para cargar 4 imágenes Docker en Windows CMD
:: Guardar como cargar_imagenes_docker.bat

echo Iniciando carga de imagenes Docker...
goto :main

:: Función para cargar una imagen
:: Uso: call :cargar_imagen "archivo.tar" "nombre_imagen"
:cargar_imagen

echo.

echo Cargando imagen %2 desde %1...
docker image load -i %1

if %errorlevel% equ 0 (
    echo Imagen %2 cargada con exito
) else (
    echo Error al cargar la imagen %2
    pause
    exit /b 1
)
exit /b 0

:main
:: Cargar las 4 imagenes 
call :cargar_imagen "ganadex_frontend.tar" "Ganadex frontend"
call :cargar_imagen "ganadex_backend.tar" "Ganadex backend"
call :cargar_imagen "nginx.tar" "Servidor"
call :cargar_imagen "mysql.tar" "Base de datos"

echo .

:: Ejecutar migraciones y seeder de Laravel con validación de errores
:: Cambiar al directorio donde están los archivos de Docker
cd ..\ganadex-docker"

if errorlevel 1 (
    echo Error: No se pudo acceder al directorio ganadex-docker
    pause
    exit /b 1
)

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