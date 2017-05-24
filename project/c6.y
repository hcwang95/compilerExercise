%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "calc6.h"

// #ifndef CHECK
// #define CHECK
// #endif

// #ifndef DEBUG
// #define DEBUG
// #endif

// #ifndef CHECK1
// #define CHECK1
// #endif

extern int yylineno;
extern char* yytext;
extern char* line;
extern tableNode* mainVarTable;


/* prototypes */
nodeType *opr(int oper, int nops, ...);
nodeType *var(char* varName, int variableType);
nodeType *con(int value, char* str, int ConType);
void freeNode(nodeType *p);
void preprocessFuncDef(nodeType* p);
int ex(nodeType *p);
int yylex(void);
void yyerror(char *s);
void checkFunctionList(functionDefNode* root);
void strToLower(char* varName);
tableNode* getNodeFromTable(char* varName, tableNode* root);


tableNode* Table = NULL;
functionDefNode* funcDefList = NULL;
functionDefNode* funcReDefList = NULL;
static int varCount = 0;


%}

%union {
    int iValue;                 /* integer value and char value*/
    char varName[13];                /* varible name */
    char funcName[13];
    char str[500];                /* string content*/
    nodeType *nPtr;             /* node pointer */
};

%token <iValue> INTEGER
%token <str> STRING CHAR
%token <varName> VARIABLE GLOBALVARIABLE
%token <funcName> FUNCNAME
%token FOR WHILE IF PUTI PUTI_ PUTC PUTC_ PUTS PUTS_
%token GETI GETC GETS BREAK CONTINUE FUNC FUNCCALL FUNCDEF
%token FUNCTION RETURN
%token TYPE_INT TYPE_CHAR TYPE_STRING
%nonassoc IFX
%nonassoc ELSE

%left AND OR

%left GE LE EQ NE '>' '<'
%left '+' '-'
%left '*' '/' '%'
%nonassoc UMINUS
%nonassoc REF
%type <nPtr> stmt stmt_ expr expr_list stmt_list 
%type <nPtr> var function functiondef var_list

%%

program:
          function                { ex($1); 
                                    defineFunc(); 
                                    checkUndefinedFunc();
                                    cleanUp($1);
                                    exit(0); }
        ;

function:
          function functiondef stmt_         { $$ = opr(FUNC, 2, $1, $3); 
                                               preprocessFuncDef($2);
                                             }
        | /* NULL */                         {
                                                $$ = NULL;
                                             }
        ;

functiondef:
          FUNCTION FUNCNAME '(' var_list ')' '{' stmt_list '}' { $$ = opr(FUNCDEF, 3, var($2, typeVarFunc), $4, $7); }
        | /* NULL */                                           { $$ = NULL; }
        ;

stmt_:
          stmt                            { $$ = $1; }
        | /* NULL */                      { $$ = NULL; }

stmt:
          ';'                             { $$ = opr(';', 2, NULL, NULL); }
        | expr ';'                        { $$ = $1; }
        | PUTI expr ';'                   { $$ = opr(PUTI, 1, $2); }
        | PUTI_ expr ';'                  { $$ = opr(PUTI_, 1, $2); }
        | PUTC expr ';'                   { $$ = opr(PUTC, 1, $2); }
        | PUTC_ expr ';'                  { $$ = opr(PUTC_, 1, $2); }
        | PUTS expr ';'                   { $$ = opr(PUTS, 1, $2); }
        | PUTS_ expr ';'                  { $$ = opr(PUTS_, 1, $2); }
        | GETI expr ';'                   { $$ = opr(GETI, 1, $2); }
        | GETC expr ';'                   { $$ = opr(GETC, 1, $2); }
        | GETS expr ';'                   { $$ = opr(GETS, 1, $2); }
        | var '=' expr ';'                { $$ = opr('=', 2, $1, $3);}
        | BREAK ';'                       { $$ = opr(BREAK, 2, NULL, NULL); }
        | CONTINUE ';'                    { $$ = opr(CONTINUE, 2, NULL, NULL); }
	    | FOR '(' stmt stmt stmt ')' stmt { $$ = opr(FOR, 4, $3, $4,
                                            $5, $7); }
        | WHILE '(' expr ')' stmt         { $$ = opr(WHILE, 2, $3, $5); }
        | IF '(' expr ')' stmt %prec IFX  { $$ = opr(IF, 2, $3, $5); }
        | IF '(' expr ')' stmt ELSE stmt  { $$ = opr(IF, 3, $3, $5, $7); }
        | '{' stmt_list '}'               { $$ = $2; }
        | FUNCNAME  '(' expr_list ')' ';' { $$ = opr(FUNCCALL, 2, var($1,typeVarFunc), $3); }
        | RETURN expr                     { $$ = opr(RETURN, 1, $2); }
        | RETURN ';'                      { $$ = opr(RETURN, 1, NULL);}
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
        | FUNCNAME '(' expr_list ')' { $$ = opr(FUNCCALL, 2, var($1,typeVarFunc), $3); }
        ;


expr_list:
          expr                  { $$ = $1; }
        | expr_list ',' expr    { $$ = opr(',', 2, $1, $3); }
        | /* NULL */            { $$ = NULL; }
        ;
var :
          VARIABLE              { $$ = var($1, typeVar); }
        | TYPE_INT VARIABLE     { $$ = var($2, typeVarInt); }
        | TYPE_CHAR VARIABLE    { $$ = var($2, typeVarChar); }
        | TYPE_STRING VARIABLE  { $$ = var($2, typeVarStr); }
        | GLOBALVARIABLE        { $$ = var($1, typeGlobalVar); }
        | TYPE_INT GLOBALVARIABLE     { $$ = var($2, typeGlobalVarInt); }
        | TYPE_CHAR GLOBALVARIABLE    { $$ = var($2, typeGlobalVarChar); }
        | TYPE_STRING GLOBALVARIABLE  { $$ = var($2, typeGlobalVarStr); }
        | VARIABLE '[' expr ']' { $$ = opr(REF, 2, var($1, typeVar), $3); }
        ;

var_list:
          var                   { $$ = $1; }
        | var_list ',' var      { $$ = opr(',', 2, $1, $3); }
        | /* NULL */            { $$ = NULL; }
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
            p->con.value = value;
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
        #ifdef CHECK
        printf("get a value: %d\n", value);
        #endif
    }
    if (str!=NULL){
        strcpy(p->con.str, str);
        #ifdef CHECK
        printf("get a value: %s\n", p->con.str);
        #endif
    }

    return p;
}

nodeType *var(char* varName, int variableType) {
    strToLower(varName);
    #ifdef DEBUG
        printf("create Node for %s\n", varName);
    #endif
    nodeType *p;
    size_t nodeSize;

    /* allocate node */
    nodeSize = SIZEOF_NODETYPE + sizeof(varibleNodeType);
    if ((p = malloc(nodeSize)) == NULL)
        yyerror("out of memory");

    /* copy information */
    strcpy(p->var.varName, varName);
    p->type = variableType;
    #ifdef DEBUG
    printf("store the varible :%s \n", p->var.varName);
    #endif
    if (variableType == typeVar ||
        variableType == typeGlobalVar){
        // we just update the type there
        // TODO: store all variable line No.

        // ..............


    }else if (variableType >= typeVarInt && 
        variableType <= typeVarStr){
        // if the variable is the declaration
        tableNode * temp = getNodeFromTable(varName, Table);
        if (!temp){
            updateTable(varName, variableType, &Table);

        }
    }else if (variableType >= typeGlobalVarInt && 
                variableType <+ typeGlobalVarStr){
        // if the variable is the declaration
        tableNode * temp = getNodeFromTable(varName, Table);
        if (!temp){
            #ifdef CHECK1
            printf("find a new var\n");
            #endif
            updateTable(varName, variableType, &Table);
        }
    }
    else if(variableType == typeVarFunc){
        #ifdef DEBUG
            printf("finish node for function %s\n", varName);
        #endif
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

// // function to check if the variable name is alread
// // in the tableNode tree

// int isInTable(char* varName, tableNode* root){
//      if (root == NULL){
//         return 0;
//     }else{
//         int flag = strcmp(root->varName, varName);
//         if (flag == 0){
//             return 1;
//         }
//         else if(flag < 0){
//             return isInTable(varName, root->leftNode);
//         }else{
//             return isInTable(varName, root->rightNode);
//         }
//     }
// }


// depricated code



// int getOffsetFromTable(char* varName, tableNode* root){
//     if (root == NULL){
//         return -1;
//     }else{

//         int flag = strcmp(root->varName, varName);
//         if (flag == 0){
//             return root->offset;
//         }
//         else if(flag < 0){
//             return getOffsetFromTable(varName, root->leftNode);
//         }else{
//             return getOffsetFromTable(varName, root->rightNode);
//         }
//     }
// }

tableNode* getNodeFromTable(char* varName, tableNode* root){
    if (root == NULL){
        return NULL;
    }else{
        int flag = strcmp(root->varName, varName);
        if (flag == 0){
            return root;
        }else if(flag < 0){
            return getNodeFromTable(varName, root->leftNode);
        }else{
            return getNodeFromTable(varName, root->rightNode);
        }
    }
}


// function for storing info to the variable table

void updateTable(char* varName, int varType, tableNode** root){
    if (*root == NULL){
        tableNode * newOne = (tableNode*)malloc(sizeof(tableNode));
        strcpy(newOne->varName, varName);
        newOne->varType = varType;
        newOne->lineNo = yylineno;
        newOne->leftNode = NULL;
        newOne->rightNode = NULL;
        *root = newOne;
    }else{
        int flag = strcmp((*root)->varName, varName);
        if(flag < 0){
            updateTable(varName, varType, &((*root)->leftNode));
        }else{
            updateTable(varName, varType, &((*root)->rightNode));
        }
    }
}

void registerFunc(nodeType* p, functionDefNode** node){
    if(*node == NULL){
        functionDefNode* newOne = (functionDefNode*)malloc(sizeof(functionDefNode));
        newOne->p = p;
        newOne->next = NULL;
        *node = newOne;
    }else{
        registerFunc(p, &((*node)->next));
    }
}

void preprocessFuncDef(nodeType* p){
    // handle no definition case
    if (p==NULL){
        return 0;
    }
    #ifdef DEBUG
        printf("current varCount: %d\n", varCount);
    #endif



    // TODO: how to manage offset for all varibles offset


    // construct function only variable table
    // register to the final function def table
    registerFunc(p, &funcDefList);

    #ifdef DEBUG
        printf("finish register function\n");
        checkFunctionList(funcDefList);
    #endif
}




void checkFunctionList(functionDefNode* node){
    printf("check the function list\n");
    if (node == NULL){
        printf("finish the function check\n");
        return;
    }else{
        checkNode(node->p);
        printf("find a node with function name %s\n", node->p->opr.op[0]->var.varName);
        checkFunctionList(node->next);
    }
}


void strToLower(char* varName){
    int i = 0;
    for (i;varName[i];++i){
        varName[i] = tolower(varName[i]);
    }
}


void freeNode(nodeType *p) {
    int i;
    if (!p) return;
    if (p->type == typeOpr) {
        for (i = 0; i < p->opr.nops; i++)
            freeNode(p->opr.op[i]);
    }
    free (p);
}


void freeTable(tableNode* p){
    if(!p) return;
    // free subnode first
    freeTable(p->leftNode);
    freeTable(p->rightNode);
    // free it self
    free(p);
}

void cleanUp(nodeType* p){
    // clean parsing nodes
    freeNode(p); 
    // clean parsing info table
    freeTable(Table);
    // free main variable table
    
}



int main(int argc, char **argv) {
extern FILE* yyin;
    yyin = fopen(argv[1], "r");
    yyparse();
    return 0;
}
