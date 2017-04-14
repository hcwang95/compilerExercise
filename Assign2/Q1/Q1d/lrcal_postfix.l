%option noyywrap

%{

#include <stdlib.h>
#include "lrcal_postfix.tab.h"

%}

%%

[[:digit:]]+	{ yylval = atoi(yytext); return NUMBER; }
[-+()=/*\n]	{ return *yytext; }
.

<<EOF>>	{ return END; }

%%
