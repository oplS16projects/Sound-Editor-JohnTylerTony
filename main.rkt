#lang racket
;; File: main.rkt
;; Creator: Tony Ventura
;; Purpose: Main driver and GUI

;; Includes
(require racket/gui)
(require "parse.rkt")

;; =================== Sound Parser Object from parse.rkt =======
;; Parser Initialized
(define sound-parser (make-parser 'debug))
(sound-parser 'init)


;; ==========================================================
;; Constants
(define WIDTH 500)
(define HEIGHT 600)

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
       [min-height 500]
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
     [label "Parse and Play"]
     ;; where the magic happens
     [callback (lambda (button event)
                 ;; Reset sound parser object for clean slate
                 (sound-parser 'init)
                 ;; Pass each line to the sound parser
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
                     ;; Update parser with current line
                     ((sound-parser 'update) curr-line) 
                     (print curr-line)(display "\n") ;; debug
                     ))
                 (sound-parser 'done))]))

;; define button 'button2'
(define button2
  (new button%
     [parent panel]
     [label "Repeat"]
     ;; where the magic happens
     [callback (lambda (button event)
                 ;; enclosing loop for parser
;                 (let ()
;                   0
;                     ))
                 (sound-parser 'done))
               ]))

;;; define button 'button3'
;(define button3
;  (new button%
;     [parent panel]
;     [label "3 Repeat"]
;     ;; where the magic happens
;     [callback (lambda (button event)
;                 ;; enclosing loop for parser
;;                 (let ()
;;                   0
;;                     ))
;                 (sound-parser 'play))
;               ]))

;; define gui menu
(define mb
  (new menu-bar%
       [parent frame]))
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

;; send 'frame', show gui
(send frame show #t)
