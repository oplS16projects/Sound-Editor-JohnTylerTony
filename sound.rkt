#lang racket
;; File: sound.rkt
;; Curator: Tyler Bezuka
;; Purpose: Sound Generator

;; Includes
(require rsound)
         
(define (make-sound sound repeat)
  (play-drums "kick-drum"))
;; ^^ Needs some further reworking to integrate into parser
  
(define (play-drums f)
  (if (null? f)
      (play ding)
      (cond ((eq? f 'kick-drum) (play ding))
            ((eq? f 'hi-top) (play ding))
            ((eq? f 'snare) (play ding))
            ((eq? f 'nothing) (play ding))))))
            
(define (repeat-sound sound repeat)
  (if (eq? 0 repeat)
      (play-drums sound)
      ((play-drums sound) (repeat-sound sound (- 1 repeat)))))
  
(define (get-samples sound)
  (rs-read sound))

