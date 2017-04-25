// this is code collection for reporting error

void reportOutOfLoop(){
    yyerror("break or continue statement not within loop\n");
    exit(breakContinueError);
}

void reportInvalid(){
    fprintf(stderr, "invalid break or continue statement\n");
    exit(breakContinueError);
}

void reportUndefined(int offset){
    tableNode* var;
    var = getNodeFromTable(offset, Table);
    fprintf(stderr, "line %d: undefined varible: '%s'\n", var->lineNo, var->varName);
    exit(variableUseBeforeDefined);
}

void reportMisMatched(){
    fprintf(stderr, "the type of argument does not match the function used\n" );
    exit(typeMisMatched);
}

void reportUnused(char* funcName){
    fprintf(stderr, "function: %s has been defined but not used\n", funcName);
    exit(funcUnused);
}
