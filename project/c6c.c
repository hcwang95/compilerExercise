#include <stdio.h>
#include "calc6.h"
#include "y.tab.h"


// #ifndef CHECK
// #define CHECK
// #endif

// #ifndef DEBUG
// #define DEBUG
// #endif


static int funcVarCount = 0;
static int lbl;
static int currenVarCount;

extern tableNode* Table;
tableNode* typeTable;
tableNode* mainVarTable;
tableNode* funcVarTable;

functionNode * functionTable;
extern functionDefNode* funcReDefList;
extern functionDefNode* funcDefList;

#include "errorReport.c"
#include "nodeCheck.c"
#include "function.c"
#include "variableType.c"



int ex_(nodeType *p, int lcont, int lbrk, int funcType);

// define all functions that are mentioned by the user
void defineFunc(){
    #ifdef DEBUG
        printf("enter final definition for functions\n");
    #endif
    functionDefNode* temp;
    functionDefNode* freePtr;
    temp = funcDefList;

    while(temp){
        int paraCnt = countParam(temp->p->opr.op[1]);
        #ifdef DEBUG
            printf("execute for function:%s, with %d argument(s)\n", \
                    temp->p->opr.op[0]->var.varName, paraCnt);
        #endif
        ex_(temp->p, -1, -1, 0);
        freePtr = temp;
        temp = temp -> next;
        free(freePtr);
    }
    funcDefList = NULL;
    // handle no declare but first use in a function definition
    temp = funcReDefList;

    while(temp){
        int paraCnt = countParam(temp->p->opr.op[1]);
        // #ifdef DEBUG
        //     printf("execute for function:%s, with %d argument(s)\n", \
        //             temp->p->opr.op[0]->var.varName, paraCnt);
        // #endif
        ex_(temp->p, -1, -1, funcReDef);
        freePtr = temp;
        temp = temp -> next;
        free(freePtr);
    }
}



void checkUndefinedFunc(){
    int flag = checkFuncFromTable(functionTable);
    #ifdef DEBUG
        printf("flag : %d\n", flag);
    #endif
    if (flag){
        exit(funcUndefined);
    }
}


int ex(nodeType *p){
    if (!p){
        return 0;
    }
    // construct the main function variable table
    // also get other global variable init from
    // other function defined by user
    constructFuncVarTable(p,funcMain);
    checkGlobalVarDef(size(mainVarTable));
    int totalVarCount = size(mainVarTable);
    #ifdef DEBUG
    fprintf(stderr, "total varible size : %d\n", totalVarCount);
    #endif
    if(totalVarCount){
        localMemAlloc(totalVarCount);
    }
    ex_(p,-1,-1, funcMain);
    printf("\tend\n");
    return 0;
}

int ex_(nodeType *p, int lcont, int lbrk, int funcType) {
    int lblx, lbly, lblz, lbl1, lbl2, itr, index, type,\
        paraCnt, label, offset;
    if (!p) return 0;
    switch(p->type) {
      case typeConInt:       
          #ifdef DEBUG
            printf("find the constant int %d\n", p->con.value);
          #endif
          printf("\tpush\t%d\n", p->con.value);
          return 0;
      case typeConChar:
          printf("\tpush\t%s\n", p->con.str);
          return 0;
      case typeConStr:
          printf("\tpush\t\"%s\"\n", p->con.str);
          return 0;
      case typeVar:   
          if (funcType == funcMain){
              offset = getOffsetFromTable(p->var.varName, mainVarTable);
          }else{
              offset = getOffsetFromTable(p->var.varName, funcVarTable);
          }  
          printf("\tpush\tfp[%d]\n", offset); 
          return 0;
      case typeGlobalVar:
          offset = getOffsetFromTable(p->var.varName, mainVarTable);
          printf("\tpush\tsb[%d]\n", offset); 
          return 0;
      case typeOpr:
          switch(p->opr.oper) {
            case FUNC:
                if (ex_(p->opr.op[0], lcont, lbrk, funcType)) return 1;
                if (ex_(p->opr.op[1], lcont, lbrk, funcType)) return 1;
                return 0;
            case FOR: 
                // check statement without break and continue
                for (itr=0; itr<3; ++itr){
                    if (p->opr.op[itr]->opr.oper == BREAK ||
                        p->opr.op[itr]->opr.oper == CONTINUE){
                        reportInvalidBrkCon();
                    }
                }
                #ifdef DEBUG
                checkNode(p);
                #endif
                // allow for(return ***; return ***; return ***;){ ... }
                if (ex_(p->opr.op[0], lcont, lbrk, funcType)) return 1;
                printf("L%03d:\n", lblx = lbl++);
                if (ex_(p->opr.op[1], lcont, lbrk, funcType)) return 1;
                printf("\tj0\tL%03d\n", lbly = lbl++);
                // for loop is a special case for return
                ex_(p->opr.op[3], lblz = lbl++, lbly, funcType);
                printf("\tjmp\tL%03d\n", lblz);
                printf("L%03d:\n", lblz);
                if (ex_(p->opr.op[2], lcont, lbrk, funcType)) return 1;
                printf("\tjmp\tL%03d\n", lblx);
                printf("L%03d:\n", lbly);
                return 0;
            case WHILE:
                // check statement without break and continue
                if (p->opr.op[0]->type == typeOpr){
                  if (p->opr.op[0]->opr.oper == BREAK ||
                      p->opr.op[0]->opr.oper == CONTINUE){
                      reportInvalidBrkCon();
                  }
                }
                printf("L%03d:\n", lbl1 = lbl++);
                // allow while(return ***)
                if (ex_(p->opr.op[0], lcont, lbrk, funcType)) return 1;
                printf("\tj0\tL%03d\n", lbl2 = lbl++);
                // while loop return is special case
                if (ex_(p->opr.op[1], lbl1, lbl2, funcType)) return 0;
                printf("\tjmp\tL%03d\n", lbl1);
                printf("L%03d:\n", lbl2);
                return 0;
            case IF:
                // check statement without break and continue
                if (p->opr.op[0]->type == typeOpr){
                  if (p->opr.op[0]->opr.oper == BREAK ||
                      p->opr.op[0]->opr.oper == CONTINUE){
                      reportInvalidBrkCon();
                  }
                }
                // allow if(return ***)
                if (ex_(p->opr.op[0], lcont, lbrk, funcType)) return 1;
                if (p->opr.nops > 2) {
                    int return1, return2;
                    /* if else */
                    printf("\tj0\tL%03d\n", lbl1 = lbl++);
                    #ifdef DEBUG
                        printf("positive part\n");
                    #endif
                    return1 = ex_(p->opr.op[1], lcont, lbrk, funcType);
                    #ifdef DEBUG
                        printf("jump to negative part\n");
                    #endif
                    printf("\tjmp\tL%03d\n", lbl2 = lbl++);
                    printf("L%03d:\n", lbl1);
                    return2 = ex_(p->opr.op[2], lcont, lbrk, funcType);
                    printf("L%03d:\n", lbl2);
                    if (return1 && return2){
                        return 1;
                    }
                } else {
                    /* if */
                    printf("\tj0\tL%03d\n", lbl1 = lbl++);
                    ex_(p->opr.op[1], lcont, lbrk, funcType);
                    printf("L%03d:\n", lbl1);
                }
                return 0;
            case BREAK:
                if (lbrk == -1){
                  printf("%d\n", lbrk);
                  printf("%d\n", lbl);
                  reportOutOfLoop();
                }else{
                  printf("\tjmp\tL%03d\n", lbrk);
                }
                return 0;
            case CONTINUE:
                if (lcont == -1){
                  printf("%d\n", lbrk);
                  printf("%d\n", lbl);
                  reportOutOfLoop();
                }else{
                  printf("\tjmp\tL%03d\n", lcont);
                }
                return 0;
            case GETI:
                printf("\tgeti\n");
                if(funcType == funcMain){
                    offset = getOffsetFromTable(p->opr.op[0]->var.varName, mainVarTable);
                    if (offset == currenVarCount){
                        updateCurrentVarCountAndTypeTable(p->opr.op[0]->var.varName);
                    }
                    printf("\tpop\tfp[%d]\n", offset);
                    #ifdef DEBUG
                    printf("starting updating the varible type\n");
                    #endif
                    updateVarType(p->opr.op[0], typeVarInt);
                    #ifdef DEBUG
                    printf("finish updating the varible type\n");
                    #endif
                }else{
                    if(p->opr.op[0]->type == typeGlobalVar){
                        offset = getOffsetFromTable(p->opr.op[0]->var.varName, mainVarTable);
                        printf("\tpop\tsb[%d]\n", offset);
                    }else{
                        offset = getOffsetFromTable(p->opr.op[0]->var.varName, funcVarTable);
                        printf("\tpop\tfp[%d]\n", offset); 
                    }
                }
                return 0;
            case GETC:
                printf("\tgetc\n");
                if(funcType == funcMain){
                    offset = getOffsetFromTable(p->opr.op[0]->var.varName, mainVarTable);
                    if (offset == currenVarCount){
                        updateCurrentVarCountAndTypeTable(p->opr.op[0]->var.varName);
                    }
                    printf("\tpop\tfp[%d]\n", offset);
                    #ifdef DEBUG
                    printf("starting updating the varible type\n");
                    #endif
                    updateVarType(p->opr.op[0], typeVarChar);
                    #ifdef DEBUG
                    printf("finish updating the varible type\n");
                    #endif
                }else{
                    if(p->opr.op[0]->type == typeGlobalVar){
                        offset = getOffsetFromTable(p->opr.op[0]->var.varName, mainVarTable);
                        printf("\tpop\tsb[%d]\n", offset);
                    }else{
                        offset = getOffsetFromTable(p->opr.op[0]->var.varName, funcVarTable);
                        printf("\tpop\tfp[%d]\n", offset); 
                    }
                }
                return 0;
            case GETS:
                printf("\tgets\n");
                if(funcType == funcMain){
                    offset = getOffsetFromTable(p->opr.op[0]->var.varName, mainVarTable);
                    if (offset == currenVarCount){
                        updateCurrentVarCountAndTypeTable(p->opr.op[0]->var.varName);
                    }
                    printf("\tpop\tfp[%d]\n", offset);
                    #ifdef DEBUG
                    printf("starting updating the varible type\n");
                    #endif
                    updateVarType(p->opr.op[0], typeVarStr);
                    #ifdef DEBUG
                    printf("finish updating the varible type\n");
                    #endif
                }else{
                    if(p->opr.op[0]->type == typeGlobalVar){
                        offset = getOffsetFromTable(p->opr.op[0]->var.varName, mainVarTable);
                        printf("\tpop\tsb[%d]\n", offset);
                    }else{
                        offset = getOffsetFromTable(p->opr.op[0]->var.varName, funcVarTable);
                        printf("\tpop\tfp[%d]\n", offset); 
                    }
                }
                return 0;
            case PUTI:
                #ifdef DEBUG
                    printf("check the node we want PUTI\n");
                    checkNode(p->opr.op[0]);
                #endif
                // check for varible type or constant type
                if(funcType == funcMain){
                    checkUndefiedAndMatching(p->opr.op[0], typeConInt, funcType);
                }
                if (ex_(p->opr.op[0], lcont, lbrk, funcType)) return 1;
                printf("\tputi\n");
                return 0;
            case PUTI_:
                #ifdef DEBUG
                    printf("check the node we want PUTI_\n");
                    checkNode(p->opr.op[0]);
                #endif
                // check for varible type or constant type
                if(funcType == funcMain){
                    checkUndefiedAndMatching(p->opr.op[0], typeConInt, funcType);
                }
                if (ex_(p->opr.op[0], lcont, lbrk, funcType)) return 1;
                printf("\tputi_\n");
                return 0;
            case PUTC:
                // check for varible type or constant type
                if(funcType == funcMain){
                    checkUndefiedAndMatching(p->opr.op[0], typeConChar, funcType);
                }
                if (ex_(p->opr.op[0], lcont, lbrk, funcType)) return 1;
                printf("\tputc\n");
                return 0;
            case PUTC_:
                // check for varible type or constant type
                if(funcType == funcMain){
                    checkUndefiedAndMatching(p->opr.op[0], typeConChar, funcType);
                }
                if (ex_(p->opr.op[0], lcont, lbrk, funcType)) return 1;
                printf("\tputc_\n");
                return 0;
            case PUTS:
                #ifdef DEBUG
                    printf("check the node we want PUTS\n");
                    checkNode(p->opr.op[0]);
                #endif
                // check for varible type or constant type
                if(funcType == funcMain){
                    checkUndefiedAndMatching(p->opr.op[0], typeConStr, funcType);
                }
                #ifdef DEBUG
                printf("after checking\n");
                #endif
                if (ex_(p->opr.op[0], lcont, lbrk, funcType)) return 1;
                printf("\tputs\n");
                return 0;
            case PUTS_:
                #ifdef DEBUG
                    printf("check the node we want PUTS_\n");
                    checkNode(p->opr.op[0]);
                #endif
                // check for varible type or constant type
                if(funcType == funcMain){
                    checkUndefiedAndMatching(p->opr.op[0], typeConStr, funcType);
                }
                if (ex_(p->opr.op[0], lcont, lbrk, funcType)) return 1;
                printf("\tputs_\n");
                return 0;

            case '=':       
                // here cannot be a break or continue statement
                if (ex_(p->opr.op[1], lcont, lbrk, funcType)) return 1;
                if (funcType == funcMain){
                    offset = getOffsetFromTable(p->opr.op[0]->var.varName, mainVarTable);
                    if (offset == currenVarCount){
                        updateCurrentVarCountAndTypeTable(p->opr.op[0]->var.varName);
                        #ifdef DEBUG
                            printf("find a new varible\n");
                        #endif
                    }
                    printf("\tpop\tfp[%d]\n", offset);
                    #ifdef DEBUG
                    printf("starting updating the varible type\n");
                    #endif
                    int type_ = getRValueType(p->opr.op[1]);
                    if (type_ != typeUnknown){
                        updateVarType(p->opr.op[0], type_+4);
                    }else{
                        updateVarType(p->opr.op[0], typeUnknown);
                    }
                    #ifdef DEBUG
                    printf("finish updating the varible type\n");
                    #endif
                }else{
                    if(p->opr.op[0]->type == typeGlobalVar){
                        offset = getOffsetFromTable(p->opr.op[0]->var.varName, mainVarTable);
                        printf("\tpop\tsb[%d]\n", offset);
                    }else{
                        offset = getOffsetFromTable(p->opr.op[0]->var.varName, funcVarTable);
                        printf("\tpop\tfp[%d]\n", offset); 
                    }
                }
                
                return 0;
            case UMINUS:    
                // here cannot be a break or continue statement
                if (ex_(p->opr.op[0], lcont, lbrk, funcType)) return 1;
                printf("\tneg\n");
                return 0;
            // for arugment pushing return the value of parameter count
            case ',':
                if (ex_(p->opr.op[0], lcont, lbrk, funcType)) return 1;
                if (ex_(p->opr.op[1], lcont, lbrk, funcType)) return 1;
                return 0;
            // for function
            case FUNCCALL:
                #ifdef DEBUG
                    printf("find a function call node\n");
                #endif
                // find the arugment use first
                paraCnt = countParam(p->opr.op[1]);

                // try to get the function
                label = findLabel(p->opr.op[0]->var.varName, paraCnt, functionTable);
                if (label == -1){
                    // set for new
                    label = lbl++;
                    // if first call, update for the table by creating node
                    updateFuncTable(p->opr.op[0]->var.varName, label, paraCnt, &functionTable);
                    #ifdef DEBUG
                        printf("this function %s has been called first time\n", p->opr.op[0]->var.varName);
                    #endif
                }else{
                    #ifdef DEBUG
                        printf("this function has been called first time\n");
                    #endif
                }
                // push all argument (expresssion)
                if (ex_(p->opr.op[1], lcont, lbrk, funcType)) return 1;
                // print call cmd
                printf("\tcall\tL%03d, %d\n", label, paraCnt);
                return 0;
            case FUNCDEF:
                // this will happen when main function has been compiled
                // and all varible offset are rearranged well.
                // check if there is clash with other variable
                if (hasConflict(p->opr.op[0]->var.varName)){
                    reportFuncVarClash(p->opr.op[0]->var.varName);
                }
                // check if there is usage then.
                paraCnt = countParam(p->opr.op[1]);
                label = findLabel(p->opr.op[0]->var.varName, paraCnt, functionTable);
                if (label == -1 ){
                    if (funcType == funcReDef){
                        // no usage give warning and discard those code snippets
                        reportFuncUnused(p->opr.op[0]->var.varName);
                        return 0;
                    }else{
                        // traverse and extract all function call
                        // then append that one to another list to parse another time
                        recordFunctionCall(p->opr.op[2]);
                        registerFunc(p, &funcReDefList);
                    }
                    
                }else{
                    // there is at least one call
                    printf("L%03d:\n", label);

                    // construct another table for one function
                    constructFuncVarTable(p, funcType);
                    int totalVarCount = size(funcVarTable);
                    if (totalVarCount - paraCnt > 0){
                        localMemAlloc(totalVarCount - paraCnt);
                    }
                    #ifdef DEBUG
                    checkNode(p->opr.op[2]);
                    #endif
                    if (!ex_(p->opr.op[2], lcont, lbrk, funcType)) {
                        
                    // if user define function does not have return, then return 0 if all have been
                    // done. ==>Feature
                        printf("\tpush\t0\n");
                        printf("\tret\n");
                    }
                    destructFuncVarTable();
                    recordDef(p->opr.op[0]->var.varName, paraCnt,functionTable);
                    #ifdef DEBUG
                        printf("finish compiling for fucntion : %s\n", p->opr.op[0]->var.varName);
                    #endif
                }
                return 0;
            case RETURN:
                if (funcType == funcMain){
                    reportInvalidReturn();
                }
                if(!p->opr.op[0]){
                    printf("\tpush\t0\n");
                }else{
                    if (ex_(p->opr.op[0], lcont, lbrk, funcType)) return 1;
                }
                printf("\tret\n");
                return 1;
            default:
                // here cannot be a break or continue statement
                if (ex_(p->opr.op[0], lcont, lbrk, funcType)) return 1;
                if (ex_(p->opr.op[1], lcont, lbrk, funcType)) return 1;
                switch(p->opr.oper) {
                    case '+':   printf("\tadd\n"); return 0;
                    case '-':   printf("\tsub\n"); return 0;
                    case '*':   printf("\tmul\n"); return 0;
                    case '/':   printf("\tdiv\n"); return 0;
                    case '%':   printf("\tmod\n"); return 0;
                    case '<':   printf("\tcompLT\n"); return 0;
                    case '>':   printf("\tcompGT\n"); return 0;
                    case GE:    printf("\tcompGE\n"); return 0;
                    case LE:    printf("\tcompLE\n"); return 0;
                    case NE:    printf("\tcompNE\n"); return 0;
                    case EQ:    printf("\tcompEQ\n"); return 0;
                    case AND:   printf("\tand\n"); return 0;
                    case OR:    printf("\tor\n"); return 0;
                }
        }
    }
    return 0;
}
