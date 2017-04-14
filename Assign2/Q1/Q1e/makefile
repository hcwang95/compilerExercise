
# all: lrcal_postfix rdcal_postfix

# lrcal_postfix : lr.lex.yy.c lrcal_postfix.tab.c
# 	gcc -o lrcal_postfix lr.lex.yy.c  lrcal_postfix.tab.c

rdcal_postfix : rd.lex.yy.c rdcal_postfix.c
	gcc -o rdcal_postfix rd.lex.yy.c  rdcal_postfix.c

# lrcal_postfix.l:
# 	flex lrcal_postfix.l

# lrcal_postfix.tab.c: lrcal_postfix.y
# 	bison -d lrcal_postfix.y

rd.lex.yy.c:
	flex rdcal_postfix.l
	mv lex.yy.c rd.lex.yy.c

# lr.lex.yy.c: lrcal_postfix.l
# 	flex lrcal_postfix.l
# 	mv lex.yy.c lr.lex.yy.c
# cleanlrcal_postfix:
# 	rm lrcal_postfix lrcal_postfix.tab.* lr.lex.yy.c
cleanrdcal_postfix:
	rm rdcal_postfix rd.lex.yy.c
