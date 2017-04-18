#include <stdio.h>
#include "calc6.h"
#include "y.tab.h"

static int lbl;

#define INTEGER 1
#define CHARACTER 2
#define STRING 3

void reportOutOfLoop(){
    printf("break or continue statement not within loop\n");
    exit(0);
}

void reportInvalid(){
    printf("invalid break or continue statement\n");
    exit(0);
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
          printf("\tpush\t\'%c\'\n", (char)p->con.value);
          break;
      case typeConStr:
          printf("\tpush\t\"%s\"\n", p->con.str);
          break;
      case typeId:        
          printf("\tpush\t%c\n", p->id.i + 'a'); 
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
                    ex_(p->opr.op[1], lcont, lbrk);
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
                ex_(p->opr.op[1], lcont, lbrk);
                printf("\tpush\t%d\n", p->opr.op[0]->id.i);
                printf("\tadd\n");
                printf("\tpushi\ta\n");
                break;
            case READ:
                printf("\tread\n");
                if (p->opr.op[0]->type == typeOpr){
                    ex_(p->opr.op[0]->opr.op[1], lcont, lbrk);
                    printf("\tpush\t%d\n", p->opr.op[0]->opr.op[0]->id.i);
                    printf("\tadd\n");
                    printf("\tpopi\ta\n");
                }else{
                    printf("\tpop\t%c\n", p->opr.op[0]->id.i + 'a');
                }
                break;
            // case PRINT:     
            //     // here cannot be a break or continue statement
            //     type = ex_(p->opr.op[0], lcont, lbrk);
            //     if (type == INTEGER){
            //         printf("\tputi\n");
            //     }else if(type == CHARACTER){
            //         printf("\tputc\n");
            //     }else{
            //         printf("\tputs\n");
            //     }
            //     break;
            case PUTI:
                ex_(p->opr.op[0], lcont, lbrk);
                printf("\tputi\n");
                break;
            case PUTI_:
                ex_(p->opr.op[0], lcont, lbrk);
                printf("\tputi_\n");
                break;
            case PUTC:
                ex_(p->opr.op[0], lcont, lbrk);
                printf("\tputc\n");
                break;
            case PUTC_:
                ex_(p->opr.op[0], lcont, lbrk);
                printf("\tputc_\n");
                break;
            case PUTS:
                ex_(p->opr.op[0], lcont, lbrk);
                printf("\tputs\n");
                break;
            case PUTS_:
                ex_(p->opr.op[0], lcont, lbrk);
                printf("\tputs_\n");
                break;

            case '=':       
                // here cannot be a break or continue statement
                ex_(p->opr.op[1], lcont, lbrk);
                // get and check the name is in the current table
                if (inTable())

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
