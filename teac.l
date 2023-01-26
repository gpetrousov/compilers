%{
	int line = 1;
%}

CR [\n]
IDENTIFIERS [a-zA-Z0-9_]
INT_POS_CONST [0-9]

%%

"int"			{ printf("%d: KEYWORD: INT\n", line); }
"real"			{ printf("%d: KEYWORD: REAL\n", line); }
"bool"			{ printf("%d: KEYWORD: BOOL\n", line); }
"string"		{ printf("%d: KEYWORD: STRING\n", line); }
"true"  		{ printf("%d: KEYWORD: TRUE\n", line); }
"false" 		{ printf("%d: KEYWORD: FALSE\n", line); }
"if"    		{ printf("%d: KEYWORD: IF\n", line); }
"then"  		{ printf("%d: KEYWORD: THEN\n", line); }
"else"  		{ printf("%d: KEYWORD: ELSE\n", line); }
"fi"    		{ printf("%d: KEYWORD: FI\n", line); }
"while" 		{ printf("%d: KEYWORD: WHILE\n", line); }
"loop"  		{ printf("%d: KEYWORD: LOOP\n", line); }
"pool"  		{ printf("%d: KEYWORD: POOL\n", line); }
"const" 		{ printf("%d: KEYWORD: CONST\n", line); }
"let"   		{ printf("%d: KEYWORD: LET\n", line); }
"return"		{ printf("%d: KEYWORD: RETURN\n", line); }
"not"   		{ printf("%d: KEYWORD: NOT\n", line); }
"and"   		{ printf("%d: KEYWORD: AND\n", line); }
"or"    		{ printf("%d: KEYWORD: OR\n", line); }
"start"		 	{ printf("%d: KEYWORD: START\n", line); }

{INT_POS_CONST}+	{ printf("%d: INT_POS_CONST: %d\n", line, atoi(yytext)); }

{IDENTIFIERS}+ { printf("%d: token IDENTIFIER: %s\n", line, yytext); }

{CR}			{ ++line; printf("%d: CR token\n", line); }

.				{ printf("%d: Unidentified character: %s\n", line, yylex); }


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
	printf("\nTerminated\n");
}

int yywrap() {
	return 1;
}
