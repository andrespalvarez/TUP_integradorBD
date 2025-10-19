CREATE SCHEMA if not exists Producto_CodBarras ;
use Producto_CodBarras;
-- --------------------------------------------------------
-- 						CREATE DE TABLAS
-- --------------------------------------------------------
-- crea tabla CodigoBarras
create table if not exists CodigoBarras (
 id int primary key,
 eliminado bool,
 tipo enum ("EAN13","EAN8","UPC") NOT NULL,
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
 codigoBarras int,
 foreign key (codigoBarras) references CodigoBarras(id) 
);
