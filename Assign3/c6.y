%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "calc6.h"

#ifndef CHECK
#define CHECK
#endif


extern int yylineno;
extern char* linebuf;
extern char* yytext;

/* prototypes */
nodeType *opr(int oper, int nops, ...);
nodeType *var(char* varName);
nodeType *con(int value, char* str, int ConType);
void freeNode(nodeType *p);
int ex(nodeType *p);
int yylex(void);

void yyerror(char *s);
typedef struct tableNode{
    char varName[12];
    int offset;
    struct tableNode * leftNode;
    struct tableNode * rightNode;
}tableNode;

tableNode* Table = NULL;

static int varCount = 0;
%}

%union {
    int iValue;                 /* integer value and char value*/
    char varName[12];                /* varible name */
    char str[500];                /* string content*/
    nodeType *nPtr;             /* node pointer */
};

%token <iValue> INTEGER
%token <str> STRING CHAR
%token <varName> VARIABLE
%token FOR WHILE IF PUTI PUTI_ PUTC PUTC_ PUTS PUTS_ GETI GETC GETS BREAK CONTINUE 
%nonassoc IFX
%nonassoc ELSE

%left AND OR

%left GE LE EQ NE '>' '<'
%left '+' '-'
%left '*' '/' '%'
%nonassoc UMINUS
%nonassoc REF
%type <nPtr> stmt expr stmt_list var

%%

program:
        function                { exit(0); }
        ;

function:
          function stmt         { ex($2); freeNode($2); }
        | /* NULL */
        ;

stmt:
          ';'                             { $$ = opr(';', 2, NULL, NULL); }
        | expr ';'                        { $$ = $1; }
        | PUTI expr ';'                  { $$ = opr(PUTI, 1, $2); }
        | PUTI_ expr ';'                  { $$ = opr(PUTI_, 1, $2); }
        | PUTC expr ';'                  { $$ = opr(PUTC, 1, $2); }
        | PUTC_ expr ';'                  { $$ = opr(PUTC_, 1, $2); }
        | PUTS expr ';'                  { $$ = opr(PUTS, 1, $2); }
        | PUTS_ expr ';'                  { $$ = opr(PUTS_, 1, $2); }
        | GETI expr ';'                    { $$ = opr(GETI, 1, $2); }
        | GETC expr ';'                    { $$ = opr(GETC, 1, $2); }
        | GETS expr ';'                    { $$ = opr(GETS, 1, $2); }
        | var '=' expr ';'                { $$ = opr('=', 2, $1, $3); }
        | BREAK ';'                       { $$ = opr(BREAK, 2, NULL, NULL);}
        | CONTINUE ';'                    { $$ = opr(CONTINUE, 2, NULL, NULL);}
	    | FOR '(' stmt stmt stmt ')' stmt { $$ = opr(FOR, 4, $3, $4,
                                            $5, $7); 
    }
        | WHILE '(' expr ')' stmt         { $$ = opr(WHILE, 2, $3, $5); }
        | IF '(' expr ')' stmt %prec IFX  { $$ = opr(IF, 2, $3, $5); }
        | IF '(' expr ')' stmt ELSE stmt  { $$ = opr(IF, 3, $3, $5, $7); }
        | '{' stmt_list '}'               { $$ = $2; }
        ;

stmt_list:
          stmt                  { $$ = $1; }
        | stmt_list stmt        { $$ = opr(';', 2, $1, $2); }
        ;

expr:
          INTEGER               { $$ = con($1, NULL, 1); }
        | CHAR                  { $$ = con(NULL, $1, 2); }
        | STRING                { $$ = con(NULL, $1, 3); }
        | var                   { $$ = $1; }
        | '-' expr %prec UMINUS { $$ = opr(UMINUS, 1, $2); }
        | expr '+' expr         { $$ = opr('+', 2, $1, $3); }
        | expr '-' expr         { $$ = opr('-', 2, $1, $3); }
        | expr '*' expr         { $$ = opr('*', 2, $1, $3); }
        | expr '%' expr         { $$ = opr('%', 2, $1, $3); }
        | expr '/' expr         { $$ = opr('/', 2, $1, $3); }
        | expr '<' expr         { $$ = opr('<', 2, $1, $3); }
        | expr '>' expr         { $$ = opr('>', 2, $1, $3); }
        | expr GE expr          { $$ = opr(GE, 2, $1, $3); }
        | expr LE expr          { $$ = opr(LE, 2, $1, $3); }
        | expr NE expr          { $$ = opr(NE, 2, $1, $3); }
        | expr EQ expr          { $$ = opr(EQ, 2, $1, $3); }
	    | expr AND expr		    { $$ = opr(AND, 2, $1, $3); }
	    | expr OR expr		    { $$ = opr(OR, 2, $1, $3); }
        | '(' expr ')'          { $$ = $2; }
        ;

var :
          VARIABLE              { $$ = var($1);}
        | VARIABLE '[' expr ']' { $$ = opr(REF, 2, var($1), $3); }
        ;
%%

#define SIZEOF_NODETYPE ((char *)&p->con - (char *)p)

nodeType *con(int value, char* str, int ConType) {
    nodeType *p;
    size_t nodeSize;

    /* allocate node */
    nodeSize = SIZEOF_NODETYPE + sizeof(conNodeType);
    if ((p = malloc(nodeSize)) == NULL)
        yyerror("out of memory");

    /* copy information */
    switch (ConType){
        case 1: // integer
            p->type = typeConInt;
            break;
        case 2: // char
            p->type = typeConChar;
            break;
        case 3: // string
            p->type = typeConStr;
            break;
    }

    if (value!=NULL){
        p->con.value = value;
    }
    if (str!=NULL){
        strcpy(p->con.str, str);
    }

    return p;
}

nodeType *var(char* varName) {
    #ifdef CHECK
        printf("create Node for %s\n", varName);
    #endif
    nodeType *p;
    size_t nodeSize;

    /* allocate node */
    nodeSize = SIZEOF_NODETYPE + sizeof(varibleNodeType);
    if ((p = malloc(nodeSize)) == NULL)
        yyerror("out of memory");

    /* copy information */
    p->type = typeVar;

    // set the offset
    int offset = getOffsetFromTable(varName, Table);

    if (offset == -1){
        p->var.offset = varCount++;
        updateTable(varName, p->var.offset, &Table);
    }else{
        p->var.offset = offset;
    }

    return p;
}

nodeType *opr(int oper, int nops, ...) {
    va_list ap;
    nodeType *p;
    size_t nodeSize;
    int i;

    /* allocate node */
    nodeSize = SIZEOF_NODETYPE + sizeof(oprNodeType) +
        (nops - 1) * sizeof(nodeType*);
    if ((p = malloc(nodeSize)) == NULL)
        yyerror("out of memory");

    /* copy information */
    p->type = typeOpr;
    p->opr.oper = oper;
    p->opr.nops = nops;
    va_start(ap, nops);
    for (i = 0; i < nops; i++)
        p->opr.op[i] = va_arg(ap, nodeType*);
    va_end(ap);
    return p;
}

void freeNode(nodeType *p) {
    int i;

    if (!p) return;
    if (p->type == typeOpr) {
        for (i = 0; i < p->opr.nops; i++)
            freeNode(p->opr.op[i]);
    }
    // else if (p->type == typeVarInt ||
    //             p->type == typeVarChar ||
    //             p->type == typeVarStr){
    //     free()
    // }
    free (p);
}


int getOffsetFromTable(char* varName, tableNode* root){
    if (root == NULL){
        return -1;
    }else{

        int flag = strcmp(root->varName, varName);
        if (flag == 0){
            return root->offset;
        }
        else if(flag < 0){
            return getOffsetFromTable(varName, root->leftNode);
        }else{
            return getOffsetFromTable(varName, root->rightNode);
        }
    }
}

void updateTable(char* varName, int offset, tableNode** root){
    if (*root == NULL){
        tableNode * newOne = (tableNode*)malloc(sizeof(tableNode));
        strcpy(newOne->varName, varName);
        newOne->offset = offset;
        newOne->leftNode = NULL;
        newOne->rightNode = NULL;
        *root = newOne;
    }else{
        int flag = strcmp((*root)->varName, varName);
        if(flag < 0){
            updateTable(varName, offset, &((*root)->leftNode));
        }else{
            updateTable(varName, offset, &((*root)->rightNode));
        }
    }
}

void yyerror(char *s) {
    fprintf(stderr, "line %d: %s at %s in this line:\n%s\n",
               yylineno, s, yytext, linebuf);
}

int main(int argc, char **argv) {
extern FILE* yyin;
    yyin = fopen(argv[1], "r");
    yyparse();
    return 0;
}
