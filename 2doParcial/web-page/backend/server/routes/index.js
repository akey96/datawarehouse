const express = require('express');

const app = express();

app.use(require('./hechos'));
module.exports = app;