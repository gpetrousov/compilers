%{
	#include <stdio.h>
	int yylex();
	int yyerror();
%}

/* Declare terminal tokens */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL

%start calclist

%%

calclist: /* Do nothing */
		| calclist exp EOL { printf("exp=%d\n", $2); }
		;

exp: factor { $$ = $1; }
   | exp ADD factor { printf("exp ADD term: %d + %d\n", $1, $3); $$ = $1 + $3; }
   | exp SUB factor { printf("exp SUB term: %d - %d\n", $1, $3); $$ = $1 - $3; }
   ;

factor: term { printf("term: %d", $1); $$ = $1; }
	  | factor MUL term { printf("factor MUL term: %d * %d\n", $1, $3); $$ = $1 * $3; }
	  | factor DIV term { printf("factor DIV term: %d / %d\n", $1, $3); $$ = $1 / $3; }
	  ;

term: NUMBER { $$ = $1; }
	| ABS term {
		if ( $2 >=0 ) {
			printf("term: %d\n", $2);
			$$ = $2;
		}
		else {
		/* TODO: This will not work because the regex does not include signs */
			printf("Negative number: %d\n", $2);
			$$ = -$2;
		}
	}
	;

%%

int main(int argc, char **argv) {
	yyparse();
}

int yyerror(char *s) {
	fprintf(stderr, "error: %s\n", s);
}
