%option noyywrap

%{
#include "palin.tab.h"
%}

%%

a	return A;
b	return B;
#	return '#';
\n	return R;
.	{}

%%
