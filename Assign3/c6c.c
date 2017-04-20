#include <stdio.h>
#include "calc6.h"
#include "y.tab.h"

static int lbl;
static int currenVarCount;

// #define DEBUG
// #define CHECK


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
    }else if(p->type == typeVar){
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
#endif
void reportOutOfLoop(){
    printf("break or continue statement not within loop\n");
    // exit(0);
}

void reportInvalid(){
    printf("invalid break or continue statement\n");
    // exit(0);
}

void reportUndefined(){
    printf("undefined varible\n");
    // exit(0);
}

void reportMisMatched(){
    printf("the type of argument does not match the function used\n");
    // exit(0);
}


void checkDefined(nodeType *p){
    if (p->var.offset >= currenVarCount){
        reportUndefined();
    }
}

void checkUndefiedAndMatching(nodeType *p, int typeCon){
    if (p->type == typeVar){
        #ifdef DEBUG
        printf("find the type of varible\n");
        #endif
        checkDefined(p);
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
int ex_(nodeType *p, int lcont, int lbrk);
int ex(nodeType *p){
    ex_(p,-1,-1);
    // printf("\tend\n");
}

int ex_(nodeType *p, int lcont, int lbrk) {
    int lblx, lbly, lblz, lbl1, lbl2, itr, index, type;
    if (!p) return 0;
    switch(p->type) {
      case typeConInt:       
          printf("\tpush\t%d\n", p->con.value);
          break;
      case typeConChar:
          printf("\tpush\t\'%s\'\n", p->con.str);
          break;
      case typeConStr:
          printf("\tpush\t\"%s\"\n", p->con.str);
          break;
      case typeVar:        
          printf("\tpush\tfp[%d]\n", p->var.offset);
          break;
      case typeOpr:
          switch(p->opr.oper) {
            case FOR: 
                // check statement without break and continue
                for (itr=0; itr<3; ++itr){
                    if (p->opr.op[itr]->opr.oper == BREAK ||
                        p->opr.op[itr]->opr.oper == CONTINUE){
                        reportInvalid();
                    }
                }
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
            case REF:
                // ex_(p->opr.op[1], lcont, lbrk);
                // printf("\tpush\t%d\n", p->opr.op[0]->id.i);
                // printf("\tadd\n");
                // printf("\tpushi\ta\n");
                break;
            case READ:
                // printf("\tread\n");
                // if (p->opr.op[0]->type == typeOpr){
                //     ex_(p->opr.op[0]->opr.op[1], lcont, lbrk);
                //     printf("\tpush\t%d\n", p->opr.op[0]->opr.op[0]->id.i);
                //     printf("\tadd\n");
                //     printf("\tpopi\ta\n");
                // }else{
                //     printf("\tpop\t%c\n", p->opr.op[0]->id.i + 'a');
                // }
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
                    currenVarCount++;
                }else{
                    printf("\tpop\tfp[%d]\n", p->opr.op[0]->var.offset);
                }
                // previous implementation

                // // check if the it's index
                // if (p->opr.op[0]->type == typeOpr){
                //     ex_(p->opr.op[0]->opr.op[1], lcont, lbrk);
                //     printf("\tpush\t%d\n", p->opr.op[0]->opr.op[0]->id.i);
                //     printf("\tadd\n");
                //     printf("\tpopi\ta\n");
                // }else{
                //     printf("\tpop\t%c\n", p->opr.op[0]->id.i + 'a');
                // }

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
