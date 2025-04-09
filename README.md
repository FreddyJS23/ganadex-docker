# Documentación de Instalación para Ganadex Docker

### Requisitos Previos
- Docker instalado
- Docker Compose instalado
- Git instalado (para clonar el repositorio en modo online)

## Estructura del proyecto
```
project/
├── backend/
│ ├── docker-compose.yaml
│ ├── .env
│ └── ...
├── frontend/
│ ├── Dockerfile
│ ├── .env.production.local
│ └── ...
└── nginx/
└── default.conf
```

# 1. Clonar repositorio
```bash
 git clone https://github.com/FreddyJS23/ganadex-docker
cd ganadex-docker
```
# 2. Configurar variables de entorno
## Backend (Laravel)

Crea un archivo **.env** en el directorio backend basado en el archivo **.env.example** .

```env
APP_KEY= base64:AKefCgL9xA108TjO4B+dZEdjyGxUKv3W3crXdLLKM3o=
DB_PASSWORD=root  # Usada predertemina por el docker compose
```
La variable `APP_KEY` se puede utilizar, pero lo recomendado es generar una para el proyecto, para generarla, primero siga los siguentes paso de configuracion del proyecto, una vez el proyecto este configurado puede generar la **KEY**. En la raiz del proyecto ejecute  
```bash
docker compose up -d
```
Una vez iniciado los contenedores, se debe utilizar la consola interna del contenedor de laravel, para eso, abra la consola de comando y escriba lo siguente:

```bash
docker compose -it exec ganadex_backend php artisan key:generate
```
Esto creara un nuevo string para `APP_KEY.` Al hacer uso de la  consola interna del contenedor para generar la key detendra el servidor interno de php. Solo debe detener los contenedores y volver iniciar
######Detener
```bash
docker compose down
```
######Iniciar
```bash
docker compose up -d
```
## Frontend (Nextjs)

Crea un archivo **.env.production.local** en el directorio backend basado en el archivo **.env.example** .

```env
AUTH_SECRET=G/QG9l1ryBfl5C0wHlqZ+qhA5ZrrUYW2VsJH4Kjyf2g=
```
La variable `AUTH_SECRET` se puede utilizar, pero lo recomendado es generar una para el proyecto, para generarla, primero siga los siguentes paso de configuracion del proyecto, una vez el proyecto este configurado puede generar la **KEY**. En la raiz del proyecto ejecute  

```bash
docker compose up -d
```
Una vez iniciado los contenedores, se debe utilizar la consola interna del contenedor de nextjs, para eso, abra la consola de comando y escriba lo siguente:

```bash
docker compose -it exec ganadex_frontend bunx auth secre t
```
Esto generara una cadena de caracteres que debera copiar y pegar en  `AUTH_SECRET= `. del `.env.production.local` Debera reiniciar los contenedores para el correcto funcionamiento
######Detener
```bash
docker compose down
```
######Iniciar
```bash
docker compose up -d
```

# 3. Iniciar Ganadex
Para iniciar la aplicacion se deberan construir las imagenes y levantar los contenedores. Abra la consola y coloque:

```bash
docker compose up -d --build
```
 **Si las imagenes ya estan construidas ommita este paso**

El comando creara las imagenes utilizadas por los contenedores configurados en el archivo docker-compose.yaml

El comando solo debe ejecutarse la primera vez para contruir las imagenes en la maquina.

Siempre que termine de utilizar la aplicacion debe asegurarse de detener los contendores para no consumir recursos inncesarios del computador. Para detenerlos solo abra la consola y coloque 
```bash
docker compose down
```
Si desea iniciar la aplicacion nuevamente solo debe abrir la consola y colocar:
```bash
docker compose up -d 
```
Esto iniciara los contenedores, la notacion `--build` ya no es necesaria ya que las imagenes estan construidas