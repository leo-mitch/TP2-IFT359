#lang racket
(require racket/trace)

(provide make-alist)

(provide make-assoc)
(provide key-assoc)
(provide value-assoc)

(provide keys)
(provide hasKey?)
(provide remove-key)
(provide value)
(provide values)
(provide add-assoc)
(provide replace-value)
(provide empty-alist?)

;*
;*  A-listes
;*

(define make-assoc cons)
(define key-assoc car)
(define value-assoc cdr)

(define make-alist '())
(define empty-alist? null?)

(define (keys alist) (map car alist))
(define (hasKey? key alist) (member key (keys alist)))

(define (remove-key key alist)
  (filter-not (lambda(assoc) (equal? (key-assoc assoc) key))
              alist))

; ajoute une association sans vérifier si la clé existe déjà
(define (add-assoc key value alist)
  (cons (make-assoc key value) alist))

; enlève la valeur précédente si elle existe
; ajoute une nouvelle association
(define (replace-value key value alist)
  (add-assoc key value (remove-key key alist)))
;(trace replace-value)

(define (values alist) (map cdr alist))

(define (value key alist)
  (cond [(null? alist) '()]
        [ (equal? key (caar alist)) (cdar alist)]
        [else (value key (cdr alist))]))



