#lang racket
;; File: sound.rkt
;; Curator: Tyler Bezuka
;; Purpose: Sound Generator

;; Includes
(require rsound)

(define valid-list
  (list "drum1" "drum2" "drum3" "drum4"
        "synth1" "synth2" "synth3" "synth4"
        "clap1" "clap2" "clap3" "claves"))

;;depending on input entered from user in text editor a single sound will be played once. 
(define (single-sound sound)
  (if (null? sound)
      (play ding)
      (cond ((eq? sound "drum1") (play (rs-read "https://github.com/oplS16projects/Sound-Editor-JohnTylerTony/blob/master/SoundSamples/Bamboo.wav")))
            ((eq? sound "drum2") (play (rs-read "https://github.com/oplS16projects/Sound-Editor-JohnTylerTony/blob/master/SoundSamples/Bass-Drum-1.wav")))
            ((eq? sound "drum3") (play (rs-read "https://github.com/oplS16projects/Sound-Editor-JohnTylerTony/blob/master/SoundSamples/Boom-Kick.wav")))
            ((eq? sound "drum4") (play (rs-read "https://github.com/oplS16projects/Sound-Editor-JohnTylerTony/blob/master/SoundSamples/Bottle.wav")))
            ((eq? sound "synth1") (play (rs-read "https://github.com/oplS16projects/Sound-Editor-JohnTylerTony/blob/master/SoundSamples/Yamaha-TG100-Bass-and-Ld-C3.wav")))
            ((eq? sound "synth2") (play (rs-read "https://github.com/oplS16projects/Sound-Editor-JohnTylerTony/blob/master/SoundSamples/Yamaha-TG100-CaliopLd-C5.wav")))
            ((eq? sound "synth3") (play (rs-read "https://github.com/oplS16projects/Sound-Editor-JohnTylerTony/blob/master/SoundSamples/Yamaha-TG100-CharanLd-C4.wav")))
            ((eq? sound "synth4") (play (rs-read "https://github.com/oplS16projects/Sound-Editor-JohnTylerTony/blob/master/SoundSamples/Yamaha-TG100-Chiff-Ld-C4.wav")))
            ((eq? sound "clap1") (play (rs-read "https://github.com/oplS16projects/Sound-Editor-JohnTylerTony/blob/master/SoundSamples/Clap-1.wav")))
            ((eq? sound "clap2") (play (rs-read "https://github.com/oplS16projects/Sound-Editor-JohnTylerTony/blob/master/SoundSamples/Clap-2.wav")))
            ((eq? sound "clap3") (play (rs-read "https://github.com/oplS16projects/Sound-Editor-JohnTylerTony/blob/master/SoundSamples/Clap-3.wav")))
            ((eq? sound "claves") (play (rs-read "https://github.com/oplS16projects/Sound-Editor-JohnTylerTony/blob/master/SoundSamples/Claves.wav"))))))

;;NOT FINISHED
;;Function repeats the selected sound for however many times the user wishes. 
(define (repeat-sound sound repeat)
  (if (< repeat 1)
      (single-sound sound)
      (rs-append (repeat-sound sound (- repeat 1)) (single-sound sound))))
  
  
;;user is able to record sound for however long they wish and play back immediately. 
(define (record frames)
  (play (record-sound frames)))



