(DEFUN MAYORFIBONACCIMENOR(N) (MAYORFIBOMENOR N 1))

(DEFUN MAYORFIBOMENOR (N I)
  (COND
   ((< (FIBO I) N) (MAYORFIBOMENOR N (+ I 1)))
   (T (FIBO(- I 1)))))

(DEFUN FIBO(N)
  (COND
   ((= N 1) 0)
   ((= N 2) 1)
   (t (+ (FIBO (- N 1)) (FIBO (- N 2))))))