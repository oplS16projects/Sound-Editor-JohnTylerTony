#lang racket
;; File: parse.rkt
;; Curator: John Kilgo
;; Purpose: Parse input and pass to sound generator

;; Includes
(require "sound.rkt")

(provide make-parser)

;; Parser object with setter, getters
(define (make-parser initial)
  ; Flag for setting mode of parser (not in use currently)
  (define mode initial)
  ; Raw input string from textbox
  (define raw-input (list "begin"))
  ; Sound list of parsed items to execute
  (define sounds-play (list "ding"))
  ; Reset
  (define (reset)
    (begin
      (set! done #f)
      (set! raw-input (list "begin"))
      (set! sounds-play (list "ding"))
      (if (eqv? mode 'debug)
          (display "\n --> Reset event\n\n")
          (display ""))))
  ; Parse sounds
  (define (parse)
    (cond
      ;; Already parsed, going to just play.
      ((equal? done #t)
       (map (lambda(in)(begin
                        (single-sound (string->symbol in))
                        (if (eqv? mode 'debug)
                            (begin
                              (display "Played sound: ")
                              (print in)
                              (display "\n"))
                            (display ""))))       
           sounds-play))
      ;; Not parsed, need to parse and will then play.
      ((equal? done #f)
       (begin
         (set! done #t)
         (map (lambda(in)
                (begin
                  (set! in (string-split in))
                  (display in)(display "\n")
                  (cond
                    ((and (pair? in) (equal? "play-sound" (car in)))
                     (set! sounds-play (append sounds-play (list (cadr in)))))
                    (else
                     (if (eqv? mode 'debug)
                         (display "invalid sound\n")
                         (display ""))))))
              raw-input)
         (parse)))))
  ; Update raw input
  (define (update-raw-input value)
    (if (not done)
        (set! raw-input (append raw-input (list value)))
        (error "Cannot update done object")))
  ; Done flag, when done the object cannot be modified
  (define done #f)
  ; Dispatch table
  (define (dispatch request)
    (cond ;; Call init
          ((eq? request 'init) (reset))
          ;; Update raw text string
          ((eq? request 'update) update-raw-input)
          ;; Print raw input
          ((eq? request 'raw-input) raw-input)
          ((eq? request 'sounds-play) sounds-play)
          ;; Lock the object and parse
          ((eq? request 'done) (parse))
          ;; Repeat playing
          ;;((eq? request 'play) (if (eq? #t done)(repeat)(error "No parse")))
          ;; Return the current mode of the object
          ((eq? request 'mode) mode)
          ;; Dump debug info
          ((eq? request 'dump) raw-input)
          ((eq? request 'debug) (begin
                                  (display "Parser mode: ")(display mode)(display "\n")
                                  (display ";; Raw input:\n")(display raw-input)
                                  (display "\n;; sounds-play:\n")(display sounds-play)
                                  (display "\nInput complete? ") done))
          (else (error "Unknown request: Parser" request))))
  ;; Launch the dispatch procedure
  dispatch)
