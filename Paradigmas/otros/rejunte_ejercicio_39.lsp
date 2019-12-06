(DEFUN ORDENAR (L)
  (COND
  ((NULL L) NIL)
  (T (CONS (VALOR L (LAMBDA (X Y)(OR (< X Y) (= X Y)))) (ORDENAR (ELIM L (VALOR L (LAMBDA (X Y)(OR (< X Y) (= X Y))))))))))

(DEFUN ELIM (L N)
  (COND
   ((NULL L) NIL)
   ((= (FIRST L) N) (ELIM (REST L) N))
   (T (CONS (FIRST L) (ELIM (REST L) N)))))

(DEFUN VALOR(L CONDICION)
  (COND
  ((NULL (REST L)) (FIRST L))
  ((FUNCALL CONDICION (FIRST L) (FIRST (REST L))) (VALOR (CONS (FIRST L) (REST (REST L))) CONDICION))
  (T (VALOR (REST L) CONDICION))))

(DEFUN UPLAS(L N)
  (COND   
  ((NULL L) NIL)
  (T (CONS (UPLA L N) (UPLAS (ELIMINAR L N) N)))))
;upla toma los n-primeros elementos
(DEFUN UPLA(L N)
  (COND
   ((OR (= N 0) (NULL L)) NIL)
   (T (CONS (FIRST L) (UPLA (REST L) (- N 1))))))
;eliminar elimina los n-primeros elementos
(DEFUN ELIMINAR(L N)
  (COND
   ((= N 0) L)
   ((< (CANTIDAD L) N) NIL)
   (T (ELIMINAR (REST L) (- N 1)))))

(DEFUN CANTIDAD (L)
  (COND
   ((NULL L) 0)
   (T (+ 1 (CANTIDAD (REST L))))))