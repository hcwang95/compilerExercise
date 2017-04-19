typedef enum { typeConInt, typeConChar, typeConStr, \
               typeVar, typeOpr } nodeEnum;

/* constants */
typedef struct {
    int value;
    char str[500];                  /* value of constant */
} conNodeType;


/* identifiers */
typedef struct {
    int varType;                    /* type of the varible */
    int offset;                     /* offset of frame pointer in order to hold the value */
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

// TODO: remove it since it is no longer been in use in NAS
