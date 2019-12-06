(DEFUN POTENCIA(X N)
  (COND
  ((= N 0) 1)
  (t (* X (POTENCIA X (- N 1))))))