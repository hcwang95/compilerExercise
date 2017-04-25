// this is code collection for function
#include <stdbool.h>


int size(tableNode* root){
    if (root == NULL){
        return 0;
    }
    else{
        return size(root->leftNode) + size(root->rightNode) + 1;
    }
}


// function of counting parameter for a function call
int countParam(nodeType * p){
    if (p == NULL){
        return 0;
    }else if(p->type != typeOpr){
        return 1;
    }else{
        // case of oprator = ','
        return countParam(p->opr.op[0]) + countParam(p->opr.op[1]);
    }
}

int findLabel(char* funcName, int paramCnt, functionNode* root){
    if (root == NULL){
        return -1;
    }else{
        int flag = strcmp(root->funcName, funcName);
        if (flag == 0 && root->paramCount == paramCnt){
            return root->label;
        }else{
            return (flag<0)?findLabel(funcName, paramCnt, root->leftNode):
                            findLabel(funcName, paramCnt, root->rightNode);
        }
    }
}

void updateFuncTable(char* funcName, int label, int paramCnt, functionNode** root){
    if (*root == NULL){
        functionNode * newOne = (functionNode*)malloc(sizeof(functionNode));
        strcpy(newOne->funcName, funcName);
        newOne->label = label;
        newOne->paramCount = paramCnt;
        newOne->leftNode = NULL;
        newOne->rightNode = NULL;
        *root = newOne;
    }else{
        int flag = strcmp((*root)->funcName, funcName);
        (flag<0)?updateFuncTable(funcName, label, paramCnt, &((*root)->leftNode)):
                 updateFuncTable(funcName, label, paramCnt, &((*root)->rightNode));
    }
}
void localMemAlloc(int size){
    printf("\tpush\tsp\n");
    printf("\tpush\t%d\n", size);
    printf("\tadd\n");
    printf("\tpop\tsp\n");
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

void construct(char* varName, int offset, tableNode** root){
    if (*root == NULL){
        tableNode * newOne = (tableNode*)malloc(sizeof(tableNode));
        strcpy(newOne->varName, varName);
        newOne->varType = typeVar;
        newOne->lineNo = -1;
        newOne->offset = offset;
        newOne->leftNode = NULL;
        newOne->rightNode = NULL;
        *root = newOne;
    }else{
        int flag = strcmp((*root)->varName, varName);
        if(flag < 0){
            construct(varName, offset, &((*root)->leftNode));
        }else{
            construct(varName, offset, &((*root)->rightNode));
        }
    }
}



// if param isParam is true, then traverse
// right node first
void traverse(nodeType* p, bool isParam){

    if(isParam){
        // for parameter
        if(p->type >= typeVar && p->type <= typeVarStr){
            construct(p->var.varName, -4-funcVarCount++, &funcVarTable);
        }
        else if(p->type == typeOpr){
            traverse(p->opr.op[1], isParam);
            traverse(p->opr.op[0], isParam);
        }

    }else{
        // for normal statements
        if(p->type >= typeVar && p->type <= typeVarStr){
            int offset = getOffsetFromTable(p->var.varName, funcVarTable);
            if (offset == -1){
                construct(p->var.varName, funcVarCount++, &funcVarTable);
            }
        }else if(p->type == typeOpr){
            int i;
            for(i = 0; i < p->opr.nops; ++i){
                traverse(p->opr.op[i], isParam);
            }
        }
    }
}

// using static varible funcVarTable to construct variable tree
// for function inner variables
void constructVarTable(nodeType* p){
    // first construct for parameters

    traverse(p->opr.op[1], true);
    funcVarCount = 0;
    traverse(p->opr.op[2], false);
}