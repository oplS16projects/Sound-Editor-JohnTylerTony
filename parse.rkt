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
  (define raw-input (list "--"))
  ; Sound list of parsed items to execute
  (define sounds-play (list "ding"))
  ; Parse sounds
  (define (parse)
    (begin
      (map (lambda(in)
             (begin
               (set! in (string-split in))
               (display in)
               (cond
                        ((and (pair? in) (equal? "play-sound" (car in)))
                         (set! sounds-play (append sounds-play (list (cadr in)))))
                        (else (print "invalid sound")))))
           raw-input)
      (map (lambda(in)(begin
                        (single-sound (string->symbol in))
                        (print in)
                        (print "played sound")
                        (display "\n")))
           sounds-play)))
  (define (repeat)
    (map (lambda(in)(begin
                        (single-sound (string->symbol in))
                        (print in)
                        (print "played sound")
                        (display "\n")))
           sounds-play))
  ; Update raw input
  (define (update-raw-input value)
    (if (not done)
        (set! raw-input (append raw-input (list value)))
        (error "Cannot update done object")))
  ; Done flag, when done the object cannot be modified
  (define done #f)
  ; Initialize the object, if done is #t, reset the object
  (define (init input)
    (if (not done)
        (set! raw-input (list input))
        (begin (set! raw-input (list input)) (set! done #f))))
  
  (define (dispatch request)
    (cond ;; Call init
          ((eq? request 'init) init)
          ;; Update raw text string
          ((eq? request 'update) update-raw-input)
          ;; Print raw input
          ((eq? request 'print) raw-input)
          ;; Lock the object and parse
          ((eq? request 'done) (if (eq? #f done)(begin (set! done #t) (parse))
                                   (error "Already parsed")))
          ;; Repeat playing
          ((eq? request 'play) (if (eq? #t done)(repeat)(error "No parse")))
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


;(define test (make-parser 'test))
;((test 'init) "johnkilgo")
