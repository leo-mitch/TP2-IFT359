#lang racket
(require racket/trace)
(require "TP2-Journal.rkt")
(require "A-listes.rkt")

(provide périodes*)
(provide total-clics)
(provide total-clics-sujet)
(provide sujets*)
(provide sujets-liés)
(provide populaires)
(provide top)
(provide hot)
(provide consultation)

;********************************************************************
; ***************** IFT359 / TP2
; ***************** Poirier-Pigeon, Léo-Michel - 26052832 - poil5311
; ***************** Dufort,         Olivier    - 26070714 - dufo6646
;********************************************************************

; Extraire pour chaque journal la date de
; début la plus petite et la plus grande.

; return : liste de triplets (journal, date-min, date-max)
(define (périodes* journaux)
    (map (lambda (journal)
        (let ([dates (map date journal)]) ; prends toutes les dates d'un journal et les met sous forme de liste dans dates
            (list journal (apply min dates) (apply max dates))))
    (filter-not empty? journaux)) ; fait en sorte que map applique la fonction lambda sur les journaux non vide.
)

;********************************************************************

; Calculer le nombre total de clics sur
; l’ensemble des URL pour l’ensemble des
; journaux entre la date du début incluse et
; la date de fin incluse. Une entrée du
; journal correspond à un clic

; return : un nombre entier (type = number)
(define (total-clics journaux début fin)
    0)

;********************************************************************

; Calculer le nombre de clics sur un sujet
; pour l’ensemble des journaux entre la
; date du début incluse et la date de fin
; incluse.

; return : un nombre entier (type = number)
(define (total-clics-sujet journaux sujet début fin)
    0)

;********************************************************************

; Extraire l'ensemble de tous les sujets qui
; apparaissent dans les journaux.

; return : Liste de tous les sujets sans répétition.
(define (sujets* journaux)
    '())

;********************************************************************

; Extraire la liste de tous les sujets associés
; à une page qui ont mené à un clic pour
; l’ensemble des journaux entre la date du
; début incluse et la date de fin incluse.

; return : Liste de tous les sujets sans répétition.
(define (sujets-liés journaux URL début fin)
    '())

;********************************************************************

; Extraire l'ensemble des URL qui ont
; dépassé ou égalé un certain seuil de clics
; dans les journaux entre la date du début
; incluse et la date de fin incluse.

; return : Liste de tous les URLs sans répétition qui respectent la condition.
(define (populaires journaux seuil début fin)
    '())

;********************************************************************

; La liste en ordre décroissant de clics des
; n URL qui ont dépassé ou égalé un
; certain seuil de total de clics dans
; l’ensemble des journaux
; indépendamment du sujet de recherche
; entre la date du début incluse et la date de
; fin incluse.

; return : Liste des n URLs sans répétition.
; * Il se peut qu’il y ait moins de n URL qui satisfassent la contrainte.
(define (top journaux n seuil début fin)
    '())

;********************************************************************

; Sujet hot = dans le top n pendant au moins
; nbjours consécutifs pour une période
; donnée

; return : Liste des paires
; (sujet . nb-consécutifs)
(define (hot journaux n nbjours début fin)
    cons)

;********************************************************************

; Extraire l'ensemble des paires (url . nbclics)
; pour les URL qui traitent d’un des sujets
; de la liste avec l’émotion spécifiée
; entre la date du début incluse et la date de fin incluse.

; return : Liste de toutes des paires
; (url . nbclics)
(define (consultation journaux sujets émotion début fin)
    cons)
