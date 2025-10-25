CREATE SCHEMA if not exists Producto_CodBarras ;
use Producto_CodBarras;
-- --------------------------------------------------------
-- 						CREATE DE TABLAS
-- --------------------------------------------------------
-- crea tabla CodigoBarras (primero esta por la relacion q tiene con la otra tabla)
create table if not exists CodigoBarras (
 id int primary key,
 eliminado bool,
 tipo enum ('EAN13','EAN8','UPC') NOT NULL,
 valor varchar(20) NOT NULL UNIQUE,
 fechaImplantacion date,
 observaciones varchar(255) 
 );
-- crea tabla Producto
create table if not exists Producto (
 id int primary key,
 eliminado bool,
 nombre varchar(120) NOT NULL,
 marca varchar(80),
 categoria varchar(80),
 precio double(10,2) NOT NULL,
 peso double(10,3) CHECK(peso>0),
 codigoBarras int UNIQUE,
 foreign key (codigoBarras) references CodigoBarras(id) -- necesita que este creada la otra tabla
);
-- --------------------------------------------------------
-- 				PRUEBAS CON DATOS MANUALES
-- --------------------------------------------------------
-- inserciones correctas de prueba:
use Producto_CodBarras;
INSERT INTO CodigoBarras (id,eliminado,tipo,valor,fechaImplantacion,observaciones) VALUES
(1,false,'EAN13', 'valorprueba1','2025-10-19', "esta es una observacion de prueba"),
(2,false,'EAN13', 'valorprueba2','2025-10-19', "esta es una observacion de prueba"),
(3,false,'UPC', 'valorprueba3','2025-10-19', "esta es una observacion de prueba"),
(4,false,'EAN13', 'valorprueba4','2025-10-19', "esta es una observacion de prueba"),
(5,false,'EAN8', 'valorprueba5','2025-10-19', "esta es una observacion de prueba"),
(6,false,'EAN8', 'valorprueba6','2025-10-19', "esta es una observacion de prueba"),
(7,false,'EAN8', 'valorprueba7','2025-10-19', "esta es una observacion de prueba"),
(8,false,'UPC', 'valorprueba8','2025-10-19', "esta es una observacion de prueba"),
(9,false,'EAN8', 'valorprueba9','2025-10-19', "esta es una observacion de prueba"),
(10,false,'EAN13', 'valorprueba10','2025-10-19', "esta es una observacion de prueba");

INSERT INTO Producto (id,eliminado,nombre,marca,categoria,precio, peso, codigoBarras) VALUES
(1,false,'producto', 'marca','categoria',150, 55, 1),
(2,false,'producto', 'marca','categoria',150, 55, 2),
(3,false,'producto', 'marca','categoria',150, 55, 3),
(4,false,'producto', 'marca','categoria',150, 55, 4),
(5,false,'producto', 'marca','categoria',150, 55, 5),
(6,false,'producto', 'marca','categoria',150, 55, 6),
(7,false,'producto', 'marca','2categoria',150, 55, 7),
(8,false,'producto', 'marca','categoria',150, 55, 8),
(9,false,'producto', 'marca','categoria',150, 55, 9),
(10,false,'producto', 'marca','categoria',150, 55, 10);

-- prueba de inserciones incorrectas (utilizando updates)
SET session sql_mode = 'STRICT_ALL_TABLES';
-- SET SESSION sql_mode = REPLACE(@@SESSION.sql_mode, 'STRICT_ALL_TABLES', '');

-- error tipo de dato:
update Producto set id = "false" where id=2;
update CodigoBarras set fechaImplantacion = "hola mundo" where id=1;

-- error NOT NULL
update Producto set nombre = null where id=2;
update CodigoBarras set id = null where id=1;

-- error UNIQUE
update CodigoBarras set valor = "valorprueba1" where id=2;

-- error CHECK
update Producto set peso = 0 where id = 2;

-- prueba relacion 1:1
update Producto set codigoBarras = 1 where id=2;