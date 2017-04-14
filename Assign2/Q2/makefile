# this is the make file for question 2

all : c5i c5c sas2

c5i: lex.yy.c y.tab.c c5i.c 
	gcc -o c5i lex.yy.c y.tab.c c5i.c

c5c: lex.yy.c y.tab.c c5c.c
	gcc -o c5c lex.yy.c y.tab.c c5c.c

sas2: sas2.c sas2.tab.c
	gcc -o sas2 sas2.c sas2.tab.c

sas2.c: sas2.l
	flex -o sas2.c sas2.l

sas2.tab.c: sas2.y
	bison -d sas2.y


lex.yy.c: c5.l
	flex c5.l

y.tab.c: c5.y
	bison -y -d c5.y


cleanc5:
	$(RM) lex.yy.c y.tab.c y.tab.h c5i c5c

cleansas2:
	$(RM) sas2.c sas2.tab.c sas2.tab.h sas2

