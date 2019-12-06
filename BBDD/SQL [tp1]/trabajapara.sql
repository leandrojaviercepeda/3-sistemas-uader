--Ejercicio 6

CREATE TABLE trabajapara(
	dni int,
	codigo int,
	horas int,
	PRIMARY KEY(dni, codigo),
	FOREIGN KEY(dni) REFERENCES empleado(dni),
	FOREIGN KEY(codigo) REFERENCES departamento(codigo)
);


--Ejercicio 6
INSERT INTO trabajapara VALUES(25100000, 1, 8);
INSERT INTO trabajapara VALUES(25100000, 2, 4);
INSERT INTO trabajapara VALUES(29332501, 2, 8);
INSERT INTO trabajapara VALUES(19302500, 4, 8);
INSERT INTO trabajapara VALUES(33001321, 4, 8);
INSERT INTO trabajapara VALUES(22958543, 2, 8);
INSERT INTO trabajapara VALUES(33387695, 1, 8);
INSERT INTO trabajapara VALUES(25321542, 1, 8);
INSERT INTO trabajapara VALUES(27123456, 2, 8);
INSERT INTO trabajapara VALUES(13334401, 4, 8);
INSERT INTO trabajapara VALUES(35254310, 4, 4);


