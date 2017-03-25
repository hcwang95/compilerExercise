%option noyywrap

%{

#include <stdio.h>
#include <stdlib.h>

enum {NUM=1, ADD, SUB, MUL, DIV, NL, END};

int tokenValue;

%}

%%

[[:digit:]]+	{ tokenValue = atoi(yytext); return NUM; }
"+"	{ return ADD; }
"-"	{ return SUB; }
"*"	{ return MUL; }
"/"	{ return DIV; }
\n	{ return NL; }
.

<<EOF>>	{ return END; }

%%