#lang racket
(require "TP2-Journal.rkt")
(require "TP2-Journaux-enonce.rkt")
(require "IFT359-tp2-MapReduce.rkt"); fichier à implémenter et à soumettre.

(newline)
(displayln "***********************************************")
(newline)
(displayln "* Jeux d'essai donnés en exemple dans l'énoncé ")
(newline)
(displayln "***********************************************")


(displayln "* Test (1/7) : (périodes* journaux) ")
(display "-:")
(let ([résultat (périodes* journaux)])
  (displayln (if (and (= (length résultat) (length journaux))
                      (member (list journal-1 11 41) résultat)
                      (member (list journal-2 12 52) résultat)
                      (member (list journal-3 13 63) résultat)
                      (member (list journal-4 14 84) résultat))
                 "réussi"
                 "échoué")))

; (périodes* journaux)
;(printf "(périodes* journaux) = ~a ~n" (périodes* journaux) )
;(printf "(length (périodes* journaux)) = ~a ~n" (length (périodes* journaux)) )
; (périodes* journaux) = ((((url1 11 (CAQ climat) positif) (url2 21 (climat avion) négatif) (url3 31 (climat économie) neutre) (url1 41 (avion vacances) positif)) 11 41) (((url1 12 (CAQ climat) positif) (url2 22 (climat avion) négatif) (url3 32 (climat économie) neutre) (url1 42 (avion vacances) positif) (url2 52 (climat avion) négatif)) 12 52) (((url1 13 (CAQ climat) positif) (url2 23 (climat avion) négatif) (url3 33 (climat économie) neutre) (url1 43 (avion vacances) positif) (url2 53 (climat avion) négatif) (url3 63 (climat économie) neutre)) 13 63) (((url1 14 (CAQ climat) positif) (url2 24 (climat avion) négatif) (url3 34 (climat économie) neutre) (url1 44 (avion vacances) positif) (url1 54 (CAQ climat) positif) (url2 64 (climat avion) négatif) (url3 74 (climat économie) neutre) (url1 84 (avion vacances) positif)) 14 84)) 

(displayln "* Test (2/7) : (total-clics journaux 15 35) ")
(display "-:")
(let ([résultat (total-clics journaux 15 35)]
      [résultat-attendu 8])
  (displayln (if (= résultat résultat-attendu)
                 "réussi"
                 (string-append "échoué (valeur attendue : " (~a résultat-attendu) ")"))))

; (total-clics journaux 15 35)
; (printf "(total-clics journaux 15 35) = ~a ~n" (total-clics journaux 15 35))
; (total-clics journaux 15 35) = 8 

(displayln "* Test (3/7) : (total-clics-sujet journaux 'climat 10 50) ")
(display "-:")
(let ([résultat (total-clics-sujet journaux 'climat 10 50)]
      [résultat-attendu 12])
  (displayln (if (= résultat résultat-attendu)
                 "réussi"
                 (string-append "échoué (valeur attendue : " (~a résultat-attendu) ")"))))

; (total-clics-sujet journaux 'climat 10 50)
; (printf "(total-clics-sujet journaux 'climat 10 50) = ~a ~n" (total-clics-sujet journaux 'climat 10 50))
; (total-clics-sujet journaux 'climat 10 50) = 12 

(displayln "* Test (4/7) : (sujets* journaux) ")
(display "-:")
(let ([résultat (sujets* journaux)]
      [résultat-attendu '(CAQ climat avion économie vacances)] )
  (displayln (if (and (= (length résultat) (length résultat-attendu))
                      (andmap (lambda (sujet) (member sujet résultat))
                              résultat-attendu))
                 "réussi"
                 (string-append "échoué (valeur attendue : " (~a résultat-attendu) ")"))))

; (sujets* journaux)
; (printf "(sujets* journaux) = ~a ~n" (sujets* journaux) )
; (sujets* journaux) = (CAQ climat avion économie vacances) 

(displayln "* Test (5/7) : (sujets-liés journaux 'url2 20 40) ")
(display "-:")
(let ([résultat (sujets-liés journaux 'url2 20 40)]
      [résultat-attendu '(climat avion) ])
  (displayln (if (and (= (length résultat) (length résultat-attendu))
                      (andmap (lambda (sujet) (member sujet résultat))
                              résultat-attendu))
                 "réussi"
                 (string-append "échoué (valeur attendue : " (~a résultat-attendu) ")"))))

; (sujets-liés journaux 'url2 20 40) 
; (printf "(sujets-liés journaux 'url2 20 40) = ~a ~n" (sujets-liés journaux 'url2 20 40) )
; (sujets-liés journaux 'url2 20 40) = (climat avion) 

(displayln "* Test (6/7) : (populaires journaux 3 10 40) ")
(display "-:")
(let ([résultat (populaires journaux 3 10 40)]
      [résultat-attendu '(url1 url2 url3)  ])
  (displayln (if (and (= (length résultat) (length résultat-attendu))
                      (andmap (lambda (sujet) (member sujet résultat))
                              résultat-attendu))
                 "réussi"
                 (string-append "échoué (valeur attendue : " (~a résultat-attendu) ")"))))

; (populaires journaux 3 10 40)
 (printf "(populaires journaux 3 10 40) = ~a ~n" (populaires journaux 3 10 40) )
; (populaires journaux 3 10 40) = (url1 url2 url3) 

(displayln "* Test (7/7) : (top journaux 2 3 10 90) ")
(display "-:")
(let ([résultat (top journaux 2 3 10 90)]
      [résultat-attendu '((url1 . 10) (url2 . 7))  ])
  (displayln (if (and (= (length résultat) (length résultat-attendu))
                      (andmap (lambda (sujet) (member sujet résultat))
                              résultat-attendu))
                 "réussi"
                 (string-append "échoué (valeur attendue : " (~a résultat-attendu) ")"))))

; (top journaux 2 3 10 90)
;(printf "(top journaux 2 3 10 90) = ~a ~n" (top journaux 2 3 10 90) )
; (top journaux 2 3 10 90) = ((url1 . 10) (url2 . 7)) 