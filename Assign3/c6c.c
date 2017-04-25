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
static tableNode* typeTable;
static functionNode * functionTable;
extern functionDefNode* funcDefList;
extern tableNode* Table;

#include "errorReport.c"
#include "nodeCheck.c"
#include "variableType.c"
#include "function.c"




int ex_(nodeType *p, int lcont, int lbrk);

// define all functions that are mentioned by the user
void defineFunc(){
    #ifdef DEBUG
        printf("enter final definition for functions\n");
    #endif
    functionDefNode* temp;
    temp = funcDefList;
    while(temp!=NULL){
        int paraCnt = countParam(temp->p->opr.op[1]);
        int label = findLabel(temp->p->opr.op[0]->var.funcName, paraCnt, functionTable);
        #ifdef DEBUG
            printf("execute for function:%s, with %d argument(s)\n", \
                    temp->p->opr.op[0]->var.funcName, paraCnt);
        #endif
        ex_(temp->p, -1, -1);
    }
}


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
    int lblx, lbly, lblz, lbl1, lbl2, itr, index, type,\
        paraCnt, label;
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
                updateVarType(p->opr.op[0], getRValueType(p->opr.op[1])+4);
                #ifdef DEBUG
                printf("finish updating the varible type\n");
                #endif
                break;
            case UMINUS:    
                // here cannot be a break or continue statement
                ex_(p->opr.op[0], lcont, lbrk);
                printf("\tneg\n");
                break;
            // for arugment pushing return the value of parameter count
            case ',':
                ex_(p->opr.op[0], lcont, lbrk);
                ex_(p->opr.op[1], lcont, lbrk);
                break;
            // for function
            case FUNCCALL:
                #ifdef DEBUG
                    printf("find a function call node\n");
                #endif
                // find the arugment use first
                paraCnt = countParam(p->opr.op[1]);

                // try to get the function
                label = findLabel(p->opr.op[0]->var.funcName, paraCnt, functionTable);
                if (label == -1){
                    // set for new
                    label = lbl++;
                    // if first call, update for the table by creating node
                    updateFuncTable(p->opr.op[0]->var.funcName, label, paraCnt, &functionTable);
                }else{
                    #ifdef DEBUG
                        printf("this function has been called first time\n");
                    #endif
                }
                // push all argument (expresssion)
                ex_(p->opr.op[1], lcont, lbrk);
                // print call cmd
                printf("\tcall\tL%03d, %d\n", label, paraCnt);

                break;
            case FUNCDEF:
                // this will happen when main function has been compiled
                // and all varible offset are rearranged well.
                // check if there is usage first
                paraCnt = countParam(p->opr.op[1]);
                label = findLabel(p->opr.op[0]->var.funcName, paraCnt, functionTable);
                if (label == -1){
                    // no usage give warning and discard those code snippets
                    reportUnused(p->opr.op[0]->var.funcName);
                    return 0;
                }else{
                    // there is at least one call
                    printf("L%03d\n", label);
                    ex_(p->opr.op[2], lcont, lbrk);
                    #ifdef DEBUG
                        printf("finish compiling for fucntion : %s\n", p->opr.op[0]->var.funcName);
                    #endif
                }
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
