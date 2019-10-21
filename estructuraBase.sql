/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases 11.1.0                     */
/* Target DBMS:           PostgreSQL 11                                   */
/* Project file:          Project1.dez                                    */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Database creation script                        */
/* Created on:            2019-10-20 23:26                                */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Add tables                                                             */
/* ---------------------------------------------------------------------- */

/* ---------------------------------------------------------------------- */
/* Add table "Sucursal"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE Sucursal (
    id_sucursal SERIAL  NOT NULL,
    lugar CHARACTER(40),
    direccion CHARACTER(40),
    CONSTRAINT PK_Sucursal PRIMARY KEY (id_sucursal)
);

/* ---------------------------------------------------------------------- */
/* Add table "Ambiente"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE Ambiente (
    id_ambiente SERIAL  NOT NULL,
    nombre CHARACTER(40),
    descripcion CHARACTER(40),
    capacidad CHARACTER(40),
    disponible BOOLEAN,
    id_sucursal INTEGER  NOT NULL,
    CONSTRAINT PK_Ambiente PRIMARY KEY (id_ambiente)
);

/* ---------------------------------------------------------------------- */
/* Add table "Tipo_habitacion"                                            */
/* ---------------------------------------------------------------------- */

CREATE TABLE Tipo_habitacion (
    id_tipo_habitacion SERIAL  NOT NULL,
    nombre CHARACTER(40),
    CONSTRAINT PK_Tipo_habitacion PRIMARY KEY (id_tipo_habitacion)
);

/* ---------------------------------------------------------------------- */
/* Add table "Articulo"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE Articulo (
    id_articulo SERIAL  NOT NULL,
    nombre CHARACTER(40),
    id_ambiente INTEGER  NOT NULL,
    CONSTRAINT PK_Articulo PRIMARY KEY (id_articulo)
);

/* ---------------------------------------------------------------------- */
/* Add table "Mueble"                                                     */
/* ---------------------------------------------------------------------- */

CREATE TABLE Mueble (
    id_mueble SERIAL  NOT NULL,
    nombre CHARACTER(40),
    id_ambiente INTEGER  NOT NULL,
    CONSTRAINT PK_Mueble PRIMARY KEY (id_mueble)
);

/* ---------------------------------------------------------------------- */
/* Add table "Tipo_Personal"                                              */
/* ---------------------------------------------------------------------- */

CREATE TABLE Tipo_Personal (
    id_tipo_personal SERIAL  NOT NULL,
    nombre CHARACTER(40),
    CONSTRAINT PK_Tipo_Personal PRIMARY KEY (id_tipo_personal)
);

/* ---------------------------------------------------------------------- */
/* Add table "Descuento"                                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE Descuento (
    id_descuento SERIAL  NOT NULL,
    porcentaje INTEGER,
    temporada CHARACTER(40),
    CONSTRAINT PK_Descuento PRIMARY KEY (id_descuento)
);

/* ---------------------------------------------------------------------- */
/* Add table "Paquete_Turistico"                                          */
/* ---------------------------------------------------------------------- */

CREATE TABLE Paquete_Turistico (
    id_paquete_turistico SERIAL  NOT NULL,
    nombre CHARACTER(40),
    descripcion CHARACTER(40),
    id_descuento INTEGER  NOT NULL,
    CONSTRAINT PK_Paquete_Turistico PRIMARY KEY (id_paquete_turistico)
);

/* ---------------------------------------------------------------------- */
/* Add table "Pais"                                                       */
/* ---------------------------------------------------------------------- */

CREATE TABLE Pais (
    id_pais SERIAL  NOT NULL,
    nombre CHARACTER(40),
    CONSTRAINT PK_Pais PRIMARY KEY (id_pais)
);

/* ---------------------------------------------------------------------- */
/* Add table "Tipo_Especial"                                              */
/* ---------------------------------------------------------------------- */

CREATE TABLE Tipo_Especial (
    id_tipo_especial SERIAL  NOT NULL,
    nombre CHARACTER(40),
    CONSTRAINT PK_Tipo_Especial PRIMARY KEY (id_tipo_especial)
);

/* ---------------------------------------------------------------------- */
/* Add table "Deuda"                                                      */
/* ---------------------------------------------------------------------- */

CREATE TABLE Deuda (
    id_deuda SERIAL  NOT NULL,
    monto INTEGER,
    fecha DATE,
    activo BOOLEAN,
    id_sucursal INTEGER  NOT NULL,
    CONSTRAINT PK_Deuda PRIMARY KEY (id_deuda, id_sucursal)
);

/* ---------------------------------------------------------------------- */
/* Add table "Credito"                                                    */
/* ---------------------------------------------------------------------- */

CREATE TABLE Credito (
    id_credito SERIAL  NOT NULL,
    monto INTEGER,
    date CHARACTER(40),
    fecha DATE,
    activo BOOLEAN,
    id_sucursal INTEGER  NOT NULL,
    CONSTRAINT PK_Credito PRIMARY KEY (id_credito, id_sucursal)
);

/* ---------------------------------------------------------------------- */
/* Add table "Lugar"                                                      */
/* ---------------------------------------------------------------------- */

CREATE TABLE Lugar (
    id_lugar SERIAL  NOT NULL,
    nombre CHARACTER(40),
    descripcion CHARACTER(40),
    CONSTRAINT PK_Lugar PRIMARY KEY (id_lugar)
);

/* ---------------------------------------------------------------------- */
/* Add table "Paquete_Turistico_Lugar"                                    */
/* ---------------------------------------------------------------------- */

CREATE TABLE Paquete_Turistico_Lugar (
    id_lugar INTEGER  NOT NULL,
    id_paquete_turistico INTEGER  NOT NULL,
    CONSTRAINT PK_Paquete_Turistico_Lugar PRIMARY KEY (id_lugar, id_paquete_turistico)
);

/* ---------------------------------------------------------------------- */
/* Add table "Aseo"                                                       */
/* ---------------------------------------------------------------------- */

CREATE TABLE Aseo (
    id_aseo SERIAL  NOT NULL,
    fecha DATE,
    id_ambiente INTEGER  NOT NULL,
    CONSTRAINT PK_Aseo PRIMARY KEY (id_aseo, id_ambiente)
);

/* ---------------------------------------------------------------------- */
/* Add table "Especial"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE Especial (
    horario_atencion CHARACTER(40),
    id_ambiente INTEGER  NOT NULL,
    id_tipo_especial INTEGER  NOT NULL,
    CONSTRAINT PK_Especial PRIMARY KEY (id_ambiente)
);

/* ---------------------------------------------------------------------- */
/* Add table "Habitacion"                                                 */
/* ---------------------------------------------------------------------- */

CREATE TABLE Habitacion (
    numero INTEGER,
    id_ambiente INTEGER  NOT NULL,
    id_tipo_habitacion INTEGER  NOT NULL,
    CONSTRAINT PK_Habitacion PRIMARY KEY (id_ambiente)
);

/* ---------------------------------------------------------------------- */
/* Add table "Personal"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE Personal (
    id_personal SERIAL  NOT NULL,
    nombre CHARACTER(40),
    apellido_paterno CHARACTER(40),
    apellido_materno CHARACTER(40),
    fecha_contratacion DATE,
    turno CHARACTER(40),
    id_tipo_personal INTEGER  NOT NULL,
    id_pais INTEGER  NOT NULL,
    id_hotel INTEGER,
    CONSTRAINT PK_Personal PRIMARY KEY (id_personal)
);

/* ---------------------------------------------------------------------- */
/* Add table "Cliente"                                                    */
/* ---------------------------------------------------------------------- */

CREATE TABLE Cliente (
    id_cliente SERIAL  NOT NULL,
    nombre CHARACTER(40),
    apellido_paterno CHARACTER(40),
    apellido_materno CHARACTER(40),
    id_pais INTEGER  NOT NULL,
    CONSTRAINT PK_Cliente PRIMARY KEY (id_cliente)
);

/* ---------------------------------------------------------------------- */
/* Add table "Aseo_Personal"                                              */
/* ---------------------------------------------------------------------- */

CREATE TABLE Aseo_Personal (
    id_aseo INTEGER  NOT NULL,
    id_ambiente INTEGER  NOT NULL,
    id_personal INTEGER  NOT NULL,
    CONSTRAINT PK_Aseo_Personal PRIMARY KEY (id_aseo, id_ambiente, id_personal)
);

/* ---------------------------------------------------------------------- */
/* Add table "Reserva"                                                    */
/* ---------------------------------------------------------------------- */

CREATE TABLE Reserva (
    id_reserva SERIAL  NOT NULL,
    fecha DATE,
    id_cliente INTEGER  NOT NULL,
    id_personal INTEGER  NOT NULL,
    id_ambiente INTEGER,
    CONSTRAINT PK_Reserva PRIMARY KEY (id_reserva, id_cliente, id_personal)
);

/* ---------------------------------------------------------------------- */
/* Add table "Pago"                                                       */
/* ---------------------------------------------------------------------- */

CREATE TABLE Pago (
    id_pago CHARACTER(40)  NOT NULL,
    fecha DATE,
    monto INTEGER,
    id_reserva INTEGER  NOT NULL,
    id_cliente INTEGER  NOT NULL,
    id_personal INTEGER  NOT NULL,
    CONSTRAINT PK_Pago PRIMARY KEY (id_pago, id_reserva, id_cliente, id_personal)
);

/* ---------------------------------------------------------------------- */
/* Add table "Hospedaje"                                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE Hospedaje (
    id_hospedaje SERIAL  NOT NULL,
    fecha_inicio DATE,
    fecha_fin CHARACTER(40),
    id_paquete_turistico INTEGER  NOT NULL,
    id_reserva INTEGER  NOT NULL,
    id_cliente INTEGER  NOT NULL,
    id_personal INTEGER  NOT NULL,
    CONSTRAINT PK_Hospedaje PRIMARY KEY (id_hospedaje)
);

/* ---------------------------------------------------------------------- */
/* Add table "Hospedaje_Cliente"                                          */
/* ---------------------------------------------------------------------- */

CREATE TABLE Hospedaje_Cliente (
    id_hospedaje INTEGER  NOT NULL,
    id_cliente INTEGER  NOT NULL,
    PRIMARY KEY (id_hospedaje, id_cliente)
);

/* ---------------------------------------------------------------------- */
/* Add foreign key constraints                                            */
/* ---------------------------------------------------------------------- */

ALTER TABLE Ambiente ADD CONSTRAINT Sucursal_Ambiente 
    FOREIGN KEY (id_sucursal) REFERENCES Sucursal (id_sucursal);

ALTER TABLE Especial ADD CONSTRAINT Ambiente_Especial 
    FOREIGN KEY (id_ambiente) REFERENCES Ambiente (id_ambiente);

ALTER TABLE Especial ADD CONSTRAINT Tipo_Especial_Especial 
    FOREIGN KEY (id_tipo_especial) REFERENCES Tipo_Especial (id_tipo_especial);

ALTER TABLE Habitacion ADD CONSTRAINT Ambiente_Habitacion 
    FOREIGN KEY (id_ambiente) REFERENCES Ambiente (id_ambiente);

ALTER TABLE Habitacion ADD CONSTRAINT Tipo_habitacion_Habitacion 
    FOREIGN KEY (id_tipo_habitacion) REFERENCES Tipo_habitacion (id_tipo_habitacion);

ALTER TABLE Articulo ADD CONSTRAINT Ambiente_Articulo 
    FOREIGN KEY (id_ambiente) REFERENCES Ambiente (id_ambiente);

ALTER TABLE Mueble ADD CONSTRAINT Ambiente_Mueble 
    FOREIGN KEY (id_ambiente) REFERENCES Ambiente (id_ambiente);

ALTER TABLE Personal ADD CONSTRAINT Tipo_Personal_Personal 
    FOREIGN KEY (id_tipo_personal) REFERENCES Tipo_Personal (id_tipo_personal);

ALTER TABLE Personal ADD CONSTRAINT Pais_Personal 
    FOREIGN KEY (id_pais) REFERENCES Pais (id_pais);

ALTER TABLE Personal ADD CONSTRAINT Sucursal_Personal 
    FOREIGN KEY (id_hotel) REFERENCES Sucursal (id_sucursal);

ALTER TABLE Hospedaje ADD CONSTRAINT Paquete_Turistico_Hospedaje 
    FOREIGN KEY (id_paquete_turistico) REFERENCES Paquete_Turistico (id_paquete_turistico);

ALTER TABLE Hospedaje ADD CONSTRAINT Reserva_Hospedaje 
    FOREIGN KEY (id_reserva, id_cliente, id_personal) REFERENCES Reserva (id_reserva,id_cliente,id_personal);

ALTER TABLE Reserva ADD CONSTRAINT Cliente_Reserva 
    FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente);

ALTER TABLE Reserva ADD CONSTRAINT Personal_Reserva 
    FOREIGN KEY (id_personal) REFERENCES Personal (id_personal);

ALTER TABLE Reserva ADD CONSTRAINT Ambiente_Reserva 
    FOREIGN KEY (id_ambiente) REFERENCES Ambiente (id_ambiente);

ALTER TABLE Cliente ADD CONSTRAINT Pais_Cliente 
    FOREIGN KEY (id_pais) REFERENCES Pais (id_pais);

ALTER TABLE Pago ADD CONSTRAINT Reserva_Pago 
    FOREIGN KEY (id_reserva, id_cliente, id_personal) REFERENCES Reserva (id_reserva,id_cliente,id_personal);

ALTER TABLE Paquete_Turistico ADD CONSTRAINT Descuento_Paquete_Turistico 
    FOREIGN KEY (id_descuento) REFERENCES Descuento (id_descuento);

ALTER TABLE Hospedaje_Cliente ADD CONSTRAINT Hospedaje_Hospedaje_Cliente 
    FOREIGN KEY (id_hospedaje) REFERENCES Hospedaje (id_hospedaje);

ALTER TABLE Hospedaje_Cliente ADD CONSTRAINT Cliente_Hospedaje_Cliente 
    FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente);

ALTER TABLE Deuda ADD CONSTRAINT Sucursal_Deuda 
    FOREIGN KEY (id_sucursal) REFERENCES Sucursal (id_sucursal);

ALTER TABLE Credito ADD CONSTRAINT Sucursal_Credito 
    FOREIGN KEY (id_sucursal) REFERENCES Sucursal (id_sucursal);

ALTER TABLE Paquete_Turistico_Lugar ADD CONSTRAINT Lugar_Paquete_Turistico_Lugar 
    FOREIGN KEY (id_lugar) REFERENCES Lugar (id_lugar);

ALTER TABLE Paquete_Turistico_Lugar ADD CONSTRAINT Paquete_Turistico_Paquete_Turistico_Lugar 
    FOREIGN KEY (id_paquete_turistico) REFERENCES Paquete_Turistico (id_paquete_turistico);

ALTER TABLE Aseo ADD CONSTRAINT Ambiente_Aseo 
    FOREIGN KEY (id_ambiente) REFERENCES Ambiente (id_ambiente);

ALTER TABLE Aseo_Personal ADD CONSTRAINT Aseo_Aseo_Personal 
    FOREIGN KEY (id_aseo, id_ambiente) REFERENCES Aseo (id_aseo,id_ambiente);

ALTER TABLE Aseo_Personal ADD CONSTRAINT Personal_Aseo_Personal 
    FOREIGN KEY (id_personal) REFERENCES Personal (id_personal);

