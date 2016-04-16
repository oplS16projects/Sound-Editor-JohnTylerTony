#lang racket/gui
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
