# this is the make file for question 2

c5i: lex.yy.c c5i.tab.c c5i.c
	mv c5i.tab.h y.tab.h
	gcc -o c5i lex.yy.c c5i.tab.c c5i.c

c5c: lex.yy.c c5c.tab.c c5c.c c5c.tab.h
	mv c5c.tab.h y.tab.h
	gcc -o c5c lex.yy.c c5c.tab.c c5c.c

sas2: sas2.c sas2.tab.c
	gcc -o sas2 sas2.c sas2.tab.c

sas2.c: sas2.l
	flex -o sas2.c sas2.l

sas2.tab.c: sas2.y
	bison -d sas2.y


lex.yy.c: c5.l
	flex c5.l

c5i.tab.c: c5i.y
	bison -d c5i.y
c5i.tab.h: c5i.y
	bison -d c5i.y


c5c.tab.c: c5c.y
	bison -d c5c.y
c5c.tab.h: c5c.y
	bison -d c5c.y