(DEFUN ListaPosicion(L1 L2) (POSICIONES (APLANARLISTA L1) (APLANARLISTA L2)))

(DEFUN POSICIONES (L1 L2)
  (COND
   ((NULL L1) NIL)
   ((EXISTE L2 (FIRST L1)) (CONS (POSICION L2 (FIRST L1)) (POSICIONES (REST L1) L2)))
   (T (CONS 0 (POSICIONES (REST L1) L2)))))

(DEFUN POSICION (L N)
  (COND
   ((NULL L) 0)
   ((= (FIRST L) N) 1)
   (T (+ 1 (POSICION (REST L) N)))))

(DEFUN EXISTE (L N)
  (COND
   ((NULL L) NIL)
   ((= (FIRST L) N) T)
   (T (EXISTE (REST L) N))))

(DEFUN APLANARLISTA (L)
  (COND
   ((NULL L) NIL)
   ((LISTP (FIRST L)) (APPEND (APLANARLISTA (FIRST L)) (APLANARLISTA (REST L))))
   (T (CONS (FIRST L) (APLANARLISTA (REST L))))))