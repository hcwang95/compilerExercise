/* Binary numbers divisible by 5 */

%{
#include <stdio.h>
%}

%%
(0*1(10)*(0|11)(01*0(01)*(1|00))*1)*0*	{ printf("%s - YES!\n", yytext); }
.*	{ printf("%s - NO!\n", yytext); }
\n
%%

main() {
  yylex();
}
