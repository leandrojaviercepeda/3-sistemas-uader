#!/usr/bin/sbcl --script

;./funciones.lisp


(defun cuadrado (n)
  (* n n)
)


(defun factorial (n)
  (if (= n 0) 1
      (* n (factorial (- n 1)))
  )
)


(defun sumatoria (n)
  (if (= n 0) 0
      (+ n (sumatoria (- n 1)))
  )
)


(defun potencia (b e)
  (if (= e 0) 1
      (* b (potencia b (- e 1)))
  )
)


(defun len (l)
  (if l (1+ (len (rest l)))
      0
  )
)


(defun minimo(L)
  (cond
   ((null (rest L)) (first L))
   ((< (first L) (first (rest L))) (minimo (cons (first L) (rest (rest L)) )))
   (t (minimo (rest L)))
  )
)


(defun menor (l)
  (cond
    ((null (rest l)) (first l))
    ((< (first l) (menor (rest l))) (first l))
    (t (menor (rest l)))
  )
)


(defun menores(n l)
  (cond
    ((null l) nil)
    ((< (first l) n) (cons (first l) (menores n (rest l))))
    (t (menores n (rest l)))
  )
)


(trace menores)
(write(menores 4'(5 2 0 6 9 4 3 6)))