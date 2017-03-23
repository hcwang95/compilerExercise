%locations

%{
  #include <string.h>
  #include <stdio.h>
  static int Lookup(const char *name);
  static void Store(const char *name, int v);
  void yyerror(char *);
%}
%union {
  int intVal;
  char name[32];
}
%token <intVal> T_Int
%token <name> T_Identifier
%type <intVal> E
%left '+' '-'
%left '*' '/'
%right U_minus
%%
S : Stmt | S Stmt
  ;
Stmt : T_Identifier '=' E '\n'
    { Store($1, $3); printf("%d\n", $3);}
  | E '\n'
    { printf("%d\n", $1);}
  | error '\n'
    { printf("Discarding malformed expression.\n"); }
  ;
E : E '+' E
    { $$ = $1 + $3; }
  | E '-' E
    { $$ = $1 - $3; }
  | E '*' E
    { $$ = $1 * $3; }
  | E '/' E
    { if ($3 == 0) {
        printf("divide by zero\n");
        $$ = 0;
      } else
      $$ = $1 / $3;
    }
  | '(' E ')'
    { $$ = $2;}
  | '-' E %prec U_minus
    { $$ = -$2;}
  | T_Int
    { $$ = $1;}
  | T_Identifier
    { $$ = Lookup($1); }
  ;
%%

char var[50][32]; // symbol table of up to 50
int val[50]; // symbols' values
int m = 0; // current "top" of symbol table

static int Lookup(const char *name) {
  int i;
  for (i = 0; i < m; i++)
    if (strcmp(name, var[i]) == 0)
      return val[i];
  return 0;
}

static void Store(const char *name, int v) {
  strcpy(var[m], name);
  val[m++] = v;
}

void yyerror(char *s) {
  printf("%s\n", s);
}

int main(void) {
  yyparse();
  return 0;
}
