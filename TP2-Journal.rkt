#lang racket
;(require "IFT359-tp2-MapReduce.rkt")

(provide entrée-journal)
(provide url)
(provide date)
(provide sujets)
(provide émotion)


;***************************
;
; TP2 - Journal : 

; représentations des entrées des journaux

; Constructeurs
(define (entrée-journal url date sujets émotion)
  (list url date sujets émotion))

; Accesseurs
(define (url entrée-journal) (car entrée-journal))      
(define (date entrée-journal) (cadr entrée-journal))     
(define (sujets entrée-journal) (caddr entrée-journal)) 
(define (émotion entrée-journal) (cadddr entrée-journal))

