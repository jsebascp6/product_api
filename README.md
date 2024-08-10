# Product API
Esta es una API para gestionar productos, construida con Ruby on Rails y Docker.

## Requisitos
- Docker
- Docker Compose

## Instalación y Configuración
1. Clona el repositorio:
   ```bash
   git clone git@github.com:jsebascp6/product_api.git
   cd product_api

2. Construye la imagen de Docker:
   ```bash
   sudo docker-compose build web

3. Configura la base de datos:
    - Opcional: Si necesitas limpiar la base de datos existente:
      ```bash
      sudo docker-compose run web bin/rails db:drop
    - Crea la base de datos:
      ```bash
      sudo docker-compose run web bin/rails db:create
    - Aplica las migraciones:
      ```bash
      sudo docker-compose run web bin/rails db:create
  
4. Inicia el servidor:
      ```bash
      sudo docker-compose up web
  El servidor estará disponible en http://localhost:3000.

## Endpoints
- GET /api/v1/products - Lista todos los productos.
- POST /api/v1/products - Crea un nuevo producto.
- GET /api/v1/products/:id - Muestra un producto específico.
- PATCH/PUT /api/v1/products/:id - Actualiza un producto.
- DELETE /api/v1/products/:id - Elimina un producto.

## Autenticación
La API utiliza autenticación básica. Para acceder a los endpoints protegidos, se deben enviar las credenciales como parte de la solicitud.

## CORS
Esta API está configurada para permitir solicitudes desde localhost y 127.0.0.1 en varios puertos, permitiendo el uso de credenciales.

## Pruebas
Para ejecutar las pruebas, utiliza RSpec con Docker:
```bash
sudo docker-compose run web bundle exec rspec spec/*
```

## Contribuciones
Las contribuciones son bienvenidas. Por favor, abre un issue o envía un pull request.
