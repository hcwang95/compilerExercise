# Compiler Exercise
homework for course [COMP 3235 Compiling techniques](http://www.cs.hku.hk/programme/course_info.jsp?infile=2016/comp3235.html) under HKU CS department.

## Assignment 1
Simple Text Parser (Using lex) for the following spec:
* All artificially split (hyphenated; hypen at the end of line) words be joined back.
* All sentences be followed by exactly two spaces, except for the last one or where the period is at the end of line.
* All consecutive multiple spaces ("space" = space or tab) be reduced to one single space (except for the two spaces following a sentence).
* The blank lines between paragraphs be removed, and each paragraph begins with an indentation of 3 spaces.


## Assignment 2
### Top down (Recursive Decent) & Bottom up parser and intepreter for simple calculator for prefix instructions
* Parsing: lex (flex)
* Syntax Analysis: Bison (Bottom Up)

### Improve a simple compiler
* Add break and continue statement
* Direct register access (virtual machine)

## Assignment 3,4 Project
See [README.txt](https://github.com/whcacademy/compilerExercise/tree/master/project)
