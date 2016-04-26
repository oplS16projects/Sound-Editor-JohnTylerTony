#lang racket
;; File: sound.rkt
;; Curator: Tyler Bezuka
;; Purpose: Sound Generator

;; Includes
(require rsound)

(define (play x)
  (play ding))

(define (single-sound sound)
  (if (null? sound)
      (play ding)
      (cond ((eq? sound 'drum1) (play ding))
            ((eq? sound 'drum2) (play ding))
            ((eq? sound 'drum3) (play ding))
            ((eq? sound 'drum4) (play ding))
            ((eq? sound 'synth1) (play ding))
            ((eq? sound 'synth2) (play ding))
            ((eq? sound 'synth3) (play ding))
            ((eq? sound 'synth4) (play ding))
            ((eq? sound 'guitar1) (play ding))
            ((eq? sound 'guitar2) (play ding))
            ((eq? sound 'guitar3) (play ding))
            ((eq? sound 'guitar4) (play ding)))))

            
(define (repeat-sound sound repeat play)
  (if (eq? 0 repeat)
      (single-sound sound)
      (repeat-sound sound (- 1 repeat) (single-sound sound))))
  
(define (get-samples sound)
  (rs-read sound))


