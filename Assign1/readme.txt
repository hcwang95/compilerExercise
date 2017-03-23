Readme for assignment1 question 3

Author : WANG Haicheng
UID    : 3035140108



Feature List:

1. auto join words with hyphen, if the word is followed by a punctuation mark, now we support comma, period, colon, semicolon, exclamation mark, question mark and some special punctuation marks possible (@(#$%  and so on).
2. let two spaces follow by a sentence which is not the last one or ending with period.
3. For sentence ending with period, original spaces will be maintained, after last sentence, there will be no space or tabs or lines.
4. change all consecutive spaces and tabs into exact one space except for the end of sentence.
5. make each paragraph start with 3 spaces and eliminate the empty one line or multiple lines between paragraph, even the line(s) contains spaces or tabs.
6. eliminate all other unexpected empty line(s) even with some spaces.


Files in the Folder:
A1.l    ---- Source File
readme.txt - This file
input.txt  - Sample test file testing all cases in the feature list
Makefile  -- Help to compile and test

Running Instruction:

1. compile:

'make A1'

2. run the test and print out solution:

First open a file called 'input.txt' and then put test file in it.

'make test'

3. run the file and get output.txt

'make test_o'

4. if you would like to test another file, just use

'./myA1 <[filename]'


Remainder:

From the makefile you could know that I use feeding file to stdin to do the filtering task.
But after test with another method actually they are the same. It is because the signal <<EOF>> can be added by the stdin, but one thing to remind is that <<EOF>> cannot appear in the output of the terminal(may be triggered by terminal driver). And the <<EOF>> of the output file is probably auto added by the OS instead of the program.
