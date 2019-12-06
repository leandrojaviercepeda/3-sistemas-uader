#!/usr/bin/sbcl --script

(defun cantidad_impares (lista)
    (cond
        ((null lista) 0)
        ((not (= (mod (first lista) 2) 0)) (+ 1.0 (cantidad_impares (rest lista))))
        (T (cantidad_impares (rest lista)))
    )
)

(defun cantidad_elementos (lista)
    (if (null lista)
        0
        (+ 1.0 (cantidad_elementos (rest lista)))
    )
)

(defun porcentaje_impares (lista)
    (* 100 (/ (cantidad_impares lista) (cantidad_elementos lista)))
)

(print (porcentaje_impares '(1 1 1)))