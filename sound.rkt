#lang racket
;; File: sound.rkt
;; Curator: Tyler Bezuka
;; Purpose: Sound Generator

;; Includes
(require rsound)

(provide valid-list)
(provide single-sound)
(provide repeat-sound)
(provide record)

(define valid-list
  (list "drum1" "drum2" "drum3" "drum4"
        "synth1" "synth2" "synth3" "synth4"
        "clap1" "clap2" "clap3" "claves"))

;;depending on input entered from user in text editor a single sound will be played once. 
(define (single-sound sound)
  (if (null? sound)
      (play ding)
      (cond ((eq? sound 'drum1) (begin (play (rs-read "SoundSamples/Bamboo.wav")) (sleep .25)))
            ((eq? sound 'drum2) (begin (play (rs-read "SoundSamples/Bass-Drum-1.wav")) (sleep .25)))
            ((eq? sound 'drum3) (begin (play (rs-read "SoundSamples/Boom-Kick.wav")) (sleep .25)))
            ((eq? sound 'drum4) (begin (play (rs-read "SoundSamples/Bottle.wav")) (sleep .25)))
            ((eq? sound 'synth1) (begin (play (rs-read "SoundSamples/Yamaha-TG100-Bass-and-Ld-C3.wav")) (sleep .25)))
            ((eq? sound 'synth2) (begin (play (rs-read "SoundSamples/Yamaha-TG100-CaliopLd-C5.wav")) (sleep .25)))
            ((eq? sound 'synth3) (begin (play (rs-read "SoundSamples/Yamaha-TG100-CharanLd-C4.wav")) (sleep .25)))
            ((eq? sound 'synth4) (begin (play (rs-read "SoundSamples/Yamaha-TG100-Chiff-Ld-C4.wav")) (sleep .25)))
            ((eq? sound 'clap1) (begin (play (rs-read "SoundSamples/Clap-1.wav")) (sleep .25)))
            ((eq? sound 'clap2) (begin (play (rs-read "SoundSamples/Clap-2.wav")) (sleep .25)))
            ((eq? sound 'clap3) (begin (play (rs-read "SoundSamples/Clap-3.wav")) (sleep .25)))
            ((eq? sound 'claves) (begin (play (rs-read "SoundSamples/Claves.wav")) (sleep .25))))))

;;NOT FINISHED
;;Function repeats the selected sound for however many times the user wishes. 
(define (repeat-sound sound repeat)
  (if (< repeat 1)
      (single-sound sound)
      (rs-append (repeat-sound sound (- repeat 1)) (single-sound sound))))
  
  
;;user is able to record sound for however long they wish and play back immediately. 
(define (record frames)
  (play (record-sound frames)))



