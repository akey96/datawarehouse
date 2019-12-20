// ======================
// PUERTO
// ======================
process.env.PORT = process.env.PORT || 8080

// ======================
// ENTORNO
// ======================

process.env.NODE_ENV = process.env.NODE_ENV || 'dev'

// ======================
// Base de DATOS
// ======================

process.env.DB_USER = process.env.DB_USER || 'postgres'
process.env.DB_HOST = process.env.DB_HOST || 'localhost'
process.env.DB_PASSWORD = process.env.DB_PASSWORD || 'pepito1234'
process.env.DB_PORT = process.env.DB_PORT || 5432
process.env.DB_DATABASE = process.env.DB_DATABASE || 'dataoutput'