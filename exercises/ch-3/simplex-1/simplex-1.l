/*
elexer [echo+lexer] - a simple lexer which echoes its input to the standard output.
By default all stdin is output to stdout
*/

%%

%%
int main() {
	// main() - is required because it's present in the parser.
	// yylex() - fetches the next token form the input.
	yylex();
}

int yywrap() {
	// yywrap() - required for the termination of the parser
	return 1;
}
