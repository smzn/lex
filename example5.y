%{
#include<stdio.h>
#include<math.h>
void yyerror(const char *str){
        fprintf(stderr,"error: %s\n",str);
}
main(){
        yyparse();
}
%}
%union {
    double double_value;
}
%token <double_value> NUMBER SQRT PI ME SIN COS TAN LOG FACT
%type  <double_value> expr term factor
%%
lines   : lines line
        | /* NULL */
        ;
line    : expr '\n'         { printf(">> %f\n", $1); }
        | '\n'
        ;
expr    : term
        | expr '+' term     { $$ = $1 + $3; }
        | expr '-' term     { $$ = $1 - $3; }
        | SQRT '(' term ')'     { $$ = sqrt($3);}
        | SIN '(' term ')'     { $$ = sin($3);}
        | COS '(' term ')'     { $$ = cos($3);}
        | TAN '(' term ')'     { $$ = tan($3);}
        | LOG '(' term ')'     { $$ = log($3);}
        | FACT '(' term ')'     { $$ = fact($3);}
        ;

term   : factor
       | term '*' factor    {$$ = $1 * $3; }
       | term '/' factor    {$$ = $1 / $3; }
       | term '%' factor   { $$ = fmod($1, $3); }
       | term '^' factor    {$$ = pow($1, $3); }
       ;

factor : NUMBER
       | '(' expr ')'      { $$ = $2; }
       | PI      { $$ = M_PI;}
       | ME      { $$ = M_E;}
%%

long fact(int n){
    long fc, i;
    for(fc = 1, i = n; i > 0; i--) fc *= i;
    return fc;
}
