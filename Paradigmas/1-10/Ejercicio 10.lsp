(DEFUN ELEMENTOIESIMO(L I)
    (COND
     ((= I 1) (FIRST L))
     (t (ELIMINARELEMLISTA (REST L) (- I 1)))))
   