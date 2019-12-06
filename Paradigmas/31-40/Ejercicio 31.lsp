(DEFUN FUNCPOLINOMICA (N L) (POLINOMIO N L 0))

(DEFUN POLINOMIO (N L I)
  (COND
   ((NULL L) 0)
   (T (+ (* (FIRST L) (POTENCIA N I)) (POLINOMIO N (REST L) (+ I 1))))))

(DEFUN POTENCIA(X N)
  (COND
  ((= N 0) 1)
  (t (* X (POTENCIA X (- N 1))))))