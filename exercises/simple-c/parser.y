%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symtab.c"

extern FILE *yyin;
extern FILE *yyout;
extern int lineno; 
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

/* Define the startinb symbol. */
%start program

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


%%

program: declarations statements RETURN SEMI functions_optional ;


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


functions: functions function | function;
function: function_head function_tail | /* empty */;
function_head: return_type ID LPAREN param_empty RPAREN;
function_tail: LBRACE declarations statements RBRACE;
param_empty: parameters | /* empty */;
parameters: parameters COMMA parameter | parameter | /* empty */;
parameter: type variable;
return_type: pointer type | type;

function_call: ID LPAREN call_params RPAREN;
call_params: call_param | STRING | /* empty */;
call_param: call_param COMMA variable | variable;


pointer: pointer MULOP | MULOP;

array: array LBRACK expression RBRACK | LBRACK ICONST RBRACK;

statements: statements statement | statement;
statement: if_statement | for_statement | while_statement | assignment |
		 CONTINUE SEMI | BREAK SEMI | function_call SEMI
		 ;

if_statement: 
			IF LPAREN expression RPAREN tail
			else_if_part
			else_part
			;
else_if_part:
			else_if_part ELSE IF LPAREN expression RPAREN tail
			| ELSE IF LPAREN expression RPAREN tail
			| /* empty */
			;
else_part:
		 ELSE tail
		 | /* empty */
		 ;
 
for_statement: FOR LPAREN assignment expression SEMI expression SEMI expression RPAREN tail;
while_statement: WHILE LPAREN expression RPAREN tail;
tail: LBRACE statements RBRACE;

expression:
expression ADDOP expression
| expression MULOP expression
| expression DIVOP expression
| expression INCR
| INCR expression
| expression OROP expression
| expression ANDOP expression
| NOTOP expression
| expression EQUOP expression
| expression RELOP expression
| LPAREN expression RPAREN
| variable
| sign constant
| function_call
;

sign: ADDOP | /* empty */ ;

assignment: reference variable ASSIGN expression SEMI ;

reference: REFER | /* empty */ ;

%%

void yyerror() {
    fprintf(stderr, "Syntax error at line %d\n", lineno);
	exit(1);
}

int main(int argc, char *argv[]) {

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
