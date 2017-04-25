// this is code collection for node check


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