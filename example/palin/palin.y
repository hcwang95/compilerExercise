// Even-length palindromes
// This one won't work as bison (LALR parser by default) doesn't know
//   which is the midpoint; if you add the following line at the
//   beginning, bison then uses Generalized LR (GLR), and it will work
//        %glr-parser

%{
#include <stdio.h>
%}

%token A B R

%%

S: S X R {printf("Ok!\n");} |
X: A X A | B X B |

%%

int main() {
  yyparse();
}

int yyerror(char* s) {}
