A1: A1.l
	flex A1.l
	gcc -o A1 lex.yy.c -lfl

test: input.txt A1
	./A1 <input.txt

test_o: input.txt A1
	./A1 <input.txt >output.txt


