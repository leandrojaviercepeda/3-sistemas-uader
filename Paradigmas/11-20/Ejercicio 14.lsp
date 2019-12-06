(DEFUN ELIMELEMLISTA(L ELEM)
  (COND
      ((NULL L) NIL)
      (T (COND 
          ((NOT (= (FIRST L) ELEM)) (CONS (FIRST L) (ELIMELEMLISTA (REST L) ELEM)))
          (t (ELIMELEMLISTA (REST L) ELEM)))))) 
       