(DEFUN PROMmaxMIN (L) (CONS (MEDIA L) (CONS (MAXIMO L) (CONS (MINIMO L) NIL))))

(DEFUN MEDIA(L) (/ (SUMATORIA L) (CANTIDAD L)))

(DEFUN CANTIDAD(L)
  (COND
   ((NULL L) 0)
   (t (+ 1 (CANTIDAD (REST L))))))

(DEFUN SUMATORIA(L)
  (COND
   ((NULL L) 0)
   (t (+ (FIRST L) (SUMATORIA (REST L))))))

(DEFUN MAXIMO(L)
  (COND
   ((NULL (REST L)) (FIRST L))
   ((> (FIRST L) (FIRST (REST L))) (MAXIMO (CONS (FIRST L) (REST (REST L)) )))
   (T (MAXIMO (REST L)))))

(DEFUN MINIMO(L)
  (COND
   ((NULL (REST L)) (FIRST L))
   ((< (FIRST L) (FIRST (REST L))) (MINIMO (CONS (FIRST L) (REST (REST L)) )))
   (T (MINIMO (REST L)))))

   
   