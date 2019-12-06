(DEFUN LISTAcondicion (L ELEM COND)
  (COND
   ((NULL L) NIL)
   ((FUNCALL COND (FIRST L) ELEM) (CONS (FIRST L) (LISTAcondicion (REST L) ELEM COND)))
   (T (LISTAcondicion (REST L) ELEM COND))))

(DEFUN QUICKSORT(L)
(COND
   ((NULL L) NIL)
   ((NULL (REST L)) L)
   (T (APPEND (QUICKSORT (LISTAcondicion (REST L) (FIRST L) (LAMBDA (X Y) (< X Y)))) 
              (CONS (FIRST L) (QUICKSORT (LISTAcondicion (REST L) (FIRST L) (LAMBDA (X Y) (OR (> X Y) (= X Y))))))))))
