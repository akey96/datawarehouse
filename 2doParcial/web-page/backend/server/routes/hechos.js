const express = require('express');
// importacion de underscore
const _ = require('underscore');

const app = express();
const { Client } = require('pg');

let connectionData = {
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_DATABASE,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT
};

let client = new Client(connectionData);
client.connect();

app.get('/hechos-pagos', async(req, res) => {

    try {
        let query = await client.query('SELECT * FROM hechos_pagos');
        return res.json({
            ok: true,
            message: query.rows
        });
    } catch (e) {
        return res.status(400).json({
            ok: false,
            error: e.toString()
        });
    }
});

app.get('/hechos-pagos-estadisticos', async(req, res) => {

    try {
        let query = await client.query('SELECT * FROM hechos_pagos_estadisticos');
        return res.json({
            ok: true,
            message: query.rows
        });
    } catch (e) {
        return res.status(400).json({
            ok: false,
            error: e.toString()
        })
    }
})

app.get('/hechos-reserva-habitaciones-ambientes', async(req, res) => {

    try {
        let query = await client.query('SELECT * FROM hechos_reserva_habitaciones_ambientes');
        return res.json({
            ok: true,
            message: query.rows
        });
    } catch (e) {
        return res.status(400).json({
            ok: false,
            error: e.toString()
        });
    }
})

app.get('/hechos-demanda-paquetes-turisticos', async(req, res) => {

    try {
        let query = await client.query('SELECT * FROM hechos_demanda_paquetes_turisticos');
        return res.json({
            ok: true,
            message: query.rows
        });
    } catch (e) {
        return res.status(400).json({
            ok: false,
            error: e.toString()
        });
    }
});

module.exports = app;