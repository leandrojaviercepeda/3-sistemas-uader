(DEFUN NIVEL (L N)
  (COND
   ((NULL L) 0)
   ((AND (NUMBERP (FIRST L)) (= (FIRST L) N)) 1)
   ((AND (LISTP (FIRST L)) (EXISTE (LINEAL (FIRST L)) N)) (+ 1 (NIVEL (FIRST L) N)))
   (T (NIVEL (REST L) N))))

(DEFUN EXISTE (L N)
  (COND
     ((NULL L) NIL)
     ((= (FIRST L) N) T)
     (T (EXISTE (REST L) N))))

(DEFUN LINEAL (L)
(COND
     ((NULL L) NIL)
     ((LISTP (FIRST L)) (APPEND (LINEAL (FIRST L)) (LINEAL (REST L))))
     (T (CONS (FIRST L) (LINEAL (REST L))))))