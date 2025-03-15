//MYQSL coenxión
const mysql = require("mysql2/promise");

const express = require('express');
const cors = require('cors');
require("dotenv").config();
const jwt = require('jsonwebtoken'); 
const bcrypt = require('bcryptjs');
const saltRounds= 10;
require('dotenv').config();

async function getConnection() {
    const connectionData = {
        host: process.env["MYSQL_HOST"],
        port: process.env["MYSQL_PORT"],
        user: process.env["MYSQL_USER"],
        password: process.env["MYSQL_PASS"],
        database: process.env["MYSQL_SCHEMA"]

    };
    const connection = await mysql.createConnection(connectionData);
    await connection.connect();
    return connection;
}

const app = express();

app.use(cors());
app.use(express.json());

//Arrancamos Servidor

const port = 3000;
app.listen(port, () => {
    console.log(`Example app listening on port<http://localhost:${port}>`);
});


//1º endpoint todas las piedras mágicas
app.get('/piedras', async (req, res) => {

    const conn = await getConnection();

    const [results] = await conn.query(`SELECT * FROM piedrasmagicas.piedras;`);

    await conn.end();

    const numOfElements = results.length;

    res.json({
        info: { count: numOfElements },
        results: results,

    });

});

//2º endpoint con id
app.get('/piedras/:id', async (req, res) => {

    const conn = await getConnection();

    const [results] = await conn.query(`
        
        SELECT * FROM piedrasmagicas.piedras
        WHERE id = ?;`, [req.params.id]);

    await conn.end();

    const numOfElements = results.length;

    res.json(
        results[0]
    );

});

//3º endpoint con las propiedades mágicas
app.get('/usos-magicos', async (req, res) => {

    const conn = await getConnection();

    const [results] = await conn.query(`
        
        SELECT * FROM piedrasmagicas.usos_magicos;`);

    await conn.end();

    const numOfElements = results.length;
    res.json({
        info: { count: numOfElements },
        results: results,

    });

});

//4º Endpoint INSERTAR PIEDRA
app.post('/piedras', async (req, res) => {


    try {

        const conn = await getConnection();

        const [results] = await conn.execute(`
            INSERT INTO piedrasmagicas.piedras (nombre, color, elemento, propiedades) 
            VALUES (?, ?, ?, ?);`, [req.body.nombre, req.body.color, req.body.elemento, req.body.propiedades]);

        await conn.end();

        res.json({
            "success": true,
            "id": results.insertId
        });

    }
    catch (err) {
        res.status(500).json({
            "success": false,
            "message": err.toString()

        })
    }
});



//5º Endpoint MODIFICAR/ACTUALIZAR PIEDRA-->UPDATE
app.put('/piedras/:id', async (req, res) => {

    try {
        const piedraId = req.params.id;
        const { nombre, color, elemento, propiedades } = req.body;

        // Validar que el ID sea un número válido
        if (!piedraId || isNaN(parseInt(piedraId))) {
            return res.status(400).json({
                success: false,
                error: 'El ID no es válido'
            });
        }

        // Validar que el nombre no esté vacío
        if (!nombre || nombre.trim() === '') {
            return res.status(400).json({
                success: false,
                error: 'El nombre no es correcto'
            });
        }

        // Obtener conexión con la base de datos
        const conn = await getConnection();

        // Ejecutar la consulta SQL para actualizar
        const [results, fields] = await conn.execute(
            `UPDATE piedrasmagicas.piedras 
             SET nombre = ?, color = ?, elemento = ?, propiedades = ? 
             WHERE id = ?`,
            [nombre, color, elemento, propiedades, piedraId]
        );

        await conn.end();

        // Verificar si se actualizó alguna fila
        if (results.affectedRows > 0) {
            res.json({
                success: true,
                message: `Piedra con ID ${piedraId} actualizada correctamente`,
                updatedPiedra: {
                    id_piedra: piedraId,
                    nombre,
                    color,
                    elemento,
                    propiedades
                }
            });
        } else {
            res.status(404).json({
                success: false,
                error: `No se encontró una piedra con ID ${piedraId}`
            });
        }
    } catch (error) {
        res.status(500).json({
            success: false,
            error: "Error al actualizar la piedra",
            details: error.message
        });
    }
});



//6º Endpoint ELIMINAR PIEDRA MÁGICA
app.delete('/piedras/:id', async (req, res) => {

    try {
        const piedraId = parseInt(req.params.id);

        // Validar que el ID sea un número válido
        if (!piedraId || isNaN(piedraId)) {
            return res.status(400).json({
                success: false,
                error: 'El ID no es válido'
            });
        }
        const conn = await getConnection();

        const [exist] = await conn.execute(`SELECT id FROM piedrasmagicas.piedras WHERE id = ?`, [piedraId]);
        if (exist.length === 0) {
            await conn.end();
            return res.status(404).json({ success: false, error: `No se encontró una piedra con ID ${piedraId}` });
        }

        await conn.execute(`DELETE FROM piedras_tienen_usos_magicos WHERE piedras_id = ?`, [piedraId]);
        await conn.execute(`DELETE FROM compatibilidades_tienen_piedras WHERE piedras_id = ?`, [piedraId]);


        const [results, fields] = await conn.execute(
            `DELETE FROM piedrasmagicas.piedras 
            WHERE id = ?`,
            [piedraId]
        );

        await conn.end();

        if (results.affectedRows > 0) {
            res.json({
                success: true,
                message: `Piedra con ID ${piedraId} eliminada correctamente`

            });
        } else {
            res.status(404).json({
                success: false,
                error: `No se encontró una piedra con ID ${piedraId}`
            });
        }
    } catch (error) {
        res.status(500).json({
            success: false,
            error: "Error al eliminar la piedra",
            details: error.message
        });
    }
});


//7º Endpoint REGISTRO

app.post('/register', async (req, res) => {
    try {

        if (req.body.password === undefined || req.body.password === '') {
            return res.status(400).json({
                success: false,
                error: 'Las contraseñas no coinciden'
            });
        }


        if (req.body.nombre === undefined || req.body.nombre === '') {
            return res.status(400).json({
                success: false,
                error: 'El nombre de usuaria no es correcto'
            });
        }

        const conn = await getConnection();


        const [resultCheck] = await conn.execute(
            `SELECT * FROM usuarias WHERE email = ?;`,
            [req.body.nombre]
        );

        if (resultCheck.length > 0) {
            return res.status(409).json({
                success: false,
                error: 'La usuaria ya existe'
            });
        }

        const hiddenPassword = await bcrypt.hash(req.body.password, saltRounds);


        const [resultInsert] = await conn.execute(
            `INSERT INTO usuarias (email, nombre, password) VALUES (?, ?, ?);`,
            [req.body.nombre, req.body.nombre, hiddenPassword]
        );

        await conn.end();

        // Responder con éxito y los datos de la nueva usuaria
        res.json({
            success: true,
            id: resultInsert.insertId,
            user: {
                id_usuaria: resultInsert.insertId,
                email: req.body.email,
                nombre: req.body.nombre
            }
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            error: 'Error al registrar la usuaria',
            details: error.message
        });
    }
});


//8º Endpoint USUARIAS
app.get('/usuarias', async (req, res) => {

    const conn = await getConnection();

    const [results] = await conn.query(`
        
        SELECT * FROM piedrasmagicas.usuarias;`);

    await conn.end();

    const numOfElements = results.length;
    res.json({
        info: { count: numOfElements },
        results: results,

    });

});


//9º Endpoint LOGIN

app.post('/login', async (req, res) => {

  
    if( !req.body.nombre ) {
      return res.status(400).json({
        status: false,
        error: 'Oye, no has espeficicado el nombre de usuaria'
      })
    }
    if( !req.body.password ) {
      return res.status(400).json({
        status: false,
        error: 'Oye, no has espeficicado la contraseña'
      })
    }
  
    const conn = await getConnection();
  
    const [resultCheck] = await conn.query(
      `SELECT *
      FROM usuarias
      WHERE nombre = ?;`,
      [req.body.nombre]
    );
  
    if( resultCheck.length === 0 ) {
      return res.status(404).json({
        status: false,
        error: 'Las credenciales no son válidas'
      })
    }
  
    const [userData] = resultCheck;
    
    if( await bcrypt.compare(req.body.password, userData.password) ) {

        const payload = {
            userId: userData.id,
            email: userData.email,
            nombre: userData.nombre
        }

    const token = jwt.sign( payload, process.env.JWT_PASS, { expiresIn:'3h' } );

      res.json({
        success: true,
        token: token
      })
    }
    else {
      return res.status(404).json({
        status: false,
        error: 'Las credenciales no son válidas'
      });
    }
  
});