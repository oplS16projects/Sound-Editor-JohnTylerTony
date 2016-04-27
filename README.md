# FP7-webpage The Sound Edtior

##Authors
John Kilgo (Group Lead, Parser)

Tyler Bezuka (Sounds)

Tony Ventura (GUI)

##Overview
The sound editor is a text editor where a user can type several phrases, click a button(s), and have sounds come out of their computer. The syntax is extremely basic at this point. Please see details below.

##Screenshot
![screenshot showing running](running.png)

##Concepts Demonstrated
* **Data abstraction** is used in the parser object dound in parser.rkt. Users cannot directly modify this object and must use the interfaced that is provided; the object can be locked and attempts to edit it can be rejected. Calling the init function again resets the state of the object.
* **Higher order functions like map** is used in the parser when dissecting the user input and converting into playable sounds
* **Program modularity** is demonstrated by separating each functional component of the program
  - sound.rkt provides an interface to play sounds
  - parser.rkt provides an interface for loading editor content and parsing it into function calls to sound.rkt
  - main.rkt provides a gui and is the main driver

##External Technology and Libraries
* rsound: [tyler write what you used here and link to it]
* [racket/gui](https://docs.racket-lang.org/gui/)

##Favorite Scheme Expressions
####John (team lead)
My favorite section is the dispatch table in [parser.rkt](https://github.com/oplS16projects/Sound-Editor-JohnTylerTony/blob/v.2.1/parse.rkt). There are extra entries due to debugging in the intial release, but the table controls all access to the object. It was a process to arrive at this point as I started out by first trying to just get an object where I could modify the state. Then I added the ability to update the state of the object. It seemed like a good idea to also add the ability to lock the object before parsing. Resetting the object is performed by calling 'init. Though the current init function only resets the raw input and in a future release the init will also reset other mutable items within the parser object. 

There are certainly improvements that can be made. Some include simplifying the interface and also offloading the functionality within the dispatch table (such as conditionals and if statements) to the functions that are called from the dispatch table.

```scheme
  ((define (dispatch request)
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
```
####Tyler (rsound)
This expression reads in a regular expression and elegantly matches it against a pre-existing hashmap....
```scheme
(let* ((expr (convert-to-regexp (read-line my-in-port)))
             (matches (flatten
                       (hash-map *words*
                                 (lambda (key value)
                                   (if (regexp-match expr key) key '()))))))
  matches)
```

####Tony (racket/gui)
My favorite section would have to be the button handler. This section not only utilized the gui button object, but really gave me a solid understanding of encapsulation. The callback event for the button (event when button is pressed) is supposed to handle grabbing the user input, line by line, and sending it to the parser. Encapsulating the actual line scrape was the key here, as racket would have tried to run this section on program load. By throwing it in a lambda, the event will only trigger when the button is pressed. Then the let in the body allows me to have temporary variables curr-line and curr-pos, to hold the string of the current line, and the position in the file the loop is in. The magic of getting the strings came from another gui object called the snip. The editor where the text is input can be broken up into smaller sections called snips. I was able to grab a line snip, set my variables as needed, and call the appropriate parse function.
```scheme
(define button
  (new button%
     [parent panel]
     [label "Save"]
     [callback (lambda (button event)
                 (let ((curr-line "") (curr-pos 0))
                   (for ([i (+ 1 (send text last-line))])
                     (define snip
                       (send text find-snip curr-pos 'after))
                     (set! curr-line
                           (send snip get-text 0 100))
                     (set! curr-pos
                           (+ curr-pos
                              (+ 1 (string-length curr-line))))
                     ((sound-parser 'update) curr-line)
                     )))]))
```

#How to Download and Run
Please download the  most recent release below.

1. Install rsound library on your computer via Dr. Racket package manager
2. Extract the archive (from release page) and open main.rkt
3. Run the file.
4. Type from the following example into the editor.
5. Click "1 Save", Click "2 Play" (note: once you click play the editor is locked, changes to the editor will not modify the sound), Click "3 Repeat" to repeat your sounds.

###Examples (can combine any number of times and in any order)
```
play-sound drum1
play-sound drum2
play-sound drum3
play-sound drum4
play-sound synth1
play-sound synth2
play-sound synth3
play-sound synth4
play-sound clap1
play-sound clap2
play-sound clap3
play-sound clap4
play-sound claves
```

[Initial Working Release](https://github.com/oplS16projects/Sound-Editor-JohnTylerTony/releases/tag/v.2.1)

