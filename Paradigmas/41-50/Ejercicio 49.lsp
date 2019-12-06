(DEFUN BINaDECIMAL(N) (TRANSFBINDEC N 0))

(DEFUN TRANSFBINDEC (N I)
  (COND
   ((= N 0) 0)
   ((= (MOD N 2) 0) (TRANSFBINDEC (FLOOR (/ N 10)) (+ I 1)))
   (T (+ (POTENCIA 2 I) (TRANSFBINDEC (FLOOR (/ N 10)) (+ I 1))))))

(DEFUN POTENCIA(X N)
  (COND
  ((= N 0) 1)
  (t (* X (POTENCIA X (- N 1))))))
