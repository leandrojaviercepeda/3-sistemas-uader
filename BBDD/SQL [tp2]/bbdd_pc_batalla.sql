
begin work;
set constraints all deferred;

CREATE TABLE "pc" (
	"cod" smallint NOT NULL,
	"veloc" smallint NOT NULL,
	"ram" smallint NOT NULL,
	"hd" smallint NOT NULL,
	"precio" smallint NOT NULL,
	Constraint "pc_pkey" Primary Key ("cod")
);


CREATE TABLE "laptop" (
	"cod" smallint NOT NULL,
	"veloc" smallint NOT NULL,
	"ram" smallint NOT NULL,
	"pantalla" smallint NOT NULL,
	"precio" smallint NOT NULL,
	"hd" decimal(4,2) NOT NULL,
	Constraint "laptop_pkey" Primary Key ("cod")
);


CREATE TABLE "impresora" (
	"cod" smallint NOT NULL,
	"color" boolean NOT NULL,
	"tipo" character(8) NOT NULL,
	"precio" smallint NOT NULL,
	Constraint "impresora_pkey" Primary Key ("cod")
);


CREATE TABLE "producto" (
	"fabricante" character(1) NOT NULL,
	"cod" smallint NOT NULL,
	"tipo" character(8) NOT NULL,
	Constraint "producto_pkey" Primary Key ("cod")
);


CREATE TABLE "barco" (
	"nombre" character varying(32) NOT NULL,
	"clase" character varying(10) NOT NULL,
	"botado" smallint NOT NULL,
	Constraint "barco_pkey" Primary Key ("nombre")
);


CREATE TABLE "batalla" (
	"nombre" character varying(32) NOT NULL,
	"fecha" date NOT NULL,
	Constraint "batalla_pkey" Primary Key ("nombre")
);


CREATE TABLE "participa" (
	"barco" character varying(32) NOT NULL,
	"batalla" character varying(32) NOT NULL,
	"resultado" character varying(15) NOT NULL,
	Constraint "participa_pkey" Primary Key ("barco", "batalla")
);


CREATE TABLE "clase" (
	"clase" character varying(15) NOT NULL,
	"tipo" character(2) NOT NULL,
	"pais" character varying(15) NOT NULL,
	"caniones" smallint NOT NULL,
	"calibre" smallint NOT NULL,
	"desplazamiento" integer NOT NULL,
	Constraint "clase_pkey" Primary Key ("clase")
);



INSERT INTO barco (nombre, clase, botado) VALUES ('California', 'Tennessee', 1921);
INSERT INTO barco (nombre, clase, botado) VALUES ('Haruna', 'Kongo', 1915);
INSERT INTO barco (nombre, clase, botado) VALUES ('Hiei', 'Kongo', 1914);
INSERT INTO barco (nombre, clase, botado) VALUES ('Iowa', 'Iowa', 1943);
INSERT INTO barco (nombre, clase, botado) VALUES ('Karishima', 'Kongo', 1915);
INSERT INTO barco (nombre, clase, botado) VALUES ('Kongo', 'Kongo', 1913);
INSERT INTO barco (nombre, clase, botado) VALUES ('Missouri', 'Iowa', 1944);
INSERT INTO barco (nombre, clase, botado) VALUES ('Masashi', 'Yamato', 1942);
INSERT INTO barco (nombre, clase, botado) VALUES ('New Jersey', 'Iowa', 1943);
INSERT INTO barco (nombre, clase, botado) VALUES ('North Carolina', 'North Car', 1941);
INSERT INTO barco (nombre, clase, botado) VALUES ('Ramillies', 'Revenge', 1917);
INSERT INTO barco (nombre, clase, botado) VALUES ('Renown', 'Renown', 1916);
INSERT INTO barco (nombre, clase, botado) VALUES ('Repulse', 'Renown', 1916);
INSERT INTO barco (nombre, clase, botado) VALUES ('Resolution', 'Revenge', 1916);
INSERT INTO barco (nombre, clase, botado) VALUES ('Revenge', 'Revenge', 1916);
INSERT INTO barco (nombre, clase, botado) VALUES ('Reyal Oak', 'Revenge', 1916);
INSERT INTO barco (nombre, clase, botado) VALUES ('Royal Sovereign', 'Revenge', 1916);
INSERT INTO barco (nombre, clase, botado) VALUES ('Tennessee', 'Tennessee', 1920);
INSERT INTO barco (nombre, clase, botado) VALUES ('Washington', 'North Car', 1941);
INSERT INTO barco (nombre, clase, botado) VALUES ('Wisconsin', 'Iowa', 1944);
INSERT INTO barco (nombre, clase, botado) VALUES ('Yamato', 'Yamato', 1941);


INSERT INTO batalla (nombre, fecha) VALUES ('Guadalcanal', '1942-11-15');
INSERT INTO batalla (nombre, fecha) VALUES ('Cabo Norte', '1943-12-26');
INSERT INTO batalla (nombre, fecha) VALUES ('Estrecho Surigao', '1944-10-25');
INSERT INTO batalla (nombre, fecha) VALUES ('Atlantico Norte', '1941-05-24');


INSERT INTO clase (clase, tipo, pais, caniones, calibre, desplazamiento) VALUES ('Bismarck', 'Bb', 'Alemania', 8, 15, 42000);
INSERT INTO clase (clase, tipo, pais, caniones, calibre, desplazamiento) VALUES ('Iowa', 'Bb', 'EEUU', 9, 16, 46000);
INSERT INTO clase (clase, tipo, pais, caniones, calibre, desplazamiento) VALUES ('Kongo', 'Bc', 'Japón', 8, 14, 32000);
INSERT INTO clase (clase, tipo, pais, caniones, calibre, desplazamiento) VALUES ('North Carolina', 'Bb', 'EEUU', 9, 16, 37000);
INSERT INTO clase (clase, tipo, pais, caniones, calibre, desplazamiento) VALUES ('Renown', 'Bc', 'GB', 6, 15, 32000);
INSERT INTO clase (clase, tipo, pais, caniones, calibre, desplazamiento) VALUES ('Revenge', 'Bb', 'GB', 8, 15, 29000);
INSERT INTO clase (clase, tipo, pais, caniones, calibre, desplazamiento) VALUES ('Tennessee', 'Bb', 'EEUU', 12, 14, 32000);
INSERT INTO clase (clase, tipo, pais, caniones, calibre, desplazamiento) VALUES ('Yamato', 'Bb', 'Japón', 9, 18, 65000);


INSERT INTO impresora (cod, color, tipo, precio) VALUES (3001, true, 'Ink-jet ', 275);
INSERT INTO impresora (cod, color, tipo, precio) VALUES (3002, true, 'Ink-jet ', 269);
INSERT INTO impresora (cod, color, tipo, precio) VALUES (3003, true, 'Laser   ', 829);
INSERT INTO impresora (cod, color, tipo, precio) VALUES (3004, false, 'Laser   ', 879);
INSERT INTO impresora (cod, color, tipo, precio) VALUES (3005, false, 'Ink-jet ', 180);
INSERT INTO impresora (cod, color, tipo, precio) VALUES (3006, true, 'Impacto ', 470);


INSERT INTO laptop (cod, veloc, ram, pantalla, precio, hd) VALUES (2001, 100, 20, 110, 95, 1.10);
INSERT INTO laptop (cod, veloc, ram, pantalla, precio, hd) VALUES (2002, 117, 12, 75, 113, 0.75);
INSERT INTO laptop (cod, veloc, ram, pantalla, precio, hd) VALUES (2003, 117, 32, 100, 104, 1.00);
INSERT INTO laptop (cod, veloc, ram, pantalla, precio, hd) VALUES (2004, 133, 16, 110, 112, 1.10);
INSERT INTO laptop (cod, veloc, ram, pantalla, precio, hd) VALUES (2005, 133, 16, 100, 113, 1.00);
INSERT INTO laptop (cod, veloc, ram, pantalla, precio, hd) VALUES (2006, 120, 8, 81, 121, 0.81);
INSERT INTO laptop (cod, veloc, ram, pantalla, precio, hd) VALUES (2007, 150, 16, 135, 121, 1.35);
INSERT INTO laptop (cod, veloc, ram, pantalla, precio, hd) VALUES (2008, 120, 16, 110, 121, 1.10);


INSERT INTO participa (barco, batalla, resultado) VALUES ('California', 'Estrecho Surigao', 'Intacto');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Duke of York', 'Cabo Norte', 'Intacto');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Fuso', 'Estrecho Surigao', 'Hundido');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Hood', 'Atlantico Norte', 'Hundido');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Kirishima', 'Guadalcanal', 'Hundido');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Scharnhorst', 'Cabo Norte', 'Hundido');
INSERT INTO participa (barco, batalla, resultado) VALUES ('South Dakota', 'Guadalcanal', 'Dañado');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Tennessee', 'Estrecho Surigao', 'Intacto');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Washington', 'Gadalcanal', 'Intacto');
INSERT INTO participa (barco, batalla, resultado) VALUES ('West Virginia', 'Estrecho Surigao', 'Intacto');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Yamashiro', 'Estrecho Surigao', 'Hundido');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Bismark', 'Atantico Norte', 'Hundido');
INSERT INTO participa (barco, batalla, resultado) VALUES ('King George V', 'Atlantico Norte', 'Intacto');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Prince of Wales', 'Atlantico Norte', 'Dañado');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Rodney', 'Atantico Norte', 'Intacto');


INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1001, 133, 16, 16, 6);
INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1002, 120, 16, 16, 6);
INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1003, 166, 24, 25, 6);
INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1004, 166, 32, 25, 8);
INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1005, 166, 16, 20, 8);
INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1006, 200, 32, 31, 8);
INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1007, 200, 32, 32, 8);
INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1008, 180, 32, 20, 8);
INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1009, 200, 32, 25, 8);
INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1010, 160, 16, 12, 8);


INSERT INTO producto (fabricante, cod, tipo) VALUES ('A', 1001, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('A', 1002, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('A', 1003, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('B', 1004, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('B', 1006, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('B', 3002, 'Impresor');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('B', 3004, 'Impresor');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('C', 1005, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('C', 1007, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('D', 1008, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('D', 1009, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('D', 1010, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('D', 2001, 'Laptop  ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('D', 2002, 'Laptop  ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('D', 2003, 'Laptop  ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('D', 3001, 'Impresor');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('D', 3003, 'Impresor');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('E', 2004, 'Laptop  ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('E', 2008, 'Laptop  ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('F', 2005, 'Laptop  ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('G', 2006, 'Laptop  ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('G', 2007, 'Laptop  ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('H', 3005, 'Impresor');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('I', 3006, 'Impresor');


CREATE UNIQUE INDEX "participa_barco_batalla" on "participa" using btree ( "barco" "varchar_ops", "batalla" "varchar_ops" );




GRANT ALL ON  "pc"  TO PUBLIC ;
GRANT ALL ON  "laptop"  TO PUBLIC ;
GRANT ALL ON  "impresora"  TO PUBLIC ;
GRANT ALL ON  "producto"  TO PUBLIC ;
GRANT ALL ON  "barco"  TO PUBLIC ;
GRANT ALL ON  "batalla"  TO PUBLIC ;
GRANT ALL ON  "participa"  TO PUBLIC ;
GRANT ALL ON  "clase"  TO PUBLIC ;


commit;
