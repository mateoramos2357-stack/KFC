create database saludtotal;

show DATABASES;

use saludtotal


create table medicionas
(   
    id int int primary KEY,
    nombre varchar (100),
    tipo char (3), -- gen de generico o COM de comercial
    precio decimal(15,2),
    stock int,
    fechacaducidad datetime 
);
create table clientes(   
    cedula char(10) PRIMARY KEY,
    nombre varchar(100),
    tipodepersona char(3),
    fechanacimiento DATE   
);

CREATE TABLE tratamientos (
    id_tratamiento INT PRIMARY KEY,
    enfermedad VARCHAR(100) NOT NULL,
    medicacion VARCHAR(100) NOT NULL
);


show tables;

desc medicinas;
desc clientes;

DESC tratamientos;

INSERT INTO tratamientos (id_tratamiento, enfermedad, medicacion) VALUES
(1, 'Hipertensión arterial', 'Losartán'),
(2, 'Diabetes mellitus', 'Metformina'),
(3, 'Hipotiroidismo', 'Levotiroxina');


INSERT into clientes
values (1729080877, 'mateo', 'NT', '2005-12-23')

INSERT INTO clientes
values (1792760320, 'roger', 'NT', '2004-12-05')

INSERT INTO clientes
values (1829023982, 'erick', 'NT', '2000-12-29')

--carga de datos iniciales
insert into medicinas
values (1.'Paracetamol', 'GEN', 1.50, 12, '2026-01-01 00:00:00')

insert into medicinas
values (2'heterogermina', 'GEN', 1.50, 12, '2028-01-01 00:00:00')

insert into medicinas
values (3'finalin', 'GEN', 1.50, 12, '2030-01-01 00:00:00')
select * from medicinas;

SELECT * from medicionas 

SELECT * FROM tratamientos;


show TABLES