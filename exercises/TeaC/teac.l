%option noyywrap yylineno

%{
	#include <stdio.h>
	#include "teac.tab.h"
	extern int yylineno;
	extern int yyerror();
	extern FILE *yyin;
%}

/* Keywords */
INT_TYPE 	"int"
REAL_TYPE 	"real"
BOOL_TYPE	"bool"
STRING_TYPE	"string"
TRUE_KW 	"true"
FALSE_KW 	"false"
IF_KW		"if"
THEN_KW		"then"
ELSE_KW 	"else"
FI_KW 		"fi"
WHILE_KW 	"while"
LOOP_KW 	"loop"
POOL_KW 	"pool"
CONST_KW 	"const"
LET_KW		"let"
RETURN_KW 	"return"
START_KW	"start"

/* identifiers */
ID [a-zA-Z]+[0-9_]*

/* integer positive constant */
CONST_INTEGER_NUM "0"|[1-9][0-9]*

/* real positive constant */
INTEGER_PART (0{1}|[0-9]+)
FRACTIONAL_PART "."[0-9]*
EXPONENT_PART ("e"|"E")?("+"|"-")?[1-9]*
REAL_NUM {INTEGER_PART}{FRACTIONAL_PART}{EXPONENT_PART}

/* string constant */
STRING \"[ -~]*\"

/* operators */
EQ_OP		"="
LT_OP		"<"
LTEQ_OP		"<="
NEQ_OP		"!="
AND_OP	 	"and"
OR_OP 		"or"
NOT_OP		"not"
PLUS_OP		"+"
MINUS_OP	"-"
MUL_OP		"*"
DIV_OP		"/"
MOD_OP		"%"
ASSIGN_OP	"<-"

/* delimiters */
SEMI 				";"
LEFT_PAR 			"("
RIGHT_PAR 			")"
COMMA 				","
LEFT_BRACKET 		"["
RIGHT_BRACKET 		"]"
LEFT_CURLY_BRACKET	"{"
RIGHT_CURLY_BRACKET	"}"
ARROW_DELIMITER		"=>"
COLON				":"

/* Whitespaces */
WHITESPACE [ \t\n\r]+

/* multi line comment */
ML_COMMENT "(*" 
%x ML_COMMENT

/* single line comment */
SL_COMMENT "--".*

/* new line */
NEW_LINE "\n"

%%

{INT_TYPE}		{ printf("%d: Token: INT_TYPE: %s\n", yylineno, yytext); return INT_TYPE; }
{REAL_TYPE} 	{ printf("%d: Token: REAL_TYPE %s\n", yylineno, yytext); return REAL_TYPE; }
{BOOL_TYPE} 	{ printf("%d: Token: BOOL_TYPE: %s\n", yylineno, yytext); return BOOL_TYPE; }
{STRING_TYPE}	{ printf("%d: Token: STRING_TYPE: %s\n", yylineno, yytext); return STRING_TYPE; }
{TRUE_KW} 		{ printf("%d: Token: TRUE_KW: %s\n", yylineno, yytext); return TRUE_KW; }
{FALSE_KW}		{ printf("%d: Token: FALSE_KW: %s\n", yylineno, yytext); return FALSE_KW; }
{IF_KW}			{ printf("%d: Token: IF_KW: %s\n", yylineno, yytext); return IF_KW; }
{THEN_KW} 		{ printf("%d: Token: THEN_KW: %s\n", yylineno, yytext); return THEN_KW; }
{ELSE_KW} 		{ printf("%d: Token: ELSE_KW: %s\n", yylineno, yytext); return ELSE_KW; }
{FI_KW} 		{ printf("%d: Token: FI_KW: %s\n", yylineno, yytext); return FI_KW; }
{WHILE_KW}		{ printf("%d: Token: WHILE_KW: %s\n", yylineno, yytext); return WHILE_KW; }
{LOOP_KW} 		{ printf("%d: Token: LOOP_KW: %s\n", yylineno, yytext); return LOOP_KW; }
{POOL_KW} 		{ printf("%d: Token: POOL_KW: %s\n", yylineno, yytext); return POOL_KW; }
{CONST_KW}		{ printf("%d: Token: CONST_KW: %s\n", yylineno, yytext); return CONST_KW; }
{LET_KW} 		{ printf("%d: Token: LET_KW: %s\n", yylineno, yytext); return LET_KW; }
{RETURN_KW} 	{ printf("%d: Token: RETURN_KW: %s\n", yylineno, yytext); return RETURN_KW; }
{START_KW}		{ printf("%d: Token: START_KW: %s\n", yylineno, yytext); return START_KW; }

{CONST_INTEGER_NUM} {
	printf("%d: Token CONST_INTEGER_NUM: %s\n", yylineno, yytext);
	return CONST_INTEGER_NUM;
	}

{REAL_NUM} {
	printf("%d: Token REAL_NUM: %s\n", yylineno, yytext);
	return REAL_NUM;
	}

{STRING} {
	printf("%d: Token: STRING: %s\n", yylineno, yytext);
	return STRING;
	}

{EQ_OP} 	{ printf("%d: Token EQ_OP: %s\n", yylineno, yytext); return EQ_OP; }
{LT_OP} 	{ printf("%d: Token LT_OP: %s\n", yylineno, yytext); return LT_OP; }
{LTEQ_OP} 	{ printf("%d: Token LTEQ_OP: %s\n", yylineno, yytext); return LTEQ_OP; }
{NEQ_OP} 	{ printf("%d: Token NEQ_OP: %s\n", yylineno, yytext); return NEQ_OP; }
{AND_OP}	{ printf("%d: Token AND_OP: %s\n", yylineno, yytext); return AND_OP; }
{OR_OP}		{ printf("%d: Token OR_OP: %s\n", yylineno, yytext);  return OR_OP; }
{NOT_OP} 	{ printf("%d: Token NOT_OP: %s\n", yylineno, yytext); return NOT_OP; }
{PLUS_OP} 	{ printf("%d: Token PLUS_OP: %s\n", yylineno, yytext); return PLUS_OP; }
{MINUS_OP}	{ printf("%d: Token MINUS_OP: %s\n", yylineno, yytext); return MINUS_OP; }
{MUL_OP} 	{ printf("%d: Token MUL_OP: %s\n", yylineno, yytext); return MUL_OP; }
{DIV_OP} 	{ printf("%d: Token DIV_OP: %s\n", yylineno, yytext); return DIV_OP; }
{MOD_OP} 	{ printf("%d: Token MOD_OP: %s\n", yylineno, yytext); return MOD_OP; }
{ASSIGN_OP}	{ printf("%d: Token ASSIGN_OP: %s\n", yylineno, yytext); return ASSIGN_OP; }

{SEMI}					{ printf("%d: Token SEMI: %s\n", yylineno, yytext); return SEMI;}
{LEFT_PAR}				{ printf("%d: Token LEFT_PAR: %s\n", yylineno, yytext); return LEFT_PAR; }
{RIGHT_PAR}				{ printf("%d: Token RIGHT_PAR: %s\n", yylineno, yytext); return RIGHT_PAR; }
{COMMA}		  	  		{ printf("%d: Token COMMA: %s\n", yylineno, yytext); return COMMA; }
{LEFT_BRACKET}			{ printf("%d: Token LEFT_BRACKET: %s\n", yylineno, yytext); return LEFT_BRACKET; }
{RIGHT_BRACKET} 		{ printf("%d: Token RIGHT_BRACKET: %s\n", yylineno, yytext); return RIGHT_BRACKET; }
{LEFT_CURLY_BRACKET}	{ printf("%d: Token LEFT_CURLY_BRACKET: %s\n", yylineno, yytext); return LEFT_CURLY_BRACKET; }
{RIGHT_CURLY_BRACKET}	{ printf("%d: Token RIGHT_CURLY_BRACKET: %s\n", yylineno, yytext); return RIGHT_CURLY_BRACKET; }
{ARROW_DELIMITER} 		{ printf("%d: Token: ARROW_DELIMITER %s\n", yylineno, yytext); return ARROW_DELIMITER; }
{COLON}					{ printf("%d: Token COLON: %s\n", yylineno, yytext); return COLON; }

{ID} {
	printf("%d: Token: IDENTIFIER: %s\n", yylineno, yytext);
	return ID;
	}

{SL_COMMENT} { printf("%d: Single line comment detected\n", yylineno); }

{ML_COMMENT} { printf("%d: Multiline comment starts\n", yylineno); BEGIN(ML_COMMENT); }
<ML_COMMENT>[^*\n]+ /* Ignore whatever is inside the comment */
<ML_COMMENT>"*)" { printf("%d: Multiline commment ends\n", yylineno); BEGIN(INITIAL); }
<ML_COMMENT>"\n" /* Updates yylineno automatically */

{NEW_LINE} /* Updates yylineno automatically */

{WHITESPACE} /* Ignore whitespace */

. { yyerror("Unrecognized token "); }

%%
