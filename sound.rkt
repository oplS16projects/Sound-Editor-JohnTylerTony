#lang racket
;; File: sound.rkt
;; Curator: Tyler Bezuka
;; Purpose: Sound Generator

;; Includes
(require rsound)

(provide make-sound sound repeat)
  (if (eq? sound path-string) (play-drums sound repeat

(define (make-sound)
  #t)
  
(define (play-drums f)
  (if (null? f)
      (play ding)
      (cond ((eq? f 'kick-drum) (play (get-drum-samples "sample1.wav")))
            ((eq? f 'hi-top) (play (get-drum-samples "sample2.wav")))
            ((eq? f 'snare) (play (get-drum-samples "sample3.wav"))
            ((eq? f 'nothing) (play ding))))))
            
(define (repeat-sound sound repeat)
  (if (eq? 0 repeat)
      (play-drums sound)
      ((play-drums sound) (repeat-sound sound (- 1 repeat)))))
  
(define (get-samples sound)
  (rs-read sound))
