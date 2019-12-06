
CREATE TABLE auditoria(
	operacion varchar(10),
	fecha_hora timestamp,
	tabla varchar(30),
	usuario varchar(30),
	valor_anterior varchar,
	valor_nuevo varchar,
	Constraint Check_operacion check (operacion in ('INSERT', 'UPDATE', 'DELETE'))
);


CREATE OR REPLACE FUNCTION auditarPersona() RETURNS TRIGGER AS $funcemp$
DECLARE
BEGIN
	if (TG_OP = 'INSERT') THEN
		INSERT INTO auditoria(operacion, fecha_hora, tabla, usuario, valor_anterior, valor_nuevo) 
			VALUES(TG_OP, clock_timestamp(), TG_TABLE_NAME, CURRENT_USER, NULL, NEW);
	END IF;
	if (TG_OP = 'UPDATE') THEN
		INSERT INTO auditoria(operacion, fecha_hora, tabla, usuario, valor_anterior, valor_nuevo) 
			VALUES(TG_OP, clock_timestamp(), TG_TABLE_NAME, CURRENT_USER, OLD, NEW);
	END IF;
	if (TG_OP = 'DELETE') THEN
		INSERT INTO auditoria(operacion, fecha_hora, tabla, usuario, valor_anterior, valor_nuevo) 
			VALUES(TG_OP, clock_timestamp(), TG_TABLE_NAME, CURRENT_USER, OLD, NULL);
	END IF;
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_auditoria_persona AFTER
	INSERT OR UPDATE OR DELETE ON persona 
	FOR EACH ROW EXECUTE PROCEDURE auditarPersona();
