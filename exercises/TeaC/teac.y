%{
	#include <stdio.h>
	extern int yylineno;
	extern int yyerror();
	extern FILE *yyin;
	extern int yylex();
	extern int yyerror();
%}

/* keyword tokens */
%token INT_TYPE	REAL_TYPE BOOL_TYPE	STRING_TYPE	TRUE_KW FALSE_KW IF_KW	THEN_KW	ELSE_KW FI_KW WHILE_KW LOOP_KW POOL_KW 	CONST_KW LET_KW	RETURN_KW START_KW

/* identifiers */
%token ID

/* integer positive constant */
%token CONST_INTEGER_NUM 

/* real positive constant */
%token REAL_NUM

/* string constant */
%token STRING

/* operators */
%token EQ_OP LT_OP LTEQ_OP NEQ_OP AND_OP OR_OP NOT_OP PLUS_OP MINUS_OP MUL_OP DIV_OP MOD_OP	ASSIGN_OP

/* delimiters */
SEMI LEFT_PAR RIGHT_PAR COMMA LEFT_BRACKET RIGHT_BRACKET LEFT_CURLY_BRACKET	RIGHT_CURLY_BRACKET	ARROW_DELIMITER	COLON

/* precedence and associativity */
%right NOT_OP 
%left MUL_OP DIV_OP MOD_OP PLUS_OP MINUS_OP
%left EQ_OP NEQ_OP LT_OP LTEQ_OP AND_OP OR_OP
%nonassoc THEN_KW
%nonassoc ELSE_KW

%start program

%%

program: constants_optional variables_optional main_function ;

/* constants declaration */
constants_optional: constants | /* empty */ ;
constants: constants constant_declaration | constant_declaration ;

constant_declaration: CONST_KW id_name constant_init COLON type SEMI ;
id_name: ID | ID LEFT_BRACKET CONST_INTEGER_NUM RIGHT_BRACKET ;
constant_init: ASSIGN_OP optional_sign value ;
optional_sign: MINUS_OP | /* empty */ ;

/* variables declaration */
variables_optional: variables | /* empty */ ;
variables: variables variable_declaration | variable_declaration ;

variable_declaration: LET_KW id_name variable_init COLON type SEMI ;
variable_init: ASSIGN_OP optional_sign value | /* empty */ ;

/* statements */
statement: assignment | if_statement | while_statement ;
statements: statements statement | statement ;

/* assignment */
assignment: id_name ASSIGN_OP expression ;

/* If statement */
if_statement: IF_KW expression THEN_KW statements FI_KW
			| IF_KW expression THEN_KW statements ELSE_KW statements optional_else_part FI_KW ;
optional_else_part: ELSE_KW statements | /* empty */ ;

/* while statement */
while_statement: WHILE_KW expression LOOP_KW statements POOL_KW ;

/* expression */
expression:
    expression PLUS_OP expression |
    expression MINUS_OP expression |
    expression MUL_OP expression |
    expression DIV_OP expression |
    expression MOD_OP expression |
    expression OR_OP expression |
    expression AND_OP expression |
    NOT_OP expression |
    expression EQ_OP expression |
    expression NEQ_OP expression |
    expression LT_OP expression |
    expression LTEQ_OP expression |
    LEFT_PAR expression RIGHT_PAR |
    optional_sign id_name |
    optional_sign value
;

/* Misc */
type: INT_TYPE | REAL_TYPE | BOOL_TYPE | STRING_TYPE ;
value: CONST_INTEGER_NUM | REAL_NUM | STRING ;

/* main function */
main_function: main_head body main_tail ;
main_head: "const start <- (): int => " LEFT_CURLY_BRACKET
main_tail: RIGHT_CURLY_BRACKET
body: constants | variables | constants statements | variables statements | statements | /* empty */ ;

%%

int main(int argc, char *argv[]) {
	if (argc > 1) {
		if (!(yyin = fopen(argv[1], "r"))) {
			perror(argv[1]);
			return 1;
		}
	}
	yylineno = 1;
	yyparse();
	return 0;
}

int yyerror(const char *msg) {
	printf("%d: %s\n", yylineno, msg);
}
