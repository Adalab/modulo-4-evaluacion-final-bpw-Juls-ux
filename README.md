Esta es una API REST en Node.js con Express y MySQL que permite gestionar una base de datos de piedras mágicas. La API incluye operaciones CRUD para las piedras, registro y autenticación de usuarias.
1. Instalación
Clona este repositorio:

sh
Copiar
Editar
git clone <URL_DEL_REPOSITORIO>
cd <NOMBRE_DEL_PROYECTO>
Instala las dependencias:

sh
Copiar
Editar
npm install
Crea un archivo .env en la raíz del proyecto y define tus variables de entorno:

ini
Copiar
Editar
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_USER=tu_usuario
MYSQL_PASS=tu_contraseña
MYSQL_SCHEMA=piedrasmagicas
JWT_PASS=tu_clave_secreta
Inicia el servidor:

sh
Copiar
Editar
node index.js


2.  Endpoints
🔍 Obtener todas las piedras mágicas
GET /piedras

json
Copiar
Editar
{
  "info": { "count": 3 },
  "results": [
    { "id": 1, "nombre": "Amatista", "color": "Morado", "elemento": "Agua", "propiedades": "Calma y sabiduría" },
    { "id": 2, "nombre": "Cuarzo", "color": "Blanco", "elemento": "Tierra", "propiedades": "Energía y claridad" }
  ]
}
🔍 Obtener una piedra por ID
GET /piedras/:id

json
Copiar
Editar
{
  "id": 1,
  "nombre": "Amatista",
  "color": "Morado",
  "elemento": "Agua",
  "propiedades": "Calma y sabiduría"
}
➕ Agregar una nueva piedra
POST /piedras

json
Copiar
Editar
{
  "nombre": "Ópalo",
  "color": "Azul",
  "elemento": "Agua",
  "propiedades": "Creatividad e inspiración"
}
Respuesta:

json
Copiar
Editar
{
  "success": true,
  "id": 5
}
✏️ Actualizar una piedra
PUT /piedras/:id

json
Copiar
Editar
{
  "nombre": "Ópalo",
  "color": "Verde",
  "elemento": "Agua",
  "propiedades": "Equilibrio emocional"
}
Respuesta:

json
Copiar
Editar
{
  "success": true,
  "message": "Piedra con ID 5 actualizada correctamente"
}
❌ Eliminar una piedra
DELETE /piedras/:id

json
Copiar
Editar
{
  "success": true,
  "message": "Piedra con ID 5 eliminada correctamente"
}
🧙‍♀️ Registro de usuaria
POST /register

json
Copiar
Editar
{
  "nombre": "Luna",
  "password": "1234"
}
Respuesta:

json
Copiar
Editar
{
  "success": true,
  "id": 1,
  "user": { "id_usuaria": 1, "nombre": "Luna" }
}
🔑 Inicio de sesión
POST /login

json
Copiar
Editar
{
  "nombre": "Luna",
  "password": "1234"
}
Respuesta:

json
Copiar
Editar
{
  "success": true,
  "token": "eyJhbGciOi..."
}
📜 Licencia
Este proyecto está bajo la licencia MIT.

