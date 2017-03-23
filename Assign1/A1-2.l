%{


%}

%%

((10|(11|1001*0)(0001*0|101*0|01)*(00|1))10*)* printf("good\n");
.

%%

int main() {
	yyin = stdin;
  	yylex();
  	return 0;
}