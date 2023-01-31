/* Matches number of the form
[-+]?([0-9]*\.?[0-9]+|[0-9]+\.)(E(+|-)?[0-9]+)? { printf("Match: %f\n", atof(yytext)); }
-1.2e-3

[-+]?[0-9.]+
[-+]?[0-9]+\.?[0-9]+
[-+]?[0-9]*\.?[0-9]+
[-+]?[0-9]+\.?[0-9]*
[-+]?[0-9]*\.?[0-9]*
*/

%%

[-+]?([0-9]*\.?[0-9]+|[0-9]+\.) { printf("Match: %f\n", atof(yytext)); }



%%

int main() {
	yylex();
}

int yywrap() {
	return 1;
}
