// this is code collection for function



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