/*
A wc-like program.
*/

%{
#include <string.h>
	int chars = 0;
	int words = 0;
	int lines = 0;
	int spaces = 0;
%}

WORD [a-zA-Z]

%%

{WORD}+ { words++; chars += strlen(yytext); }

\n    { chars++; lines++; }

.     {
	chars++;
	if (strcmp(yytext," ")==0) {
		++spaces;
		}
	}

%%

int main() {
	yylex();
	printf("Lines: %d, Words: %d, Chars: %d Spaces: %d\n", lines, words, chars, spaces);
}

int yywrap() {
	return 1;
}
