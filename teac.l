
WHITESPACE [\t\n]
IDENTIFIERS [a-zA-Z0-9_]

%%

"int"			{ printf("KEYWORD: INT\n"); }
"real"			{ printf("KEYWORD: REAL\n"); }
"bool"			{ printf("KEYWORD: BOOL\n"); }
"string"		{ printf("KEYWORD: STRING\n"); }
"true"  		{ printf("KEYWORD: TRUE\n"); }
"false" 		{ printf("KEYWORD: FALSE\n"); }
"if"    		{ printf("KEYWORD: IF\n"); }
"then"  		{ printf("KEYWORD: THEN\n"); }
"else"  		{ printf("KEYWORD: ELSE\n"); }
"fi"    		{ printf("KEYWORD: FI\n"); }
"while" 		{ printf("KEYWORD: WHILE\n"); }
"loop"  		{ printf("KEYWORD: LOOP\n"); }
"pool"  		{ printf("KEYWORD: POOL\n"); }
"const" 		{ printf("KEYWORD: CONST\n"); }
"let"   		{ printf("KEYWORD: LET\n"); }
"return"		{ printf("KEYWORD: RETURN\n"); }
"not"   		{ printf("KEYWORD: NOT\n"); }
"and"   		{ printf("KEYWORD: AND\n"); }
"or"    		{ printf("KEYWORD: OR\n"); }
"start"		 	{ printf("KEYWORD: START\n"); }

{IDENTIFIERS}+ { printf("token IDENTIFIER: %s\n", yytext); }

{WHITESPACE}+


%%

int main(int argc, char *argv[]) {
	if (argc > 1) {
		if (!(yyin=fopen(argv[1], "r"))) {
			perror(argv[1]);
			return 2;
		}
		printf("File opened successfully!\n\n");
	}
	yylex();
	printf("Terminated\n");
}

int yywrap() {
	return 1;
}
