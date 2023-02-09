%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symtab.c"

extern FILE *yyin;
extern FILE *yyout;
extern int yylineno; 
extern int yylex(); 
extern void yyerror(); 
%}

/* YYSTYPE union */
%union {
    char char_val;
    int int_val;
	double double_val;
	char *str_val;
	list_t *symtab_item;
}

/* Token Definition
The symbols we want the lexer to return to the parser.
*/
%token<int_val> CHAR INT FLOAT DOUBLE IF ELSE WHILE FOR CONTINUE BREAK VOID RETURN
%token<int_val> ADDOP MULOP DIVOP INCR OROP ANDOP NOTOP EQUOP RELOP
%token<int_val> LPAREN RPAREN LBRACK RBRACK LBRACE RBRACE SEMI DOT COMMA ASSIGN REFER
%token<symtab_item> ID
%token<int_val> ICONST
%token<double_val> FCONST
%token<char_val> CCONST
%token<str_val> STRING

/* expression priorities and rules */
%left LPAREN RPAREN LBRACK RBRACK
%right NOTOP INCR REFER
%left MULOP DIVOP
%left ADDOP
%left RELOP
%left EQUOP
%left OROP
%left ANDOP
%right ASSIGN
%left COMMA

/* Define the startinb symbol. */
%start program

%%

program: declarations statements RETURN SEMI functions_optional ;


/***** Declarations or Initializations *****/
declarations: declarations declaration | declaration;
declaration: type names SEMI;
type: INT | CHAR | FLOAT | DOUBLE | VOID;
names: names COMMA variable | names COMMA init | variable | init ;
init: var_init | array_init ;
var_init: ID ASSIGN constant ;
array_init: ID array ASSIGN LBRACE values RBRACE ;
values: values COMMA constant | constant;
constant: ICONST { printf("%d\n", yylval.int_val); }
		| FCONST { printf("%.2f\n", yylval.double_val); }
		| CCONST
		; 
variable: ID
		| pointer ID
		| ID array
		;
pointer: pointer MULOP | MULOP;
array: array LBRACK expression RBRACK | LBRACK expression RBRACK;


/***** Statements *****/
statements: statements statement | statement ;
statement: if_statement | for_statement | while_statement | assignment SEMI |
		 CONTINUE SEMI | BREAK SEMI | function_call SEMI | ID INCR SEMI | INCR ID SEMI
		 ;
if_statement:
			IF LPAREN expression RPAREN tail else_if optional_else
			| IF LPAREN expression RPAREN tail optional_else
			;
else_if:
	   else_if ELSE IF LPAREN expression RPAREN tail
	   | ELSE IF LPAREN expression RPAREN tail
	   ;
optional_else:
			 ELSE tail
			 | /* empty */
			 ;
for_statement: FOR LPAREN assignment SEMI expression SEMI expression RPAREN tail;
while_statement: WHILE LPAREN expression RPAREN tail;
tail: LBRACE statements RBRACE;
assignment: var_ref ASSIGN expression ;
var_ref: variable | REFER variable ;

expression:
expression ADDOP expression
| expression MULOP expression
| expression DIVOP expression
| ID INCR
| INCR ID
| expression OROP expression
| expression ANDOP expression
| NOTOP expression
| expression EQUOP expression
| expression RELOP expression
| LPAREN expression RPAREN
| var_ref
| sign constant
| function_call
;

sign: ADDOP | /* empty */ ;
function_call: ID LPAREN call_params RPAREN ;
call_params: call_param | STRING | /* empty */ ;
call_param: call_param COMMA expression | expression ;


/***** Functions *****/
functions_optional: functions | /* empty */ ;
functions: functions function | function ;
function: function_head function_tail ;

function_head: return_type ID LPAREN parameters_optional RPAREN ;
return_type: type | pointer type ;
parameters_optional: parameters | /* empty */ ;
parameters: parameters COMMA parameter | parameter ;
parameter: type variable ;

function_tail: LBRACE declarations_optional statements_optional return_optional RBRACE;
declarations_optional: declarations | /* empty */ ;
statements_optional: statements | /* empty */ ;
return_optional: RETURN expression SEMI | /* empty */ ;


%%

void yyerror() {
    fprintf(stderr, "Syntax error at line %d\n", yylineno);
	exit(1);
}

int main(int argc, char *argv[]) {

	// Initialize the line number
	yylineno = 1;

    printf("\n=== Parser starts ===\n");
	// Init symbol table.
	init_hash_table();

	// parsing
    int flag;
	yyin = fopen(argv[1], "r");
	flag = yyparse();
	fclose(yyin);

	// Save symbol table to file.
	yyout = fopen("symtab.out", "w");
	symtab_dump(yyout);
	fclose(yyout);

    printf("=== Parser ends ===\n");

	return flag;
}
