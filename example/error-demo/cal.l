%option noyywrap yylineno

%{
  #include "y.tab.h"

  int yycolumn = 1;
  #define YY_USER_ACTION yylloc.first_line = yylloc.last_line = yylineno;\
    yylloc.first_column = yycolumn; yylloc.last_column = yycolumn+yyleng-1;\
    yycolumn += yyleng;

%}
%%
[0-9]+ { yylval.intVal = atoi(yytext); return T_Int;}
[a-zA-Z]+ { strncpy(yylval.name, yytext, 32); return T_Identifier;}
[-+*/()=] { return yytext[0];}
\n { yycolumn = 1; return yytext[0]; }
[ \t]* { /* ignore whitespace */ }
