%{
#include <stdio.h>
#include "y.tab.h"
void yyerror(char *);
%}

%%
-?(0|[1-9][0-9]*) 	{
		yylval.double_value = atof(yytext); 
		return NUMBER;
	}
-?(([1-9][0-9]*|0)\.[0-9]+) {
        yylval.double_value = atof(yytext);
        return NUMBER;
}

[-+*/%()^\n]		return *yytext;
SQRT return SQRT;
PI  return PI;
ME  return ME;
SIN  return SIN;
COS  return COS;
TAN  return TAN;
LOG  return LOG;
FACT  return FACT;

[ \t] ;
.      		yyerror("invalid character");
%%
int yywrap(void) {
 return 1;
}

