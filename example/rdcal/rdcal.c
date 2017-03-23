// Recursive-descent top-down calculator
//   that follows strictly the translation steps
//   (i.e., first few slides of L8)

// To compile: flex tcal.l; gcc -o tcal lex.yy.c tcal.c

#include <stdio.h>
#include <stdlib.h>

enum {NUM=1, LB, RB, ADD, SUB, MUL, DIV, NL, END};

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
  
int parseFactor() {
  int i;
  switch(next) {
  case NUM:
    return match(NUM);
  case LB:
    match(LB); i = parseExpr(); match(RB); return i;
  }
  reportError();
}

int parseTerm() {
  int i, j;
  i = parseFactor();
  switch(next) {
  case MUL:
    match(MUL); j = parseTerm(); return i*j;
  case DIV:
    match(DIV); j = parseTerm(); return i/j;
  case NL: case RB: case ADD: case SUB: // Follow()
    return i;
  }
  reportError();
}

int parseExpr() {
  int i, j;
  i = parseTerm();
  switch(next) {
  case ADD:
    match(ADD); j = parseTerm(); return i+j;
  case SUB:
    match(SUB); j = parseTerm(); return i-j;
  case RB: case NL: // Follow()
    return i;
  }
  reportError();
}

void parseProg() {
  switch(next) {
  case LB: case NUM:
    printf("=%d\n", parseExpr()); match(NL); parseProg();
  case END: // Follow()
    printf("Bye!\n"); exit(0);
  }
  reportError();
}
  
main() {
  getToken();
  parseProg();
}
