COMP 3235 Project


Compile Instruction:
	make c6c

Execution Instruction:
	./c6c {source file} > {destination path} 



Feature List:

Basic feature:
	variable support (as assignment specification required)
	global variable  (allow declare global variable in main, is same as declare and use 
					  a normal variale in main.)
	function support (One difference is a identifier 'function' is needed for prefix of
					  function definition)
	Multidimentional Array (Support passing local array to another function, restrict 
					  passing global array to local functions)

More feature:
	Programming Language Feature Support:
		function definition ***anywhere, no declaration.
			support function used before definition.
		function overloading in terms of argument number.
		support no declaration.
		basic type checking and type inference.

	Error checking support:
		determined type violation
		function redefinition error
		function used but not defined error
		break continue usage error
		variable used before defined error
		(partially) type violation error
		invalid return error (return at main funcition)
		error related to array usage and declaration




	User Experience Support:
		syntax error location suggestion (line No. and line content with indication)
		error code return (in calc6.h there is a enumation table)

	machine code optimization support:
		Do not compile all statments after return
			multiple return(in a blokc) only compile first return
		Do not compile function defined but not used


Test Case:
	tic_tac_toe.nc

Compilation:
	./c6c tic_tac_toe.nc > tic_tac_toe.nas

Execution:
	./nas_test tic_tac_toe.nas


(***)anywhere means you can define your function between two statements of main function.
