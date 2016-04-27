# Project Title: The Sound Editor

### Statement
We are going to create our own language/syntax similar to HTML where we will create a text editor for this new language and the user will be able to generate sounds. It will be a GUI application.

### Analysis
We will likely use recursion in our processing of the user input text. Map/filter will like be used when we execute the sounds we will program into our language.

Data abstraction will certainly be used in our parser, as we will have to take the user input, parse the syntax, and store what the user inputs. Not 100% sure yet on object orientation, though it would intuitively make sense to have a generic data object and specialize it for each type of sound we will support.

State modification will likely be a part of this program, though this isn't necessarily the best use of a functional language.

### Data set or other source materials
Data will be provided by the user

How will you convert that data into a form usable for your project?
We will parse the user input (a syntax/markdown similar to html).

### Deliverable and Demonstration
At the end we wish to have a GUI application that will take some user input and produce a sound. We would like to save the user input to disc.

### Evaluation of Results
How will you know if you are successful?
We will be able to type some text into a GUI program, press a button and sound will be produced by the computer.

## Architecture Diagram
![The Sound Editor](https://raw.githubusercontent.com/oplS16projects/Sound-Editor-JohnTylerTony/master/User%20Diagram.png)

The main part of the program is a GUI with a text input window. Tony will work on a syntax for the language of The Sound Editor, similar to HTML. John will work on parsing this language and storing it in some sort of data structure. Tyler will be passed the parsed sound data by John and his functions will play the sound.

Tyler will have to describe what the endpoints are for the rsound library so John can provide the data in a useful format. Tony will have to describe what sort of syntax rules he wants for the language so John can accurately parse the user input given to him by Tony's GUI.

## Schedule

### First Milestone (Fri Apr 15)
A working GUI program and some sort of syntax for our language has been produced for v1.0.
There is a basic implementation of the parser and the next milestone will include connecting the parser to the sound.rkt procedures to actually produce some sounds.

### Second Milestone (Fri Apr 22)
Work out the kinks in the parser and GUI program, sound will be produced by this date.

### Final Presentation (last week of semester)
Polish off the language, polish off the application and further extend if time allows (such as a visualization of the sound, like a graph or graphic). Be able to save user input to disc.

## Group Responsibilities
Here each group member gets a section where they, as an individual, detail what they are responsible for in this project. Each group member writes their own Responsibility section. Include the milestones and final deliverable.

### John Kilgo @john-kilgo *Team lead
John will work on the parser. The first milestone will be to have a data structure and accessors in place on the abstaction layer. He will have to communicate with Tony regarding what the syntax will be. John will then pass off some sort of interface to Tyler where he can access the parsed information to produce sounds.

The second milestone will be to have an actually working program and to polish up the parser so it makes better use of function programming paradigms.

### Tony @tventura1337
will work on creating the GUI text editor. The first milestone will be to create a working GUI so text can be input properly. The second milestone will feature a much more adaptive handler for the text (i.e. automatic ending tags). For the final deliverable the fully functional GUI will be ready. 

### Tyler @tylerbezuka
Tyler will work on the sound portion of the project using the rsound library. The first milestone will be producing a certain
sound based on the input recieved from the parser. He will communicate with John regarding how data will be recieved. The
second milestone will be to have a fully working program where all data recieved corresponds to a specific sound. 
