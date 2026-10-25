#lang racket
(require "TP2-Journal.rkt")

(provide journal-1)
(provide journal-2)
(provide journal-3)
(provide journal-4)
(provide journaux)

;***************************
;
; TP2 - exemples de journaux fournis avec l'énoncé


(define journal-1 (list (entrée-journal 'url1 11 '(CAQ climat) 'positif)
                        (entrée-journal 'url2 21 '(climat avion) 'négatif)
                        (entrée-journal 'url3 31 '(climat économie) 'neutre)
                        (entrée-journal 'url1 41 '(avion vacances) 'positif)))

(define journal-2 (list (entrée-journal 'url1 12 '(CAQ climat) 'positif)
                        (entrée-journal 'url2 22 '(climat avion) 'négatif)
                        (entrée-journal 'url3 32 '(climat économie) 'neutre)
                        (entrée-journal 'url1 42 '(avion vacances) 'positif)
                        (entrée-journal 'url2 52 '(climat avion) 'négatif)))

(define journal-3 (list (entrée-journal 'url1 13 '(CAQ climat) 'positif)
                        (entrée-journal 'url2 23 '(climat avion) 'négatif)
                        (entrée-journal 'url3 33 '(climat économie) 'neutre)
                        (entrée-journal 'url1 43 '(avion vacances) 'positif)
                        (entrée-journal 'url2 53 '(climat avion) 'négatif)
                        (entrée-journal 'url3 63 '(climat économie) 'neutre)
                        ))

(define journal-4 (list (entrée-journal 'url1 14 '(CAQ climat) 'positif)
                        (entrée-journal 'url2 24 '(climat avion) 'négatif)
                        (entrée-journal 'url3 34 '(climat économie) 'neutre)
                        (entrée-journal 'url1 44 '(avion vacances) 'positif)
                        (entrée-journal 'url1 54 '(CAQ climat) 'positif)
                        (entrée-journal 'url2 64 '(climat avion) 'négatif)
                        (entrée-journal 'url3 74 '(climat économie) 'neutre)
                        (entrée-journal 'url1 84 '(avion vacances) 'positif)))

(define journaux (list journal-1 journal-2 journal-3 journal-4))
