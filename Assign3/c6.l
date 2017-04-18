%{
#include <stdlib.h>
#include "calc6.h"
#include "y.tab.h"
void yyerror(char *);
char text[500];
%}

%x string


%%

// [a-z]       { 
//                 yylval.sIndex = *yytext - 'a';
//                 return VARIABLE;
//             }

0           {
                yylval.iValue = atoi(yytext);
                return INTEGER;
            }

[1-9][0-9]* {
                yylval.iValue = atoi(yytext);
                return INTEGER;
            }

[-()<\[\]>=+*/;{}.%] {
                return *yytext;
             }
\"      { BEGIN string; *text = 0; }
<string>[^"\\]*  { strcat(text, yytext); }
<string>\"       { strcpy(yylval.str, text); BEGIN 0; return STRING; }
<string>\\\"     { strcat(text, "\""); }
<string>\\n      { strcat(text, "\n"); }
<string>\\t      { strcat(text, "\t"); }
<string>\\       { strcat(text, "\\"); }


'\\n'       { yylval.iValue = (int) '\n'; return CHAR; }
'\\t'       { yylval.iValue = (int) '\t'; return CHAR; }
'\\''       { yylval.iValue = (int) '\''; return CHAR; }
''          { yylval.iValue = 0; return CHAR; }
'[^']'      { yylval.iValue = (int) yytext[1]; return CHAR; }


">="            return GE;
"<="            return LE;
"=="            return EQ;
"!="            return NE;
"for"		    return FOR;
"while"         return WHILE;
"if"            return IF;
"else"          return ELSE;
"break"         return BREAK;
"continue"      return CONTINUE;
"read"		    return READ;
"&&"		    return AND;
"||"		    return OR;
"puti"          return PUTI;
"puti_"         return PUTI_;
"putc"          return PUTC;
"putc_"         return PUTC_;
"puts"          return PUTS;
"puts_"         return PUTS_;

    // here we add the variable
[[:alpha:]]([[:alnum:]]){0,11}         {strcpy(yylval.varName, text); 
                                        return VARIABLE;}

\/\/.*\n	;	/* skip comments */

[ \t\n]+        ;       /* ignore whitespace */

.               yyerror("Unknown character");
%%
int yywrap(void) {
    return 1;
}
