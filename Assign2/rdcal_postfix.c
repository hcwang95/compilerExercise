// Recursive-descent top-down calculator
//   that follows strictly the translation steps
//   (i.e., first few slides of L8)

// To compile: flex rdcal_postfix.l; gcc -o rdcal_postfix lex.yy.c rdcal_postfix.c

#include <stdio.h>
#include <stdlib.h>




enum {NUM=1, ADD, SUB, MUL, DIV, NL, END};
typedef struct Expression1
{
  // num op num op ... size denote the total length
  int size;
  int* numOpArray;
}Expression1;

typedef struct Expression2
{
  int op;
  Expression1* expression;
}Expression2;


void copy(int* des_ptr, Expression1* source_ptr, int size){ 
  if (source_ptr == NULL){
    return;
  }
  int i = 0;
  for (i = 0; i<size; ++i){
    des_ptr[i] = source_ptr->numOpArray[i];
  }
}

extern int yylex();
extern int tokenValue;

int next; // lookahead

int getToken() { next = yylex(); }

void reportError() { printf("Something wrong!\n"); exit(0); }

int match(int x) {
  int i = tokenValue;
  if (next == x) {
    getToken(); return i;
  }
  else
    reportError();
}

Expression1* parseExpr1();

Expression2* parseExpr2(){
  Expression2* output = (Expression2*)malloc(sizeof(Expression2));
  Expression1* expression = (Expression1*)malloc(sizeof(Expression1));
  switch(next){
    case(ADD):
      match(ADD);
      expression = parseExpr1();
      output->op = ADD;
      output->expression = expression;
      return output;
    case(SUB):
      match(SUB);
      expression = parseExpr1();
      output->op = SUB;
      output->expression = expression;
      return output;
    case(MUL):
      match(MUL);
      expression = parseExpr1();
      output->op = MUL;
      output->expression = expression;
      return output;
    case(DIV):
      match(DIV);
      expression = parseExpr1();
      output->op = DIV;
      output->expression = expression;
      return output;
    default:
      reportError();
  }
}

Expression1* parseExpr1(){
  int i;
  Expression1* output = (Expression1*)malloc(sizeof(Expression1));
  Expression2* expression = (Expression2*)malloc(sizeof(Expression2));
  switch(next){
    case(NUM):
      i = parseExpr();
      expression = parseExpr2();
      output->size = expression->expression->size + 2;
      output->numOpArray = (int*)malloc(sizeof(int)*output->size);
      output->numOpArray[0] = i;
      output->numOpArray[1] = expression->op;
      copy(output->numOpArray+2, expression->expression, expression->expression->size);
      return output;
    case(NL):
      output->size = 0;
      output->numOpArray = NULL;
      return output;
    case(ADD):
      output->size = 0;
      output->numOpArray = NULL;
      return output;
    case(SUB):
      output->size = 0;
      output->numOpArray = NULL;
      return output;
    case(MUL):
      output->size = 0;
      output->numOpArray = NULL;
      return output;
    case(DIV):
      output->size = 0;
      output->numOpArray = NULL;
      return output;
    default:
    reportError();
  }
  



}

int _cal(int loperand, int roprand, int op){
  switch(op){
    case(ADD):
      return loperand + roprand;
    case(SUB):
      return loperand - roprand;
    case(MUL):
      return loperand * roprand;
    case(DIV):
      return loperand / roprand;
  }
}

int cal(int inputInt, Expression1* inputExpression){
  int output, i;
  output = inputInt;
  for(i=0;i<inputExpression->size; i+=2){
      output = _cal(output, inputExpression->numOpArray[i], inputExpression->numOpArray[i+1]);
  }
  return output;
}

int parseExpr() {
  int i, output;
  Expression1* expression = (Expression1*)malloc(sizeof(Expression1));
  i = match(NUM);
  expression = parseExpr1();
  return cal(i, expression);
}


  
main() {
  getToken();  
  int output = parseExpr();
  printf("=%d\n", output);
}
