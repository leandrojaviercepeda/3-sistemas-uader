(DEFUN MaquinaTuringSumadora(L)
  (COND
   ((NULL (REST L)) NIL)
   ((= (FIRST L) 0) (CONS (FIRST L) (MaquinaTuringSumadora (REST L))))
   (T (CONS 0 (MaquinaTuringSumadora (REST L))))))