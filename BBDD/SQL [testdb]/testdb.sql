CREATE TABLE ciudad(
	cp int NOT null Check(cp>0 AND cp<10000),
	nombre varchar(40) NOT null,
	Constraint "dni_pkey" Primary Key (cp)
);

CREATE TABLE persona(
	legajo int[],
	dni int Check(dni>=00000000 and dni<=99999999] NOT null,
	apellido varchar(40),
	cp int Check(cp>0 and cp<10000),,
	Constraint "dni_pkey" Primary Key (legajo, dni),
	Foreign Key (cp) References ciudad(cp),
);