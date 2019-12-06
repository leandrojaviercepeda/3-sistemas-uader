#!/usr/bin/sbcl --script

;Dada una lista de numeros determinar cuantas veces se repite el numero menor

;Funcion para buscar elemento menor de la lista
(defun menor(l)
    (cond
        ((null (rest l)) (first l)) ;Si la lista tiene 1 solo elemento, lo devuelve 
        ((< (first l) (menor(rest l))) (first l)) ;Si el primero es menor que los demas (llamada recursiva), lo devuelve.
        (t (menor(rest l))) ;Sino ejecuta recursividad
    )
)


(defun contar(lista elemento)
    (cond 
        ((null (rest lista)) 0)
        ((= elemento (first lista)) (+ 1 (contar2 (rest lista) elemento)))
        (T (+ 0 (contar2 (rest lista) elemento)))
    )
)

(print (contar '(1 2 1 4 5 6 7) (menor '(1 2 1 4 5 6 7))) ) 
;La funcion menor calcula cual es el menor de la lista y lo deja guardado ahi, 
;eso es lo que yo usaba como variable para despues comparar si es igual con el first l, 
;y despues en la funcion contar va almacenando cuantas veces se repite el menor.


(defun minimo(l)
    (cond
        ((null (rest l)) (first l))
        ((< (first l) (first (rest l))) (minimo (cons (first l) (rest (rest l)) )))
        (t (minimo (rest l)))
    )
)