%option noyywrap yylineno

%{
	#include <stdio.h>
	extern int yylineno;
	extern int yyerror();
%}


/* KEYWORDS

/* identifiers */
ID [a-zA-Z]+[0-9_]*

/* integer positive constant */
CONST_INTEGER "0"|[1-9][0-9]*

/* real positive constant */
INTEGER_PART (0{1}|[0-9]+)
FRACTIONAL_PART "."[0-9]*
EXPONENT_PART ("e"|"E")?("+"|"-")?[1-9]*
REAL {INTEGER_PART}{FRACTIONAL_PART}{EXPONENT_PART}

/* string constant */
STRING \"[ -~]*\"

/* operators */
EQ_OP "="
LT_OP "<"
LTEQ_OP "<="
NE_OP "!="
PLUS_OP "+"
MINUS_OP "-"
AND_OP "and"|"AND"
OR_OP "or"|"OR"
NOT_OP "not"|"NOT"

/* delimiters */
SEMI ";"
OP "("
CP ")"
COMMA ","
OB "["
CB "]"
OCB "{"
CCB "}"
ASSIGN "<-"
COLON ":"
ARROW_OP "=>"

/* multiline comment */
%x ML_COMMENT


/* Whitespaces */
WHITESPACE [ \t\n\r]+

%%

"int" { printf("%d: Token: INT_KW: %s\n", yylineno, yytext); }
"real" { printf("%d: Token: REAL_KW: %s\n", yylineno, yytext); }
"bool" { printf("%d: Token: BOOL_KW: %s\n", yylineno, yytext); }
"string" { printf("%d: Token: STRING_KW: %s\n", yylineno, yytext); }
"true" { printf("%d: Token: TRUE_KW: %s\n", yylineno, yytext); }
"false" { printf("%d: Token: FALSE_KW: %s\n", yylineno, yytext); }
"if" { printf("%d: Token: IF_KW: %s\n", yylineno, yytext); }
"then" { printf("%d: Token: THEN_KW: %s\n", yylineno, yytext); }
"else" { printf("%d: Token: ELSE_KW: %s\n", yylineno, yytext); }
"fi" { printf("%d: Token: FI_KW: %s\n", yylineno, yytext); }
"while" { printf("%d: Token: WHILE_KW: %s\n", yylineno, yytext); }
"loop" { printf("%d: Token: LOOP_KW: %s\n", yylineno, yytext); }
"pool" { printf("%d: Token: POOL_KW: %s\n", yylineno, yytext); }
"const" { printf("%d: Token: CONST_KW: %s\n", yylineno, yytext); }
"let" { printf("%d: Token: LET_KW: %s\n", yylineno, yytext); }
"return" { printf("%d: Token: RETURN_KW: %s\n", yylineno, yytext); }
"start" { printf("%d: Token: START_KW: %s\n", yylineno, yytext); }

{CONST_INTEGER} { printf("%d: Token CONST_INTEGER: %s\n", yylineno, yytext); }

{REAL} { printf("%d: Token REAL: %s\n", yylineno, yytext); }

{STRING} { printf("%d: Token: STRING: %s\n", yylineno, yytext); }

{EQ_OP} { printf("%d: Token EQ_OP: %s\n", yylineno, yytext); }
{LT_OP} { printf("%d: Token LT_OP: %s\n", yylineno, yytext); }
{LTEQ_OP} { printf("%d: Token LTEQ_OP: %s\n", yylineno, yytext); }
{NE_OP} { printf("%d: Token NE_OP: %s\n", yylineno, yytext); }
{PLUS_OP} { printf("%d: Token PLUS_OP: %s\n", yylineno, yytext); }
{MINUS_OP} { printf("%d: Token MINUS_OP: %s\n", yylineno, yytext); }
{AND_OP} { printf("%d: Token AND_OP: %s\n", yylineno, yytext); }
{OR_OP} { printf("%d: Token OR_OP: %s\n", yylineno, yytext); }
{NOT_OP} { printf("%d: Token NOT_OP: %s\n", yylineno, yytext); }

{ID} { printf("%d: Token: IDENTIFIER: %s\n", yylineno, yytext); }

{SEMI} { printf("%d: Token SEMI: %s\n", yylineno, yytext); }
{OP} { printf("%d: Token OP: %s\n", yylineno, yytext); }
{CP} { printf("%d: Token CP: %s\n", yylineno, yytext); }
{COMMA} { printf("%d: Token COMMA: %s\n", yylineno, yytext); }
{OB} { printf("%d: Token OB: %s\n", yylineno, yytext); }
{CB} { printf("%d: Token CB: %s\n", yylineno, yytext); }
{OCB} { printf("%d: Token OCB: %s\n", yylineno, yytext); }
{CCB}  { printf("%d: Token CCB: %s\n", yylineno, yytext); }
{ASSIGN} { printf("%d: Token ASSIGN: %s\n", yylineno, yytext); }
{COLON} { printf("%d: Token COLON: %s\n", yylineno, yytext); }
{ARROW_OP} { printf("%d: Token: ARROW_OP: %s\n", yylineno, yytext); }

"--".* { printf("%d: Single line comment detected\n", yylineno); }

"(*" { printf("%d: Multiline comment starts\n", yylineno); BEGIN(ML_COMMENT); }
<ML_COMMENT>[^*\n]+ /* Ignore whatever is inside the comment */
<ML_COMMENT>"*)" { printf("%d: Multiline commment ends\n", yylineno); BEGIN(INITIAL); }
<ML_COMMENT>"\n" /* Updates yylineno automatically */

\n /* Updates yylineno automatically */

{WHITESPACE} /* Ignore whitespace */

. { yyerror("Unrecognized token "); }

%%

int main(int argc, char *argv[]) {
	if (argc > 1) {
		if (!(yyin = fopen(argv[1], "r"))) {
			perror(argv[1]);
			return 1;
		}
	}
	yylineno = 1;
	yylex();
	return 0;
}

int yyerror(const char *msg) {
	printf("%d: %s: '%s'\n", yylineno, msg, yytext);
}
