/*
 * A1.l - COMP3235 Assignment1 Question 3
 * 
 * flex A1.l  ; gcc -o myA1 A1.l lex.yy.c -lfl ; ./myA1
 */

%x expect end eof

%%
	/* handle the first three space*/
	printf("   ");

	/* handle hyphen*/
<expect>^\n[ \t]* {;}
<expect>[-a-zA-Z\,\.\?\!\;\'\":@#$%&()]+ {printf("%s\n",yytext);}
<expect>[ \t] {BEGIN(0);}


<end><<EOF>> {BEGIN(0);}
	/* handle paragraph and first three space of next paragraph*/
<end>([\n][ \t]*){2,} {BEGIN(eof);}
	/* handle dot just at end of line */
<end>\n {printf("\n");BEGIN(0);}
	/* normalize multiple space or other white symbols after "." to exact two space*/
<end>. {printf("  %s",yytext); BEGIN(0);}

<eof><<EOF>> {BEGIN(0);}
<eof>. {printf("\n   %s",yytext);BEGIN(0);}

	/* remove spaces at the beginning of every line*/
^[ \t]* {;}

	

	/* handle the case for the period at the end of line*/
[[:digit:]]"."[ \t]* printf("%s",yytext);
"."[ \t]* {printf(".");BEGIN(end);}

	/*"."[ \t]* printf(".  ");*/


	/* other more spaces are eliminate to only one */
[ \t][ \t]+ printf(" ");


	/* eliminate hyphen with newline*/
[[:alpha:]]/-\n printf("%s", yytext);
"-"\n {BEGIN(expect);}

	/* eliminate unexpected empty lines */
^[ \t]*\n  {;}
	/* otherwise print normal string */
.	printf("%s", yytext);
%%

int main() {
	yyin = stdin;
	yylex();
  
}