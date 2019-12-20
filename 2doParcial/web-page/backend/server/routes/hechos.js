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
        let query = await client.query('SELECT lugar_hotel, total, promedio, mediana, minimo, maximo FROM hechos_pagos_estadisticos as hst, dim_lugar_hotel as dh where hst.id_dim_lugar_hotel= dh.id_dim_lugar_hotel');
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
        let query = await client.query('SELECT id, nombre_hotel, lugar_hotel, reservas2017, reservas2018, reservas2019, porcentaje_crecimiento_reserva_2018, porcentaje_crecimiento_reserva_2019 FROM hechos_reserva_habitaciones_ambientes hrha, dim_nombre_hotel dnh, dim_lugar_hotel dlh where hrha.id_dim_nombre_hotel = dnh.id_dim_nombre_hotel and hrha.id_dim_lugar_hotel = dlh.id_dim_lugar_hotel');
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
        let query = await client.query('SELECT id, paquete_turistico, demanda_2017, demanda_2018, demanda_2019, porcentaje_crecimiento_2018, porcentaje_crecimiento_2019 FROM hechos_demanda_paquetes_turisticos hpqt, dim_paquete_turistico dpt where hpqt.id_dim_paquete_turistico = dpt.id_dim_paquete_turistico');
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