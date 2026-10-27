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
    (map période ; applique la fonction utilitaire 'période' pour chaque journal dans 'journaux'
        (filter-not empty? journaux)) ; fait en sorte que map applique la fonction période sur les journaux non vide.
)

; fonction utilitaire pour créer le triplet (journal, date-min, date-max)
(define (période journal)
    (let ([dates (map date journal)]) ; prends toutes les dates d'un journal et les met sous forme de liste dans dates
        (list journal (apply min dates) (apply max dates))) ; le triplet retourné
)
;********************************************************************

; Calculer le nombre total de clics sur
; l’ensemble des URL pour l’ensemble des
; journaux entre la date du début incluse et
; la date de fin incluse. Une entrée du
; journal correspond à un clic

; return : un nombre entier
(define (total-clics journaux début fin)
    (length ; retourne la longueur (qui équivaut au nb de clics) de la liste de journaux qui sont dans la condition
        (filter (entre-debut-fin? début fin) ; filtre les journaux entre les dates de début et fin
                (aplatir journaux))) ; aplatit la liste journaux
)

; Fonction utilitaire pour aller chercher les
; journaux entre la date du début et la date de fin
; elle retourne une fonction lambda qui retourne un prédicat 
; pour si une entré du journal est entre la date de début et de fin.
(define (entre-debut-fin? début fin)
    (lambda (x) (<= début (date x) fin)))

; Fonction utilitaire pour aplatir 'journaux'
; au lieu de toujours appeler (apply append journaux) quand on doit aplatir 'journaux' dans un traitement
(define (aplatir journaux)
    (apply append journaux))

;********************************************************************

; Calculer le nombre de clics sur un sujet
; pour l’ensemble des journaux entre la
; date du début incluse et la date de fin
; incluse.

; return : un nombre entier
(define (total-clics-sujet journaux sujet début fin)
    (length 
        (filter (conjoin (contient-sujet? sujet) (entre-debut-fin? début fin)) ; conjoin retourne un predicat seulement si tous les predicat (contient-sujet? et entre-debut-fin?) retourne true.
            (aplatir journaux)))
)

; Fonction utilitaire pour valider si un element d'un journal contient le sujet demander
(define (contient-sujet? sujet)
    (lambda (s) (member sujet (sujets s)))
)
;********************************************************************

; Extraire l'ensemble de tous les sujets qui
; apparaissent dans les journaux.

; return : Liste de tous les sujets sans répétition.
(define (sujets* journaux)
        (sujets-sans-répétition (aplatir journaux))
)

; Fonction utilitaire pour enlever les doublons dans les entrées des journaux
(define (sujets-sans-répétition entrées)
    (remove-duplicates (append-map sujets entrées))
)
;********************************************************************

; Extraire la liste de tous les sujets associés
; à une page qui ont mené à un clic pour
; l’ensemble des journaux entre la date du
; début incluse et la date de fin incluse.

; return : Liste de tous les sujets sans répétition.
(define (sujets-liés journaux URL début fin)
    (sujets-sans-répétition 
        (filter 
            (conjoin (contient-url? URL) (entre-debut-fin? début fin))
            (aplatir journaux)))
)

(define (contient-url? URL)
    (lambda (x) (equal? URL (url x)))
)
;********************************************************************

; Extraire l'ensemble des URL qui ont
; dépassé ou égalé un certain seuil de clics
; dans les journaux entre la date du début
; incluse et la date de fin incluse.

; fonction qui pourrait etre utiliser : foldr et les fonctions de A-listes

; return : Liste de tous les URLs sans répétition qui respectent la condition.
(define (populaires journaux seuil début fin)
  (let* ([entree-filtrees (filter (entre-debut-fin? début fin)(aplatir journaux))] 
    [alist-comptes(foldr
     (lambda (entree acc)
       (let ([ent (url entree)])
       (if (hasKey? ent acc)
         (replace-value ent (+ 1 (value ent acc)) acc)
         (add-assoc ent 1 acc))))
     '()
     entree-filtrees)])
     (keys(filter (lambda (assoc)(>= (value-assoc assoc) seuil)) alist-comptes)))
  )
  
;********************************************************************

; La liste en ordre décroissant de clics des
; n URL qui ont dépassé ou égalé un
; certain seuil de total de clics dans
; l’ensemble des journaux
; indépendamment du sujet de recherche
; entre la date du début incluse et la date de
; fin incluse.

; fonction qui pourrait etre utiliser : foldr, argmax, sort, takef

; return : Liste des n URLs sans répétition.
; * Il se peut qu’il y ait moins de n URL qui satisfassent la contrainte.
(define (top journaux n seuil début fin)
   (let* ([entree-filtrees (filter (entre-debut-fin? début fin)(aplatir journaux))] 
    [alist-comptes(foldr
     (lambda (entree acc)
       (let ([ent (url entree)])
       (if (hasKey? ent acc)
         (replace-value ent (+ 1 (value ent acc)) acc)
         (add-assoc ent 1 acc))))
     '()
     entree-filtrees)]
    [alist-filtree (filter (lambda (assoc)(>= (value-assoc assoc) seuil)) alist-comptes)]
    [alist-tries (sort alist-filtree(lambda (elem1 elem2) (> (value-assoc elem1)(value-assoc elem2))))]
    [urls-tries (keys alist-tries)])
     (take urls-tries (min n (length urls-tries))))
)

;********************************************************************

; Sujet hot = dans le top n pendant au moins
; nbjours consécutifs pour une période
; donnée

; fonction qui pourrait etre utiliser : group-by

; return : Liste des paires
; (sujet . nb-consécutifs)
(define (hot journaux n nbjours début fin)
 (let* ([entree-filtrees (filter (entre-debut-fin? début fin)(aplatir journaux))] 
 [liste-jours (build-list (+ 1 (- fin début)) (lambda (i) (+ début i)))]

 [tops-jours(map (lambda (jour)
  (let* ([entrees-jour (filter (lambda (dat) (= (date dat) jour)) entree-filtrees)]
    [tous-sujets (append-map sujets entrees-jour)]
    [alist-sujets-jour (foldr (lambda (sujet suj)
                                (if (hasKey? sujet suj)
                                    (replace-value sujet(+ 1 (value sujet suj)) suj )
                                    (add-assoc sujet 1 suj)))
                                    '()
                                    tous-sujets)]
   [alist-tries (sort alist-sujets-jour (lambda (suj1 suj2) (> (value-assoc suj1) (value-assoc suj2))))]
[top-n-jour (take (keys alist-tries) (min n (length (keys alist-tries))))])
   top-n-jour ))
  liste-jours )])

(let* ([tous-sujets(remove-duplicates (append* tops-jours))]
[sujets-in-jours (map (lambda (sujet)
                        (let loop ([jours liste-jours]
                                   [tops tops-jours])
                                 (cond
                                   [(null? jours) '()]
                                   [(member sujet (car tops))
                                    (cons(car jours) (loop (cdr jours)(cdr tops)))]
                                   [else (loop (cdr jours)(cdr tops))])))
                      tous-sujets)]
  
[resultats (map (lambda (sujet jours-sujet)
                  (if (null? jours-sujet)
                      (cons sujet 0)
                      (let*([groupes (group-by (lambda (j) (- j (index-of jours-sujet j))) jours-sujet)]
                        [max (apply max (map length groupes))])
                      (cons sujet max))))
           tous-sujets
           sujets-in-jours)])

   (filter (lambda (p) (>= (cdr p) nbjours)) resultats)
   )))

;********************************************************************

; Extraire l'ensemble des paires (url . nbclics)
; pour les URL qui traitent d’un des sujets
; de la liste avec l’émotion spécifiée
; entre la date du début incluse et la date de fin incluse.

; fonction qui pourrait etre utiliser : foldr, ormap

; return : Liste de toutes des paires
; (url . nbclics)
(define (consultation journaux sujets émotion début fin)
    cons)
