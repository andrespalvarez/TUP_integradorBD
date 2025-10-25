-- Tablas semilla + producto cartesiano controlado
create schema if not exists pruebagendatos;
use pruebagendatos;

-- drop table producto;

create table if not exists CodigoBarras (
 id int primary key,
 eliminado bool default false,
 tipo enum ('EAN13','EAN8','UPC') NOT NULL,
 valor varchar(20) NOT NULL UNIQUE,
 fechaImplantacion date,
 observaciones varchar(255) 
 );
 TRUNCATE TABLE CodigoBarras;

create table if not exists producto (
 id INT AUTO_INCREMENT PRIMARY KEY,
 eliminado bool default false,
 nombre varchar(120) NOT NULL,
 marca varchar(80),
 categoria varchar(80),
 precio double(10,2) NOT NULL,
 peso double(10,3) CHECK(peso>0),
 codigoBarras int UNIQUE,
 foreign key (codigoBarras) references CodigoBarras(id) -- necesita que este creada la otra tabla
);
TRUNCATE TABLE producto;
-- ////////////// esta seccion crea el nombre de los productos con tabla semilla y concat() ///////////////////
CREATE TABLE if not exists tipoproducto (tipoproducto VARCHAR(20));TRUNCATE TABLE tipoproducto;

CREATE TABLE if not exists formaproducto (formaproducto VARCHAR(20));TRUNCATE TABLE formaproducto;

CREATE TABLE if not exists materialproducto (materialproducto VARCHAR(20));TRUNCATE TABLE materialproducto;

CREATE TABLE if not exists colorproducto (colorproducto VARCHAR(20));TRUNCATE TABLE colorproducto;

CREATE TABLE if not exists calidadproducto (calidadproducto VARCHAR(20));TRUNCATE TABLE calidadproducto;

-- valores semilla
INSERT INTO tipoproducto VALUES ('mesa'), ('silla'), ('banco'), ('estante'), ('escritorio'), ('cómoda'), ('biblioteca');
INSERT INTO formaproducto VALUES ('rectangular'), ('circular'), ('triangular'), ('eliptico'), ('triangular'), (null);
INSERT INTO materialproducto VALUES ('hierro'), ('madera'), ('acrilico'), ('aluminio'), ('cartón'), ('goma'), ('lona'), (null);
INSERT INTO colorproducto VALUES ('blanco'), ('negro'), ('gris'), ('verde'), ('rojo'), ('azul'), ('violeta'), ('anaranjado'), ('amarillo'), (null);
INSERT INTO calidadproducto VALUES ('básica'), ('intermedia'), ('completa'), ('premium');

INSERT INTO producto (nombre)
SELECT CONCAT(tipoproducto,' ', COALESCE(calidadproducto, ''),' ', COALESCE(formaproducto, ''),' ', COALESCE(materialproducto, ''),' ', COALESCE(colorproducto, ''))
FROM tipoproducto
CROSS JOIN formaproducto
CROSS JOIN materialproducto
cross join colorproducto
cross join calidadproducto;
-- //////////////////////////////////fin creacion de nombres////////////////////////////////////////////////////


select * from producto;