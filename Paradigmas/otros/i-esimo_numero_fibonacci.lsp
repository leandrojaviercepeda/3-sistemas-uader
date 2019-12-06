(DEFUN FIBO(N)
  (COND
   ((= N 1) 0)
   ((= N 2) 1)
   (t (+ (FIBO (- N 1)) (FIBO (- N 2))))))