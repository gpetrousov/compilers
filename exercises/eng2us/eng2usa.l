/*
Translates English words into American ones.
TODO: Add bunch more words.
*/

%%

"colour" { printf("color\n"); }
"optimise" { printf("optimize\n"); }

%%

int main() {
	printf("'MURICA fuck yeah!!\n");
	yylex();
}

int yywrap() {
	return 1;
}
