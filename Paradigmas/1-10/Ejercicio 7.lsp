(DEFUN CANTIDAD(L)
  (COND
   ((NULL L) 0)
   (t (+ 1 (CANTIDAD (REST L))))))