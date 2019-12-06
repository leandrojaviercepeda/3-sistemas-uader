(DEFUN TRANSFORMARdeBINaDEC(N) (TRANSFORMAR N 0))

(DEFUN TRANSFORMAR (N I)
  (COND
   ((= N 0) 0)
   (T (+ (* (MOD N 2) (POTENCIA 10 I)) (TRANFORM (FLOOR (/ N 2)) (+ I 1)))))) 
   
(DEFUN POTENCIA(X N)
  (COND
  ((= N 0) 1)
  (t (* X (POTENCIA X (- N 1))))))
