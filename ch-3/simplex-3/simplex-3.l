/*
Expand the previous lexer to output the text that is read from stdin to stdout and the line at which it was encountered.
Print the number of lines and characters read at the end.
*/

LETTER [a-zA-Z]
LETTER_OR_DIGIT [a-zA-Z0-9]

%{
	int nof_lines = 0, nof_chars = 0;
%}

%%

{LETTER}{LETTER_OR_DIGIT}* {
	++nof_chars;
	printf("Found something: %s", yytext);
	}

. {
	++nof_chars;
	printf("Found an unknown input: %s", yytext);
	}

%%

int main() {
	yylex();
	printf("Nof lines: %d\nNof characters:  %d\n", nof_lines, nof_chars);
}

int yywrap() {
	return 1;
}
