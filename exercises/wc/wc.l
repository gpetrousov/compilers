/*
A wc-like program.
*/

%{
#include <string.h>
	int chars = 0;
	int words = 0;
	int lines = 0;
	int spaces = 0;
	int special = 0;
	int numbers = 0;
	int digits = 0;
%}

WORD [a-zA-Z]
SINGLE_DIGIT 0|1|2|3|4|5|6|7|8|9

%%

sp? { special++; words++; chars += strlen(yytext); }

{SINGLE_DIGIT}+ { numbers++; digits += strlen(yytext); }

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
	printf(
	"Lines: %d, \
	Words: %d, \
	Chars: %d \
	Spaces: %d \
	Special: %d \
	Digits: %d \
	Numbers: %d\n",
	lines, words, chars, spaces, special, digits, numbers);
}

int yywrap() {
	return 1;
}
