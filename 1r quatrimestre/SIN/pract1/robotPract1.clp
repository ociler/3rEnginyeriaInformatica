;D = DOMINI ("COL INICIAL" "COL FINAL"; E = ESCALA; CC = LLISTA CAIXES; XX = LLISTA ENEMICS
(deffacts bf (D 1 11)
	     (B 5 2) (B 3 3) (B 8 3) (B 6 4) (B 4 4)
	     (E 3 1) (E 2 2) (E 1 3) (E 7 3) (E 7 1) (E 10 2) (E 11 3)
	     (R 1 1 2 CC C 4 3 C 3 4 C 11 2 XX X 4 2 X 8 2 X 8 4))


(defrule pu
    (R ?c ?f $?r) (E ?c ?f)
     =>
     (printout t "puja!" crlf)
    (assert (R ?c (+ ?f 1) $?r)))


(defrule ba
    (R ?c ?f $?r) (E ?c ?fe)
   ;pq pos de les escales en la base. Si vuic baixar, he de mirar si hi ha escala baix
    (test (= ?f (+ 1 ?fe)))
     =>
     (printout t "baixa!" crlf)
    (assert (R ?c (- ?f 1) $?r)))


(defrule es
    (R ?c ?f ?t CC $?cc XX $?xx)
    (D ?cd ?)
    (test (> ?c ?cd))
    (not (B =(- ?c 1) ?f))
    (test (not (member$ (create$ X (- ?c 1) ?f) $?xx))) ;"cree" un enemic a la casella de la meua esquerra i mire si ja existeix en $?xx, es a dir, la llista d'enemics
    =>
    (printout t "esquerra!" crlf)
    (assert (R (- ?c 1) ?f ?t CC $?cc XX $?xx)))


(defrule dr
    (R ?c ?f ?t CC $?cc XX $?xx)
    (D ? ?cd)
    ;no puc fer lo de (B ?cx ?f) pq per a fer matching deuria existir eixe buit
    (not (B =(+ ?c 1) ?f))
    (test (< ?c ?cd))
    (test (not (member$ (create$ X (+ ?c 1) ?f) $?xx)))
    =>
    (printout t "dreta!" crlf)
    (assert (R (+ ?c 1) ?f ?t CC $?cc XX $?xx)))


(defrule ar
    (R ?c ?f ?t CC $?cci C ?c ?f $?ccf XX $?xx)
    =>
    (printout t "arreplegue caixa!" crlf)
    (assert (R ?c ?f ?t CC $?cci $?ccf XX $?xx)))
    ;el que fem es fer matching nomes si una caixa està al mateix lloc que està el robot. Si ho està, posem al fact tot menys eixa caixa, pq està ja recollida.


(defrule di
    (R ?c ?f ?t CC $?cc XX $?xxi X ?cx ?f $?xxf)
    (test (or (= ?c (+ ?cx 1)) (= ?c (- ?cx 1))))
    (test (> ?t 0))
    =>
    (printout t "PUUUUUM!" crlf)
    (assert (R ?c ?f (- ?t 1) CC $?cc XX $?xxi $?xxf)))
    

(defrule obj (declare (salience 1))
    (R $?ri CC XX $?rf)
    =>
    (printout t "Solucio trobada!" crlf) (halt)
    )


(watch facts)
(watch activations)
(set-strategy depth) ;cal provar depth i breadth
(reset)
(run)
(exit)