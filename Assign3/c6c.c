#include <stdio.h>
#include "calc6.h"
#include "y.tab.h"


// #ifndef CHECK
// #define CHECK
// #endif

// #ifndef DEBUG
// #define DEBUG
// #endif



static int lbl;
static int currenVarCount;
tableNode* typeTable;
tableNode* funcVarTable;
functionNode * functionTable;
extern functionDefNode* funcDefList;
extern tableNode* Table;
static int funcVarCount = 0;

#include "errorReport.c"
#include "nodeCheck.c"
#include "function.c"
#include "variableType.c"




int ex_(nodeType *p, int lcont, int lbrk, bool isMain);

// define all functions that are mentioned by the user
void defineFunc(){
    #ifdef DEBUG
        printf("enter final definition for functions\n");
    #endif
    functionDefNode* temp;
    temp = funcDefList;
    while(temp!=NULL){
        int paraCnt = countParam(temp->p->opr.op[1]);
        #ifdef DEBUG
            printf("execute for function:%s, with %d argument(s)\n", \
                    temp->p->opr.op[0]->var.varName, paraCnt);
        #endif
        ex_(temp->p, -1, -1, false);
        free(temp);
        temp = temp -> next;
    }


}


int ex(nodeType *p){
    int totalVarCount = size(Table);
    #ifdef DEBUG
    fprintf(stderr, "total varible size : %d\n", totalVarCount);
    #endif
    localMemAlloc(totalVarCount);
    ex_(p,-1,-1, true);
    printf("\tend\n");
}

int ex_(nodeType *p, int lcont, int lbrk, bool isMain) {
    int lblx, lbly, lblz, lbl1, lbl2, itr, index, type,\
        paraCnt, label;
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
          if (isMain){
              printf("\tpush\tfp[%d]\n", p->var.offset);
          }else{
              int offset = getOffsetFromTable(p->var.varName, funcVarTable);
              printf("\tpush\tfp[%d]\n", offset); 
          }  
          return 0;
      case typeOpr:
          switch(p->opr.oper) {
            case FUNC:
                if (ex_(p->opr.op[0], lcont, lbrk, isMain)) return 1;
                if (ex_(p->opr.op[1], lcont, lbrk, isMain)) return 1;
                return 0;
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
                if (ex_(p->opr.op[0], lcont, lbrk, isMain)) return 1;
                printf("L%03d:\n", lblx = lbl++);
                if (ex_(p->opr.op[1], lcont, lbrk, isMain)) return 1;
                printf("\tj0\tL%03d\n", lbly = lbl++);
                if (ex_(p->opr.op[3], lblz = lbl++, lbly, isMain)) return 1;;
                printf("\tjmp\tL%03d\n", lblz);
                printf("L%03d:\n", lblz);
                if (ex_(p->opr.op[2], lcont, lbrk, isMain)) return 1;
                printf("\tjmp\tL%03d\n", lblx);
                printf("L%03d:\n", lbly);
                return 0;
            case WHILE:
                // check statement without break and continue
                if (p->opr.op[0]->type == typeOpr){
                  if (p->opr.op[0]->opr.oper == BREAK ||
                      p->opr.op[0]->opr.oper == CONTINUE){
                      reportInvalid();
                  }
                }
                printf("L%03d:\n", lbl1 = lbl++);
                if (ex_(p->opr.op[0], lcont, lbrk, isMain)) return 1;
                printf("\tj0\tL%03d\n", lbl2 = lbl++);
                if (ex_(p->opr.op[1], lbl1, lbl2, isMain)) return 1;
                printf("\tjmp\tL%03d\n", lbl1);
                printf("L%03d:\n", lbl2);
                return 0;
            case IF:
                // check statement without break and continue
                if (p->opr.op[0]->type == typeOpr){
                  if (p->opr.op[0]->opr.oper == BREAK ||
                      p->opr.op[0]->opr.oper == CONTINUE){
                      reportInvalid();
                  }
                }
                if (ex_(p->opr.op[0], lcont, lbrk, isMain)) return 1;
                if (p->opr.nops > 2) {
                    /* if else */
                    printf("\tj0\tL%03d\n", lbl1 = lbl++);
                    #ifdef DEBUG
                        printf("positive part\n");
                    #endif
                    if (ex_(p->opr.op[1], lcont, lbrk, isMain)) return 1;
                    #ifdef DEBUG
                        printf("jump to negative part\n");
                    #endif
                    printf("\tjmp\tL%03d\n", lbl2 = lbl++);
                    printf("L%03d:\n", lbl1);
                    if (ex_(p->opr.op[2], lcont, lbrk, isMain)) return 1;
                    printf("L%03d:\n", lbl2);
                } else {
                    /* if */
                    printf("\tj0\tL%03d\n", lbl1 = lbl++);
                    if (ex_(p->opr.op[1], lcont, lbrk, isMain)) return 1;
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
                return 0;
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
                return 0;
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
                return 0;
            case PUTI:
                #ifdef DEBUG
                    printf("check the node we want PUTI\n");
                    checkNode(p->opr.op[0]);
                #endif
                // check for varible type or constant type
                checkUndefiedAndMatching(p->opr.op[0], typeConInt, isMain);
                if (ex_(p->opr.op[0], lcont, lbrk, isMain)) return 1;
                printf("\tputi\n");
                return 0;
            case PUTI_:
                #ifdef DEBUG
                    printf("check the node we want PUTI_\n");
                    checkNode(p->opr.op[0]);
                #endif
                // check for varible type or constant type
                checkUndefiedAndMatching(p->opr.op[0], typeConInt, isMain);
                if (ex_(p->opr.op[0], lcont, lbrk, isMain)) return 1;
                printf("\tputi_\n");
                return 0;
            case PUTC:
                // check for varible type or constant type
                checkUndefiedAndMatching(p->opr.op[0], typeConChar, isMain);
                if (ex_(p->opr.op[0], lcont, lbrk, isMain)) return 1;
                printf("\tputc\n");
                return 0;
            case PUTC_:
                // check for varible type or constant type
                checkUndefiedAndMatching(p->opr.op[0], typeConChar, isMain);
                if (ex_(p->opr.op[0], lcont, lbrk, isMain)) return 1;
                printf("\tputc_\n");
                return 0;
            case PUTS:
                #ifdef DEBUG
                    printf("check the node we want PUTS\n");
                    checkNode(p->opr.op[0]);
                #endif
                // check for varible type or constant type
                checkUndefiedAndMatching(p->opr.op[0], typeConStr, isMain);
                #ifdef DEBUG
                printf("after checking\n");
                #endif
                if (ex_(p->opr.op[0], lcont, lbrk, isMain)) return 1;
                printf("\tputs\n");
                return 0;
            case PUTS_:
                #ifdef DEBUG
                    printf("check the node we want PUTS_\n");
                    checkNode(p->opr.op[0]);
                #endif
                // check for varible type or constant type
                checkUndefiedAndMatching(p->opr.op[0], typeConStr, isMain);
                if (ex_(p->opr.op[0], lcont, lbrk, isMain)) return 1;
                printf("\tputs_\n");
                return 0;

            case '=':       
                // here cannot be a break or continue statement
                if (ex_(p->opr.op[1], lcont, lbrk, isMain)) return 1;
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
                updateVarType(p->opr.op[0], getRValueType(p->opr.op[1])+4);
                #ifdef DEBUG
                printf("finish updating the varible type\n");
                #endif
                return 0;
            case UMINUS:    
                // here cannot be a break or continue statement
                if (ex_(p->opr.op[0], lcont, lbrk, isMain)) return 1;
                printf("\tneg\n");
                return 0;
            // for arugment pushing return the value of parameter count
            case ',':
                if (ex_(p->opr.op[0], lcont, lbrk, isMain)) return 1;
                if (ex_(p->opr.op[1], lcont, lbrk, isMain)) return 1;
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
                }else{
                    #ifdef DEBUG
                        printf("this function has been called first time\n");
                    #endif
                }
                // push all argument (expresssion)
                if (ex_(p->opr.op[1], lcont, lbrk, isMain)) return 1;
                // print call cmd
                printf("\tcall\tL%03d, %d\n", label, paraCnt);
                return 0;
            case FUNCDEF:
                // this will happen when main function has been compiled
                // and all varible offset are rearranged well.
                // check if there is usage first
                paraCnt = countParam(p->opr.op[1]);
                label = findLabel(p->opr.op[0]->var.varName, paraCnt, functionTable);
                if (label == -1){
                    // no usage give warning and discard those code snippets
                    reportFuncUnused(p->opr.op[0]->var.varName);
                    return 0;
                }else{
                    // there is at least one call
                    printf("L%03d:\n", label);

                    // construct another table for one function
                    constructVarTable(p);
                    int totalVarCount = size(funcVarTable);
                    if (totalVarCount - paraCnt > 0){
                        localMemAlloc(totalVarCount - paraCnt);
                    }
                    #ifdef DEBUG
                    checkNode(p->opr.op[2]);
                    #endif
                    if (ex_(p->opr.op[2], lcont, lbrk, isMain)) return 1;
                    // if user define function does not have return, then return 0 if all have been
                    // done. ==>Feature
                    printf("\tpush\t0\n");
                    printf("\tret\n");
                    
                    #ifdef DEBUG
                        printf("finish compiling for fucntion : %s\n", p->opr.op[0]->var.varName);
                    #endif
                }
                return 0;
            case RETURN:
                if (ex_(p->opr.op[0], lcont, lbrk, isMain)) return 1;
                printf("\tret\n");
                return 1;
            default:
                // here cannot be a break or continue statement
                if (ex_(p->opr.op[0], lcont, lbrk, isMain)) return 1;
                if (ex_(p->opr.op[1], lcont, lbrk, isMain)) return 1;
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
