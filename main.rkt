#lang racket
;; File: main.rkt
;; Curator: Tony Ventura
;; Purpose: Main driver and GUI

;; Includes
(require racket/gui)
(require "parse.rkt")

;; ==========================================================
;; Constants
(define WIDTH 800)
(define HEIGHT 700)

(define TEXT-SIZE 18)
(define TEXT-COLOR "GREEN")
;; ==========================================================

(define frame (new frame% [label "Editor"]
                          [width WIDTH]
                          [height HEIGHT]))

(define c (new editor-canvas% [parent frame]
                              [style '(auto-hscroll auto-vscroll no-border)]))
(define text (new text%))

(define mb (new menu-bar% [parent frame]))
(define m-edit (new menu% [label "Edit"] [parent mb]))
(define m-font (new menu% [label "Font"] [parent mb]))
(append-editor-operation-menu-items m-edit #f)
(append-editor-font-menu-items m-font)

(send c set-editor text)
(send frame show #t)

;; Anything below this comment is to initialize and perform parsing

;; Parser Initialized
(define sound-parser (make-parser 'test-mode))

;; Get raw string from textbox, returns all content in text box
(define (string-input)
  (send text get-text))

;; Populates the parser object when launched as (callback-populate)
(define callback-populate
  (lambda()((sound-parser 'init) (string-input))))

;; Updates the parser object when launched as (callback-update)
;;; Bug: retrieves entire textbox, not just update since last read
(define callback-update
  (lambda()((sound-parser 'update) (string-input))))

;; Todo:
;; 1. Provide button on editor to signal done inputting,
;;    button should call (sound-parser 'done)
;; 2. Provide how-to display on window showing syntax of language
;; 3. Correct bug on (callback-update), see above

;; End perform parsing


