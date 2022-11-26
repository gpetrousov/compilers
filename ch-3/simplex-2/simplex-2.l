/*
Expand the simplex-1 to count nof lines and words in a file.
*/

%top{
// Everything inside the %top{} code goes at the "top" of the generated file.
#include <stdio.h>
}

%{
// Copied exactly as it to the lexer.
int num_lines=0, num_chars=0;
%}

%%
\n ++num_lines; ++num_chars;
.  ++num_chars;

%%

int main() {
	yylex();
	printf( "# of lines = %d, # of chars = %d\n", num_lines, num_chars );
}

int yywrap() {
	return 1;
}
