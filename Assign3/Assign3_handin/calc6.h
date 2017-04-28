typedef enum { typeConInt, typeConChar, typeConStr, \
               typeVar, typeVarInt, typeVarChar, typeVarStr, \
               typeOpr, typeVarFunc, typeGlobalVar, typeUnknown } nodeEnum;


typedef enum { variableUseBeforeDefined=1, typeMisMatched, breakContinueError,\
               syntaxError, funcUnused, funcUndefined, functionRedefined,\
               invalidReturn  } exitCodeEnum;

typedef enum { funcDef=0, funcMain, funcReDef} funcType;
/* constants */
typedef struct {
    int value;
    char str[500];                  /* value of constant */
} conNodeType;


/* identifiers */
typedef struct {
    int varType;                    /* type of the varible */
    char varName[13];             
} varibleNodeType;

/* operators */
typedef struct {
    int oper;                   /* operator */
    int nops;                   /* number of operands */
    struct nodeTypeTag *op[1];  /* operands (expandable) */
} oprNodeType;

typedef struct nodeTypeTag {
    nodeEnum type;              /* type of node */

    /* union must be last entry in nodeType */
    /* because operNodeType may dynamically increase */
    union {
        conNodeType con;        /* constants */
        varibleNodeType var;          /* identifiers */
        oprNodeType opr;        /* operators */
    };
} nodeType;

typedef struct tableNode{
    char varName[13];
    int varType;
    int offset;
    int lineNo;
    struct tableNode * leftNode;
    struct tableNode * rightNode;
}tableNode;


typedef struct functionNode
{
    char funcName[13];
    int label;
    int paramCount;
    int defined;
    struct functionNode* leftNode;
    struct functionNode* rightNode;
}functionNode;

typedef struct functionDefNode
{
    nodeType* p;
    struct functionDefNode* next;
}functionDefNode;