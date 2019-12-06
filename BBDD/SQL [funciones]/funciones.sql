
-- Funciones

/*
CREATE FUNCTION nombre(type param1, type param2, type param3) RETURNS SETOF type AS $functype$
DECLARE
    variable1 type;
    variable2 type;
    variable3 type;
BEGIN
    $param1; --Do something
    $param2; --Do something
    $param3; --Do something

    variable1 := foo;
    variable2 := foo;
    variable3 := foo;

    RETURN some;
END; $functype$ LANGUAGE language;
*/