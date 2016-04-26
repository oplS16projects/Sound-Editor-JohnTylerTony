#lang racket
;; File: main.rkt
;; Creator: Tony Ventura
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

;; define frame of gui 'frame'
(define frame
  (new frame%
       [label "Editor"]
       [width WIDTH]
       [height HEIGHT]))

;; define editor canvas 'c' with parent 'frame'
(define c
  (new editor-canvas%
       [parent frame]
       [style '(auto-hscroll auto-vscroll no-border)]))

;; define text object 'text'
(define text (new text%))

;; define panel for button 'panel'
(define panel
  (new horizontal-panel%
       [parent frame]
       [alignment '(center center)]))

;; define button 'button'
(define button
  (new button%
     [parent panel]
     [label "Run"]
     ;; where the magic happens
     [callback (lambda (button event)
                 ;; enclosing loop for parser
                 (let ((curr-line "") (curr-pos 0))
                   ;; for each line in text
                   (for ([i (+ 1 (send text last-line))])
                     ;; define snip of current line
                     (define snip
                       (send text find-snip curr-pos 'after))
                     ;; set 'current-line' to string of snip
                     (set! curr-line
                           (send snip get-text 0 100))
                     ;; set 'curr-pos' to offset of last string
                     (set! curr-pos
                           (+ curr-pos
                              (+ 1 (string-length curr-line))))
                     ;; ********** THIS IS WHERE YOU GO JOHN **********
                     ;; ** RIGHT NOW IT ONLY PRINTS THE CURRENT LINE **
                     (print curr-line)
                     ;; **************** FILL IN ABOVE ****************
                     )))]))

;; define gui menu
(define mb
  (new menu-bar% [parent frame]))
(define m-edit
  (new menu%
       [label "Edit"]
       [parent mb]))
(define m-font
  (new menu%
       [label "Font"]
       [parent mb]))
(append-editor-operation-menu-items m-edit #f)
(append-editor-font-menu-items m-font)

;; set canvas 'c' of text object 'text'
(send c set-editor text)
;; send 'frame', show it
(send frame show #t)

;; =================================================================
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


