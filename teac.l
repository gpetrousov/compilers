%{
	int linenum = 1;
%}

/* Types */
INT_KW "int"
REAL_KW "real"
BOOL_KW "bool"
STRING_KW "string"

/* Arithmetic Operators */
PLUS_OP "+"
MINUS_OP "-"
MUL_OP "*"
DIV_OP "/"
MOD_OP "%"

/* Relational Operators */
EQ_OP	"="
NEQ_OP	"!="
LT_OP	"<"
LTEQ_OP	"<="

/* Logical tokens - LOTO */
TRUE_LOTO "true"
FALSE_LOTO "false"

/* Logical operators - LOP */
NOT_LOP "not"
AND_LOP "and"
OR_LOP "or"

/* Conditionals */
IF_KW "if"
THEN_KW "then"
ELSE_KW "else"
FI_KW "fi"

/* Loops */
WHILE_KW "while"
LOOP_KW "loop"
POOL_KW "pool"

/* Misc */
CONST_KW "const"
START_KW "start"

/* Assignments */
LET_KW "let"

/* Control */
RETURN_KW "return"

/* Identifiers */
IDENTIFIERS ([a-z]|[A-Z]){1}[a-zA-Z0-9_]*

/* Integer positive constants */
INT_POS_CONST [0-9]+

/* Real positive constants */
REAL_POS_CONST (0|[1-9]+)\.(0|[1-9]+)

/* Constant strings -
https://www.appsloveworld.com/cplus/100/1418/flex-regular-expression-for-strings-with-either-single-or-double-quotes*/
CONST_STR ["]([^"\\\n]|\\(.|\n))*["]

/* Delimiters */
SEMICOLON ";"
OP_PAR "("
CL_PAR ")"
COMMA ","
OP_SQB "["
CL_SQB "]"
ASSIGNMENT "<-"
COLON ":"

/* Comments */
SL_COMMENTS [--]([^"\\\n]|\\(.|\n))*[\n]

/* Rest */
CR [\n]
WHITESPACE [ \t\n]

%%

{INT_KW}		{ printf("%d: token(KEYWORD): INT\n", linenum); }
{REAL_KW}		{ printf("%d: token(KEYWORD): REAL\n", linenum); }
{BOOL_KW}		{ printf("%d: token(KEYWORD): BOOL\n", linenum); }
{STRING_KW}		{ printf("%d: token(KEYWORD): STRING\n", linenum); }
{TRUE_LOTO} 	{ printf("%d: token(TRUE_LOTO): TRUE\n", linenum); }
{FALSE_LOTO} 	{ printf("%d: token(FALSE_LOTO): FALSE\n", linenum); }
{IF_KW}    		{ printf("%d: token(KEYWORD): IF\n", linenum); }
{THEN_KW}  		{ printf("%d: token(KEYWORD): THEN\n", linenum); }
{ELSE_KW}		{ printf("%d: token(KEYWORD): ELSE\n", linenum); }
{FI_KW}    		{ printf("%d: token(KEYWORD): FI\n", linenum); }
{WHILE_KW}		{ printf("%d: token(KEYWORD): WHILE\n", linenum); }
{LOOP_KW}  		{ printf("%d: token(KEYWORD): LOOP\n", linenum); }
{POOL_KW}  		{ printf("%d: token(KEYWORD): POOL\n", linenum); }
{CONST_KW} 		{ printf("%d: token(KEYWORD): CONST\n", linenum); }
{LET_KW}   		{ printf("%d: token(KEYWORD): LET\n", linenum); }
{RETURN_KW}		{ printf("%d: token(KEYWORD): RETURN\n", linenum); }
{NOT_LOP}   	{ printf("%d: token(NOT_LOP): NOT\n", linenum); }
{AND_LOP}   	{ printf("%d: token(AND_LOP): AND\n", linenum); }
{OR_LOP}    	{ printf("%d: token(OR_LOP): OR\n", linenum); }
{START_KW}	 	{ printf("%d: token(KEYWORD): START\n", linenum); }

{REAL_POS_CONST} { printf("%d: token(REAL_POS_CONST): %f\n", linenum, strtof(yytext, NULL)); }

{INT_POS_CONST}	{ printf("%d: token(INT_POS_CONST): %d\n", linenum, atoi(yytext)); }

{IDENTIFIERS} 	{ printf("%d: token(IDENTIFIER): %s\n", linenum, yytext); }

{CONST_STR}		{ printf("%d: token(CONST_STR): %s\n", linenum, yytext); }

{PLUS_OP}		{ printf("%d: token(PLUS_OP): %s\n", linenum, yytext); }
{MINUS_OP}		{ printf("%d: token(MINUS_OP): %s\n", linenum, yytext); }
{MUL_OP}		{ printf("%d: token(MUL_OP): %s\n", linenum, yytext); }
{DIV_OP}		{ printf("%d: token(DIV_OP): %s\n", linenum, yytext); }
{MOD_OP}		{ printf("%d: token(MOD_OP): %s\n", linenum, yytext); }

{EQ_OP}			{ printf("%d: token(EQ_OP): %s\n", linenum, yytext); }
{NEQ_OP}		{ printf("%d: token(NEQ_OP): %s\n", linenum, yytext); }
{LT_OP}			{ printf("%d: token(LT_OP): %s\n", linenum, yytext); }
{LTEQ_OP}		{ printf("%d: token(LTEQ_OP): %s\n", linenum, yytext); }

{SEMICOLON}		{ printf("%d: token(SEMICOLON): %s\n", linenum, yytext); }
{OP_PAR}		{ printf("%d: token(OP_PAR): %s\n", linenum, yytext); }
{CL_PAR}		{ printf("%d: token(CL_PAR): %s\n", linenum, yytext); }
{COMMA}			{ printf("%d: token(COMMA): %s\n", linenum, yytext); }
{OP_SQB}		{ printf("%d: token(OP_SQB): %s\n", linenum, yytext); }
{CL_SQB}		{ printf("%d: token(CL_SQB): %s\n", linenum, yytext); }
{ASSIGNMENT}			{ printf("%d: token(ASSIGNMENT): %s\n", linenum, yytext); }
{COLON}			{ printf("%d: token(COLON): %s\n", linenum, yytext); }

{SL_COMMENTS}	{ printf("%d: token(SL_COMMENTS): %s", linenum, yytext); linenum++; }

{CR}			{ ++linenum; }

{WHITESPACE}	;

.				{ printf("%d: Unidentified character: %s\n", linenum, yylex); }

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
