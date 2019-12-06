BEGIN WORK;

UPDATE escuela
set idcircuito = 4
where idesc>= 12 OR idesc>=15;

COMMIT;