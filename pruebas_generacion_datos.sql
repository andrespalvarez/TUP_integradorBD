-- Tablas semilla + producto cartesiano controlado

use pruebagendatos;

drop table nombres;
drop table apellidos;

CREATE TABLE nombres (nombre VARCHAR(50));
CREATE TABLE apellidos (apellido VARCHAR(50));

-- Insertás algunos valores semilla
INSERT INTO nombres VALUES ('Ana'), ('Luis'), ('Andres');
INSERT INTO apellidos VALUES ('Gómez'), ('Pérez'), ('Alvarez'), (null);

-- Combinás con CROSS JOIN
SELECT nombre, apellido FROM nombres CROSS JOIN apellidos;