%{
#include <stdlib.h>
#include "sas2.tab.h"
#include <strings.h>
void yyerror(char *);
%}

%%

[0-9]+		{
		  yylval = atoi(yytext);
		  return INT;
		}
[a-z]		{
		  yylval = *yytext - 'a';
		  return REG;
		}
L[0-9]{3}	{
		  yylval = atoi(yytext + 1); // L123 -> 123
		  return LABEL;
		}
":"		return ':';
"push"		return PUSH;
"pop"		return POP;
"pushi"		return PUSHI;
"popi"		return POPI;
"compLT"	return LT;
"compGT"	return GT;
"compGE"	return GE;
"compLE"	return LE;
"compNE"	return NE;
"compEQ"	return EQ;
"jz"		return JZ;
"jmp"		return JMP;
"add"		return ADD;
"sub"		return SUB;
"mul"		return MUL;
"div"		return DIV;
"mod"		return MOD;
"neg"		return NEG;
"and"		return AND;
"or"		return OR;
"read"		return READ;
"print"		return PRINT;
[ \t\n]+	;
"//".*\n        ;
.		yyerror(strcat(yytext, ": unknown character"));

%%

int yywrap(void) {
  return 1;
}
