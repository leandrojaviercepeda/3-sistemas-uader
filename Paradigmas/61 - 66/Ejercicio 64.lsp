(DEFUN NelementosCENTRO (L N) (ElementosIntervalo L (INICIOINTERVALO L N) N))

(DEFUN ElementosIntervalo(L INI FIN)
  (COND
   ((> INI 1) (ElementosIntervalo (REST L) (- INI 1) FIN))
   ((AND (= INI 1) (> FIN 0)) (CONS (FIRST L) (ElementosIntervalo (REST L) INI (- FIN 1))))
   (T NIL)))

(DEFUN InicioIntervalo (L N)
  (COND
   ((< (CANTIDAD L) N) 1)
   (T (- (FLOOR (/ (+ (CANTIDAD L) 1) 2)) (FLOOR (/ (- N 1) 2)) ))))

(DEFUN CANTIDAD (L)
  (COND
   ((NULL L) 0)
   (T (+ 1 (CANTIDAD (REST L))))))