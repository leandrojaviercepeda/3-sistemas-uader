(DEFUN  COLLECT (L BLOQUE)
  (COND
   ((NULL L) NIL)
   (T (CONS (FUNCALL BLOQUE (FIRST L)) (COLLECT (REST L) BLOQUE)))))