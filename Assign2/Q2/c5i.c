#include <stdio.h>
#include "calc3.h"
#include "y.tab.h"


static int cont = 0;
static int brk = 0;
static int loop_depth = 0;

void reportOutOfLoop(){
    printf("break or continue statement not within loop\n");
    exit(0);
}

void reportInvalid(){
    printf("invalid break or continue statement\n");
    exit(0);
}

void reportOutRange(){
    printf("index out of range\n");
    exit(0);
}

int ex(nodeType *p) {
    if ((cont || brk)){
        if(loop_depth!=0){
            return 0;
        }
        else{
            reportOutOfLoop();
        }
    }
    int i;
    int itr;
    int index;
    if (!p) return 0;
    switch(p->type) {
    case typeCon:       return p->con.value;
    case typeId:        return sym[p->id.i];
    case typeOpr:
        switch(p->opr.oper) {
        	case FOR:	    for (itr=0; itr<3; ++itr){
                                if (p->opr.op[itr]->opr.oper == BREAK||
                                    p->opr.op[itr]->opr.oper == CONTINUE){
                                    reportInvalid();
                                }
                            }
                            
                            ex(p->opr.op[0]);
                            loop_depth++;
        			        while (ex(p->opr.op[1])) {
        				        ex(p->opr.op[3]);
                                if (brk){
                                    brk = 0;
                                    loop_depth--;
                                    return 0;
                                }
                                cont = 0;
        				        ex(p->opr.op[2]);
        			        }
                            loop_depth--;
        			        return 0;
            case WHILE:     if (p->opr.op[0]->type == typeOpr){
                                if (p->opr.op[0]->opr.oper == BREAK ||
                                    p->opr.op[0]->opr.oper == CONTINUE){
                                    reportInvalid();
                                }
                            }
                            loop_depth++;
                            while(ex(p->opr.op[0])){
                                ex(p->opr.op[1]); 
                                if (brk){
                                    brk = 0;
                                    loop_depth--;
                                    return 0;
                                }
                                cont = 0;
                            }
                            loop_depth--;
                            return 0;
            case IF:        if (ex(p->opr.op[0]))
                                ex(p->opr.op[1]);
                            else if (p->opr.nops > 2)
                                ex(p->opr.op[2]);
                            return 0;
            case PRINT:     printf("%d\n", ex(p->opr.op[0])); return 0;
            case READ:	    printf("? "); scanf("%d", &i);
            				if (p->opr.op[0]->type == typeOpr){
                                index = p->opr.op[0]->opr.op[0]->id.i +
                                        ex(p->opr.op[0]->opr.op[1]);
                                if(index<26 && index >=0){
                                    return sym[index] = i;
                                }else{
                                    reportOutRange();
                                }
                            }
        		            return sym[p->opr.op[0]->id.i] = i;
            case ';':       ex(p->opr.op[0]); return ex(p->opr.op[1]);
            case '=':       if (p->opr.op[0]->type == typeOpr){
                                index = p->opr.op[0]->opr.op[0]->id.i +
                                        ex(p->opr.op[0]->opr.op[1]);
                                if(index<26 && index >=0){
                                    return sym[index] = ex(p->opr.op[1]);
                                }else{
                                    reportOutRange();
                                }
                            }
                            return sym[p->opr.op[0]->id.i] = ex(p->opr.op[1]);
            case UMINUS:    return -ex(p->opr.op[0]);
            case '+':       return ex(p->opr.op[0]) + ex(p->opr.op[1]);
            case '-':       return ex(p->opr.op[0]) - ex(p->opr.op[1]);
            case '*':       return ex(p->opr.op[0]) * ex(p->opr.op[1]);
            case '/':       return ex(p->opr.op[0]) / ex(p->opr.op[1]);
            case '%':       return ex(p->opr.op[0]) % ex(p->opr.op[1]);
            case '<':       return ex(p->opr.op[0]) < ex(p->opr.op[1]);
            case '>':       return ex(p->opr.op[0]) > ex(p->opr.op[1]);
            case GE:        return ex(p->opr.op[0]) >= ex(p->opr.op[1]);
            case LE:        return ex(p->opr.op[0]) <= ex(p->opr.op[1]);
            case NE:        return ex(p->opr.op[0]) != ex(p->opr.op[1]);
            case EQ:        return ex(p->opr.op[0]) == ex(p->opr.op[1]);
            case AND:	    return ex(p->opr.op[0]) && ex(p->opr.op[1]);
            case OR:	    return ex(p->opr.op[0]) || ex(p->opr.op[1]);
            case BREAK:     brk = 1; return 0;
            case CONTINUE:  cont = 1; return 0;
            case REF:       index = p->opr.op[0]->id.i+ex(p->opr.op[1]);
                            if (index < 26){
                                return sym[index];
                            } else {
                                reportOutRange();
                            }
        }
    }
    return 0;
}
