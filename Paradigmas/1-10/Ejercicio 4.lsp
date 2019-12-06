(DEFUN VALORABSOLUTO(X)
  (COND
   ((< X 0) (* X (- 0 1)))
   (t X)))