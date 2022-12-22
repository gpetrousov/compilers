/*
Expand the previous lexer to output the text that is read from stdin to stdout and the line at which it was encountered.
Print the number of lines and characters read at the end.
TODO: lexer work for strings and not just characters.
*/

%{
	int nof_lines = 0, nof_chars = 0;
%}

%%

. {
	++nof_chars;
	printf("%d: %s\n", nof_lines, yytext);
	}

\n {
	++nof_lines;
	++nof_chars;
}

%%

int main() {
	yylex();
	printf("\n# lines: %d\n# characters:  %d\n", nof_lines, nof_chars);
}

int yywrap() {
	return 1;
}
