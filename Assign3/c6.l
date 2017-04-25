%{
#include <stdlib.h>
#include "calc6.h"
#include "y.tab.h"
#include <stdarg.h>
void yyerror(char *, ...);
char line[500];
char text[500];
typedef struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
} YYLTYPE;

// #define DEBUG

/* handle locations */
int yycolumn = 1;
YYLTYPE yylloc;

#define YY_USER_ACTION yylloc.first_line = yylloc.last_line = yylineno; \
    yylloc.first_column = yycolumn; yylloc.last_column = yycolumn+yyleng-1; \
    yycolumn += yyleng;
%}
%option yylineno 

%x string varfunc


%%

\n[^\n]*          {
                     strncpy(line, yytext+1, sizeof(line));/* save the next line */
                     yycolumn = 1;
                     yyless(1);        /* give back all but the \n to rescan */
                  }

0           {
                yylval.iValue = atoi(yytext);
                return INTEGER;
            }

[1-9][0-9]* {
                yylval.iValue = atoi(yytext);
                return INTEGER;
            }

[-,()<\[\]>=+*/;{}.%] {
                return *yytext;
             }
\"               { BEGIN string; *text = 0; }
<string>[^"\\]*  { strcat(text, yytext); }
<string>\"       { strcpy(yylval.str, text); BEGIN 0; return STRING; }
<string>\\\"     { strcat(text, "\\\""); }
<string>\\n      { strcat(text, "\\n"); }
<string>\\t      { strcat(text, "\\t"); }
<string>\\       { strcat(text, "\\"); }


'\\n'       { strcpy(yylval.str, "\'\\n\'"); return CHAR; }
'\\t'       { strcpy(yylval.str, "\'\\t\'"); return CHAR; }
'\\''       { strcpy(yylval.str, "\'\\\'");  return CHAR; }
'[^']'      { strcpy(yylval.str, yytext); return CHAR; }
''          { strcpy(yylval.str, "");    return CHAR; }


">="            return GE;
"<="            return LE;
"=="            return EQ;
"!="            return NE;
"for"		        return FOR;
"while"         return WHILE;
"if"            return IF;
"else"          return ELSE;
"break"         return BREAK;
"continue"      return CONTINUE;
"&&"		        return AND;
"||"		        return OR;
"puti"          return PUTI;
"puti_"         return PUTI_;
"putc"          return PUTC;
"putc_"         return PUTC_;
"puts"          return PUTS;
"puts_"         return PUTS_;
"geti"          return GETI;
"getc"          return GETC;
"gets"          return GETS;
"function"      return FUNCTION;



[[:alpha:]]([[:alnum:]]){0,11}         {
                                        strcpy(yylval.varName, yytext);
                                        BEGIN varfunc;
                                       }
<varfunc>[ \t\n]*                    ; /* ignore white space */
<varfunc>[^(]                        {
                                        #ifdef DEBUG 
                                        printf("find a varible : %s\n", yylval.varName);
                                        #endif
                                        yyless(0);
                                        BEGIN 0;
                                        return VARIABLE;
                                       }
<varfunc>"("                         {
                                         #ifdef DEBUG 
                                         printf("find a function : %s\n", yylval.varName);
                                         #endif
                                         strcpy(yylval.funcName, yylval.varName);
                                         yyless(0);
                                         BEGIN 0;
                                         return FUNCNAME;
                                       }


\/\/.*\n	;	/* skip comments */

[ \t]+        ;       /* ignore whitespace */


.               yyerror("Unknown character");
%%

void
yyerror(char *s, ...)
{
  va_list ap;
  va_start(ap, s);


  if(yylloc.first_line){
    int i = 0;
    char* mark = (char*)malloc((yylloc.last_column+1) * sizeof(char));
    for (i;i<=yylloc.last_column;++i){
        if (i<yylloc.first_column-2){
            mark[i] = ' ';
        }else{
            mark[i] = '^';
        }
    }
    fprintf(stderr, "line:%d error: %s at this line:\n%s\n%s\n", yylloc.first_line, s, \
        line,mark);
  }
   
  fprintf(stderr, "\n");
  exit(syntaxError);

}



int yywrap(void) {
    return 1;
}
