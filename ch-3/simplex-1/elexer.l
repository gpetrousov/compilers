/*
elexer [echo+lexer] - a simple lexer which echoes its input to the standard output.
*/

%%
. printf("%s", yytext);
%%
int main() {
	yylex();
	printf("%s", yytext);
}

int yywrap() {
	return 1;
}
