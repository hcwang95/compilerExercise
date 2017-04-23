#include <stdio.h>
#include "calc6.h"
#include "y.tab.h"

static int lbl;
static int currenVarCount;
extern tableNode* Table;
static tableNode* typeTable;


// #ifndef CHECK
// #define CHECK
// #endif

// #ifndef DEBUG
// #define DEBUG
// #endif



#ifdef DEBUG
void checkNode(nodeType* p){
    if (!p) return;
    printf("check the node info: \n");
    printf("node type: %d\n", p->type);
    printf("node type reference:\n\ttypeConInt:0\n\ttypeConChar:1\n\ttypeConStr:2 \
               \n\ttypeVar:3\n\ttypeVarInt:4\n\ttypeVarChar:5\n\ttypeVarStr:6 \
               \n\ttypeOpr:7\n");
    if (p->type == typeConInt){
        printf("constant int in the node: %d\n", p->con.value);
    }else if(p->type == typeConStr){
        printf("constant str in the node: %s\n", p->con.str);
    }else if(p->type == typeConChar){
        printf("constant char in the node: %c\n", (char)p->con.value);
    }else if(p->type == typeVar||
             p->type == typeVarInt ||
             p->type == typeVarChar||
             p->type == typeVarStr){
        printf("the offset of the varible is: %d\n", p->var.offset);
    }else if(p->type == typeOpr){
        printf("this is opration node, totally there is %d subNodes\n", p->opr.nops);
        printf("Here are the subNodes infomation:\n");  
        int i;        
        for (i = 0; i < p->opr.nops; i++){
            checkNode(p->opr.op[i]);
        }
        printf("finish the printing for the subNodes of opration node with oprator %c.\n", (char)p->opr.oper);
    }
}

void checkTableNode(tableNode* root){
    if (root == NULL){
        return;
    }else{
        printf("checking Node:\n");
        printf("\tvarName:%s\n\tvarType:%d\n\toffset:%d\n", root->varName, root->varType, root->offset);
        printf("checking its subnodes\n");
        checkTableNode(root->leftNode);
        checkTableNode(root->leftNode);
        printf("finish chekcing subnodes for variable:%s\n", root->varName);
    }
}
#endif


int size(tableNode* root){
    if (root == NULL){
        return 0;
    }
    else{
        return size(root->leftNode) + size(root->rightNode) + 1;
    }
}
void reportOutOfLoop(){
    yyerror("break or continue statement not within loop\n");
    exit(breakContinueError);
}

void reportInvalid(){
    fprintf(stderr, "invalid break or continue statement\n");
    exit(breakContinueError);
}

void reportUndefined(int offset){
    tableNode* var;
    var = getNodeFromTable(offset, Table);
    fprintf(stderr, "line %d: undefined varible: '%s'\n", var->lineNo, var->varName);
    exit(variableUseBeforeDefined);
}

void reportMisMatched(){
    fprintf(stderr, "the type of argument does not match the function used\n" );
    exit(typeMisMatched);
}

int getTypeFromTable(int offset, tableNode* root){
    if (root==NULL){
        return -1;
    }else{
        if (root->offset == offset){
            return root->varType;
        }else{
            return getTypeFromTable(offset, root->leftNode)!=-1?
                    getTypeFromTable(offset, root->leftNode):
                    getTypeFromTable(offset, root->rightNode);
        }
    }
}

void createTypeNode(tableNode* src, tableNode** root){
    if (*root==NULL){
        tableNode* newOne = (tableNode*)malloc(sizeof(tableNode));
        strcpy(newOne->varName, src->varName);
        newOne->varType = typeVar;
        newOne->offset = src->offset;
        newOne->lineNo = src->lineNo;
        newOne->leftNode = NULL;
        newOne->rightNode = NULL;
        *root = newOne;
    }else{
        int flag = strcmp((*root)->varName, src->varName);
        if(flag < 0){
            createTypeNode(src, &((*root)->leftNode));
        }else{
            createTypeNode(src, &((*root)->rightNode));
        }
    }
}

void updateNodeType(int offset, int type, tableNode* root){
    #ifdef DEBUG
    printf("starting update inside fucntion updateNodeType\n");
    #endif
    if (root==NULL){
        return;
    }else{
        if(root->offset == offset){
            root->varType = type;
            #ifdef DEBUG
            printf("update the varType in some node\n");
            #endif
        }else{
            #ifdef DEBUG
            printf("update the varType in subnode\n");
            #endif
            updateNodeType(offset, type, root->leftNode);
            updateNodeType(offset, type, root->rightNode);
        }
    }
}
void updateCurrentVarCountAndTypeTable(int offset){
    currenVarCount++;
    // create a node and add in typetable
    
    tableNode* node = getNodeFromTable(offset, Table);
    #ifdef DEBUG
    printf("starting creating node for the varible: %s\n", node->varName);
    #endif
    createTypeNode(node, &typeTable);
    #ifdef DEBUG
    printf("finish creating node for the varible: %s\n", node->varName);
    #endif


}
int checkDefined(nodeType *p){
    #ifdef DEBUG
    printf("check varible definition\n");
    #endif

    //

    // TDOO redefine the rule


    //
    if (p->var.offset >= currenVarCount){
        reportUndefined(p->var.offset);
        return -1;
    }
    return getTypeFromTable(p->var.offset, typeTable);
}


void checkUndefiedAndMatching(nodeType *p, int typeCon){
    if (p->type == typeVar){
        #ifdef DEBUG
        printf("find the type of varible\n");
        #endif
        int typeVar = checkDefined(p);
        if (typeVar - typeCon !=4){
            #ifdef CHECK
            printf("typeVar: %d, typeCon: %d\n", typeVar, typeCon);
            #endif
            reportMisMatched();
        }
        #ifdef DEBUG
        printf("check the variable finish\n");
        #endif
    }else if (p->type == typeOpr){
        int i;
        for (i = 0; i < p->opr.nops; i++){
            checkUndefiedAndMatching(p->opr.op[i], typeCon);
        }
    }else{
        #ifdef DEBUG
        printf("find the type of constant\n");
        #endif
        if (p->type != typeCon){
            reportMisMatched();
        }
    }
}

void localMemAlloc(int size){
    printf("\tpush\tsp\n");
    printf("\tpush\t%d\n", size);
    printf("\tadd\n");
    printf("\tpop\tsp\n");
}

// this function have two responsibilties:
// 1. check if the expression is consistent in terms of type
// 2. if consistent, return the consistent type.

int getType(nodeType* p){
    if (p->type == typeVar) {
        return checkDefined(p);
    }
    if (p->type == typeConInt) return typeConInt;
    if (p->type == typeConChar) return typeConChar;
    if (p->type == typeConStr) return typeConStr;
    if (p->type == typeOpr){
        if (p->opr.nops == 1){
            return getType(p->opr.op[0]); // deal with UMINUS
        }else{
            // deal with double operands
            int * typeList = (int*)malloc(p->opr.nops * sizeof(int));
            int i;        
            for (i = 0; i < p->opr.nops; ++i){
                typeList[i] = getType(p->opr.op[i]);
                // if there is one variable undefined
                if (typeList[i] == -1){
                    return -1;
                }
            }
            int accType = -1;
            // currently not allow string or char as valid argument for AND OR
            for (i = 0; i < p->opr.nops; ++i){
                if (accType==-1){
                    accType = typeList[i];
                }else{
                    if (accType != typeList[i]){
                        reportMisMatched();
                        return -1;
                    }
                }
            }
            return accType;
        }
    }
}

void updateVarType(nodeType * p, int type){
    if (type == -1){
        return;
    }else{
        #ifdef DEBUG
        checkTableNode(typeTable);
        printf("starting updating type node table for offset: %d\n", p->var.offset);
        #endif

        updateNodeType(p->var.offset, type, typeTable);
        #ifdef DEBUG
        printf("finish updating type node table\n");
        #endif
    }

}
int ex_(nodeType *p, int lcont, int lbrk);
int ex(nodeType *p){
    int functionTotalVarCount = size(Table);
    #ifdef DEBUG
    fprintf(stderr, "total varible size : %d\n", functionTotalVarCount);
    #endif
    localMemAlloc(functionTotalVarCount);
    ex_(p,-1,-1);
    // printf("\tend\n");
}

int ex_(nodeType *p, int lcont, int lbrk) {
    int lblx, lbly, lblz, lbl1, lbl2, itr, index, type;
    if (!p) return 0;
    switch(p->type) {
      case typeConInt:       
          #ifdef DEBUG
            printf("find the constant int %d\n", p->con.value);
          #endif
          printf("\tpush\t%d\n", p->con.value);
          break;
      case typeConChar:
          printf("\tpush\t%s\n", p->con.str);
          break;
      case typeConStr:
          printf("\tpush\t\"%s\"\n", p->con.str);
          break;
      case typeVar:        
          printf("\tpush\tfp[%d]\n", p->var.offset);
          break;
      case typeOpr:
          switch(p->opr.oper) {
            case FUNC:
                ex_(p->opr.op[0], lcont, lbrk);
                ex_(p->opr.op[1], lcont, lbrk);
                break;
            case FOR: 
                // check statement without break and continue
                for (itr=0; itr<3; ++itr){
                    if (p->opr.op[itr]->opr.oper == BREAK ||
                        p->opr.op[itr]->opr.oper == CONTINUE){
                        reportInvalid();
                    }
                }
                #ifdef DEBUG
                checkNode(p);
                #endif
                ex_(p->opr.op[0], lcont, lbrk);
                printf("L%03d:\n", lblx = lbl++);
                ex_(p->opr.op[1], lcont, lbrk);
                printf("\tj0\tL%03d\n", lbly = lbl++);
                ex_(p->opr.op[3], lblz = lbl++, lbly);
                printf("\tjmp\tL%03d\n", lblz);
                printf("L%03d:\n", lblz);
                ex_(p->opr.op[2], lcont, lbrk);
                printf("\tjmp\tL%03d\n", lblx);
                printf("L%03d:\n", lbly);
                break;
            case WHILE:
                // check statement without break and continue
                if (p->opr.op[0]->type == typeOpr){
                  if (p->opr.op[0]->opr.oper == BREAK ||
                      p->opr.op[0]->opr.oper == CONTINUE){
                      reportInvalid();
                  }
                }
                printf("L%03d:\n", lbl1 = lbl++);
                ex_(p->opr.op[0], lcont, lbrk);
                printf("\tj0\tL%03d\n", lbl2 = lbl++);
                ex_(p->opr.op[1], lbl1, lbl2);
                printf("\tjmp\tL%03d\n", lbl1);
                printf("L%03d:\n", lbl2);
                break;
            case IF:
                // check statement without break and continue
                if (p->opr.op[0]->type == typeOpr){
                  if (p->opr.op[0]->opr.oper == BREAK ||
                      p->opr.op[0]->opr.oper == CONTINUE){
                      reportInvalid();
                  }
                }
                ex_(p->opr.op[0], lcont, lbrk);
                if (p->opr.nops > 2) {
                    /* if else */
                    printf("\tj0\tL%03d\n", lbl1 = lbl++);
                    #ifdef DEBUG
                        printf("positive part\n");
                    #endif
                    ex_(p->opr.op[1], lcont, lbrk);
                    #ifdef DEBUG
                        printf("jump to negative part\n");
                    #endif
                    printf("\tjmp\tL%03d\n", lbl2 = lbl++);
                    printf("L%03d:\n", lbl1);
                    ex_(p->opr.op[2], lcont, lbrk);
                    printf("L%03d:\n", lbl2);
                } else {
                    /* if */
                    printf("\tj0\tL%03d\n", lbl1 = lbl++);
                    ex_(p->opr.op[1], lcont, lbrk);
                    printf("L%03d:\n", lbl1);
                }
                break;
            case BREAK:
                if (lbrk == -1){
                  printf("%d\n", lbrk);
                  printf("%d\n", lbl);
                  reportOutOfLoop();
                }else{
                  printf("\tjmp\tL%03d\n", lbrk);
                }
                break;
            case CONTINUE:
                if (lcont == -1){
                  printf("%d\n", lbrk);
                  printf("%d\n", lbl);
                  reportOutOfLoop();
                }else{
                  printf("\tjmp\tL%03d\n", lcont);
                }
                break;

            case GETI:
                printf("\tgeti\n");
                if (p->opr.op[0]->var.offset == currenVarCount){
                    updateCurrentVarCountAndTypeTable(p->opr.op[0]->var.offset);
                    printf("\tpop\tfp[%d]\n", p->opr.op[0]->var.offset);
                }else{
                    printf("\tpop\tfp[%d]\n", p->opr.op[0]->var.offset);
                }
                #ifdef DEBUG
                printf("starting updating the varible type\n");
                #endif
                updateVarType(p->opr.op[0], typeVarInt);
                #ifdef DEBUG
                printf("finish updating the varible type\n");
                #endif
                break;
            case GETC:
                printf("\tgetc\n");
                if (p->opr.op[0]->var.offset == currenVarCount){
                    updateCurrentVarCountAndTypeTable(p->opr.op[0]->var.offset);
                    printf("\tpop\tfp[%d]\n", p->opr.op[0]->var.offset);
                }else{
                    printf("\tpop\tfp[%d]\n", p->opr.op[0]->var.offset);
                }
                #ifdef DEBUG
                printf("starting updating the varible type\n");
                #endif
                updateVarType(p->opr.op[0], typeVarChar);
                #ifdef DEBUG
                printf("finish updating the varible type\n");
                #endif
                break;
            case GETS:
                printf("\tgets\n");
                if (p->opr.op[0]->var.offset == currenVarCount){
                    updateCurrentVarCountAndTypeTable(p->opr.op[0]->var.offset);
                    printf("\tpop\tfp[%d]\n", p->opr.op[0]->var.offset);
                }else{
                    printf("\tpop\tfp[%d]\n", p->opr.op[0]->var.offset);
                }
                #ifdef DEBUG
                printf("starting updating the varible type\n");
                #endif
                updateVarType(p->opr.op[0], typeVarStr);
                #ifdef DEBUG
                printf("finish updating the varible type\n");
                #endif
                break;
            case PUTI:
                #ifdef DEBUG
                    printf("check the node we want PUTI\n");
                    checkNode(p->opr.op[0]);
                #endif
                // check for varible type or constant type
                checkUndefiedAndMatching(p->opr.op[0], typeConInt);
                ex_(p->opr.op[0], lcont, lbrk);
                printf("\tputi\n");
                break;
            case PUTI_:
                #ifdef DEBUG
                    printf("check the node we want PUTI_\n");
                    checkNode(p->opr.op[0]);
                #endif
                // check for varible type or constant type
                checkUndefiedAndMatching(p->opr.op[0], typeConInt);
                ex_(p->opr.op[0], lcont, lbrk);
                printf("\tputi_\n");
                break;
            case PUTC:
                // check for varible type or constant type
                checkUndefiedAndMatching(p->opr.op[0], typeConChar);
                ex_(p->opr.op[0], lcont, lbrk);
                printf("\tputc\n");
                break;
            case PUTC_:
                // check for varible type or constant type
                checkUndefiedAndMatching(p->opr.op[0], typeConChar);
                ex_(p->opr.op[0], lcont, lbrk);
                printf("\tputc_\n");
                break;
            case PUTS:
                #ifdef DEBUG
                    printf("check the node we want PUTS\n");
                    checkNode(p->opr.op[0]);
                #endif
                // check for varible type or constant type
                checkUndefiedAndMatching(p->opr.op[0], typeConStr);
                #ifdef DEBUG
                printf("after checking\n");
                #endif
                ex_(p->opr.op[0], lcont, lbrk);
                printf("\tputs\n");
                break;
            case PUTS_:
                #ifdef DEBUG
                    printf("check the node we want PUTS_\n");
                    checkNode(p->opr.op[0]);
                #endif
                // check for varible type or constant type
                checkUndefiedAndMatching(p->opr.op[0], typeConStr);
                ex_(p->opr.op[0], lcont, lbrk);
                printf("\tputs_\n");
                break;

            case '=':       
                // here cannot be a break or continue statement
                ex_(p->opr.op[1], lcont, lbrk);
                if (p->opr.op[0]->var.offset == currenVarCount){
                    updateCurrentVarCountAndTypeTable(p->opr.op[0]->var.offset);
                    printf("\tpop\tfp[%d]\n", p->opr.op[0]->var.offset);
                    #ifdef DEBUG
                    printf("find a new varible\n");
                    #endif
                }else{
                    printf("\tpop\tfp[%d]\n", p->opr.op[0]->var.offset);
                }
                #ifdef DEBUG
                printf("starting updating the varible type\n");
                #endif
                updateVarType(p->opr.op[0], getType(p->opr.op[1])+4);
                #ifdef DEBUG
                printf("finish updating the varible type\n");
                #endif
                break;
            case UMINUS:    
                // here cannot be a break or continue statement
                ex_(p->opr.op[0], lcont, lbrk);
                printf("\tneg\n");
                break;
            default:
                // here cannot be a break or continue statement
                ex_(p->opr.op[0], lcont, lbrk);
                ex_(p->opr.op[1], lcont, lbrk);
                switch(p->opr.oper) {
                    case '+':   printf("\tadd\n"); break;
                    case '-':   printf("\tsub\n"); break; 
                    case '*':   printf("\tmul\n"); break;
                    case '/':   printf("\tdiv\n"); break;
                    case '%':   printf("\tmod\n"); break;
                    case '<':   printf("\tcompLT\n"); break;
                    case '>':   printf("\tcompGT\n"); break;
                    case GE:    printf("\tcompGE\n"); break;
                    case LE:    printf("\tcompLE\n"); break;
                    case NE:    printf("\tcompNE\n"); break;
                    case EQ:    printf("\tcompEQ\n"); break;
                    case AND:   printf("\tand\n"); break;
                    case OR:    printf("\tor\n"); break;
                }
        }
    }
    return 0;
}
