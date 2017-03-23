// This one adds a mid-point character "#" (for odd-length palindromes)
// Example input: aaabba#abbaaa

%{
#include <stdio.h>
%}

%token A B R

%%

S: S X R {printf("Ok!\n");} |
X: A X A | B X B | '#' |

%%

int main() {
  yyparse();
}

int yyerror(char* s) {}
