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
  (define raw-input "")
  ; Update raw input
  (define (update-raw-input value)
    (if (not done)
        (set! raw-input (string-append raw-input value))
        (error "Cannot update done object")))
  ; Done flag, when done the object cannot be modified
  (define done #f)
  ; Initialize the object, if done is #t, reset the object
  (define (init input)
    (if (not done)
        (set! raw-input input)
        (begin (set! raw-input "") (set! raw-input input) (set! done #f))))
  (define (dispatch request)
    (cond ;; Call init
          ((eq? request 'init) init)
          ;; Update raw text string
          ((eq? request 'update) update-raw-input)
          ;; Print raw input
          ((eq? request 'print) raw-input)
          ;; Lock the object
          ((eq? request 'done) (set! done #t))
          ;; Return the current mode of the object
          ((eq? request 'mode) mode)
          ;; Dump debug info
          ((eq? request 'debug) (begin
                                  (display "Parser mode: ")(display mode)(display "\n")
                                  (display ";; Raw input:\n")(display raw-input)
                                  (display ";; End raw input")
                                  (display "\nInput complete? ") done))
          (else (error "Unknown request: Parser" request))))
  ;; Launch the dispatch procedure
  dispatch)


;(define test (make-parser 'test))
;((test 'init) "johnkilgo")