// Recursive-descent top-down calculator
// for Question1 part f.
// author: WANG Haicheng
// date  : Mar 25, 2017

// To compile: make lrcal_postfix; 


%{
#include <stdio.h>
%}
%token NUMBER END
%{ 
  void yyerror(char *); 
  int yylex(void); 
%} 

%% 

prog: 
  expr { printf("=%d\n", $1); } '\n' prog
  | END { printf("BYE!\n"); exit(0); }
  ; 
expr: 
  expr expr '+' { $$ = $1 + $2;}
  | expr expr '-' { $$ = $1 - $2;}
  | expr expr '*' { $$ = $1 * $2;}
  | expr expr '/' { $$ = $1 / $2;}
  | NUMBER        { $$ = $1;}
  ; 

%% 

void yyerror(char *s) { fprintf(stderr, "%s\n", s); } 

int main(void) { 
  yyparse(); 
} 
