(defvar n);Variable parametro entero
(defvar e);Variable parametro exponente entero
(defvar lista);Variable parametro lista


;Calcular el Cuadrado de un numero
(defun cuadrado (n)
    (* n n)
)

(setq n 4)
(format t "~%El cuadrado de ~d es: ~d ~%" n (cuadrado n))


;Calcular el Factorial de un numero
(defun factorial (n)
    (if (= n 0) 1
        (* n (factorial (- n 1)))
    )
)

(setq n 5)
(format t "~%El factorial de ~d es: ~d ~%" n (factorial n))


;Calcular la Sumatoria de un numero
(defun sumatoria (n)
    (if (= n 0) 0
        (+ n (sumatoria (- n 1)))
    )
)

(setq n 3)
(format t "~%La sumatoria de ~d es: ~d ~%" n (sumatoria n))


;Calcular la Potencia de un numero
(defun potencia (n e)
    (if (= e 0) 1
        (* n (potencia n (- e 1)))
    )
)

(setq n 5)
(setq e 3)
(format t "~%La potencia de ~d a la ~d es: ~d ~%" n e (potencia n e))


;Cantidad de elementos de una lista
(defun len (l)
    (if l (1+ (len (rest l)))
        0
    )
)

(setq lista '(0 10 5 4 32 1))
(format t "~%La cantidad de elementos de la lista ~d es: ~d ~%" lista (len lista))


;Devolver el elemento menor de una lista
(defun menor (l)
    (cond
        ((null (rest l)) (first l))
        ((< (first l) (menor (rest l))) (first l))
        (t (menor (rest l)))
    )
)

(setq lista '(4 2 10 23 1 9 -1 3 0 -1 9))
(format t "~%El elemento menor de la lista ~d es: ~d ~%" lista (menor lista))

;Construir una lista nueva con los números de la lista menores que un valor dado
(defun menores (l n)
    (cond
        ((null l) nil)
        ((< (first l) n) (cons (first l) (menores (rest l) n)))
        (t (menores (rest l) n))
    )
)

(setq lista '(0 10 5 4 32 1))
(setq n 10)
(format t "~%Los elementos de la lista ~d menores que ~d son: ~d ~%" lista n (menores lista n))


;Cantidad de impares de una lista
(defun impares (l)
    (if (null l) 0
        (if (not (= (mod (first l) 2) 0)) (1+ (impares (rest l)))
            (+ (impares (rest l)))
        )
    )
)

(setq lista '(1 6 5 7 3))
(format t "~%La cantidad de elementos impares de la lista ~d es: ~d ~%" lista (impares lista))


;Porcentaje de impares de una lista
(defun porcentajeImpares (l)
    (* 100 (/ (impares l) (len l)))
)

(setq lista '(1 5 7 3 8 6))
(format t "~%El porcentaje de impares de la lista ~d es: %~2,2f ~%" lista (porcentajeImpares lista))


;Cantidad de veces que se repite el numero menor de una lista
(defun contarMenores (l menor)
    (cond
        ((null l) 0)
        ((= (first l) menor) (1+ (contarMenores (rest l) menor)))
        (t (contarMenores (rest l) menor))
    )
)

(setq lista '(4 2 10 -1 1 9 -1 3 0 -1 9))
(format t "~%La cantidad de veces que se repite el elemento menor ~d ~% en la lista ~d es: ~d ~%" (menor lista) lista (contarMenores lista (menor lista)))