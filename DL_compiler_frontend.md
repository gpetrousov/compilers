# BNF of the DL programming language

```
<program> ::= <block> | <declarations> <block>
<declarations> ::= <declaration> | <declaration> <declarations>
<declaration> ::= <variabledeclaration> | <functiondeclaration>
<variabledeclaration> ::= int <vardeflist> ;
<vardeflist> ::= <vardec> | <vardec> , <vardeflist>
<vardec> ::= <identifier> | <identifier> [ <constant> ]
<functiondeclaration> ::= <identifier> (); <functionbody> | <identifier> ( <arglist> ); <functionbody>
<functionbody> ::= <variabledeclaration> <block> | <block>
<arglist> ::= <identifier> | <identifier> , <arglist>
<block> ::= { <statementlist> }
<statementlist> ::= <statement> | <statement> ; <statementlist>
<statement> ::= <assignment> | <ifstatement> | <whilestatement> | <block> | <printstatement> | <readstatement> | <returnstatement> | <empty>
<assignment> ::= <identifier> = <expression> | <identifier> [ <expression> ] = <expression>
<ifstatement> ::= if ( <bexpression> ) <block> else <block> | if ( <bexpression> ) <block>
<whilestatement> ::= while ( <bexpression> ) <block>
<printstatement> ::= print ( <expression> )
<readstatement> ::= read ( <identifier> )
<returnstatement> ::= return <expression>
<expression> ::= <expression> <addingop> <term> | <term> | <addingop> <term>
<bexpression> ::= <expression> <relop> <expression>
<relop> ::= < | <= | == | >= | > | !=
<addingop> ::= + | -
<term> ::= <term> <multop> <factor> | <factor>
<multop> ::= * | /
<arguments> ::= <expression> | <expression> , <arguments>
<factor> ::= <constant> | <identifier> | <identifier> [ <expression>] | ( <expression> ) | <identifier> ( <arguments> ) | <identifier> ( )
<constant> ::= <digit> | <digit> <constant>
<identifier> ::= <identifier> <letterordigit> | <letter>
<letterordigit> ::= <letter> | <digit>
<letter> ::= a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z
<digit> ::= 0|1|2|3|4|5|6|7|8|9
<empty> has the obvious meaning
```

Names have to be declared before they are used. This implies that mutually recursive functions are not allowed. All functions return a single integer result.

Comments (zero or more characters enclosed between the standard C comment brackets /*...*/) can be inserted. DL has rudimentary support for one-dimensional arrays. The declaration int a[3] declares an array of three elements, referenced as a[0], a[1] and a[2]. Names are scoped in the traditional way.


## Lexical analyser for DL (`flex`)

```C
%{
#include dlrecog_defs.h
#include dlrecog_syn.h
.
.
.
int lexnumval;
66 3 Lexical Analysis
char lexident[MAXIDLEN+1];
%}
letter [a-z]
digit [0-9]
letter_or_digit [a-z0-9]
white_space [ \t\n]
other .
%%
"==" return EQSYM;
"<=" return LESYM;
">=" return GESYM;
"!=" return NESYM;
else return ELSESYM;
if return IFSYM;
int return INTSYM;
print return PRINTSYM;
read return READSYM;
return return RETURNSYM;
while return WHILESYM;
{letter}{letter_or_digit}* return IDENTIFIER;
{digit}+ { lexnumval = atoi(yytext);
return CONSTANT;
}
"/*" { comment(); }
{white_space}+ ;
{other} return yytext[0];
%%
.
.
.
int main() {
		int lextoken;
		while (lextoken = yylex())
				printf("%d - %s\n",lextoken, yytext);
		}
int yywrap()
{
		return 1;
}
int comment(){
		return 0;
}
```

"
- The two-character tokens are defined first, followed by the reserved words, followed by identifiers and numerical constants.
- Reserved words have to be matched before the identifiers to prevent an input such as else being recognised as an identifier rather than a reserved word.
"

## Syntax analyser for DL (`bison`)

```C
%{
#include "dlrecog_defs.h"
%}
%token CONSTANT IDENTIFIER LESYM EQSYM GESYM NESYM ELSESYM IFSYM
%token INTSYM PRINTSYM READSYM RETURNSYM WHILESYM

%token <sval> CONSTANT
%token <sval> IDENTIFIER
%token <sval> ELSESYM
%token <sval> IFSYM
%token <sval> LESYM
.
.
%type <psval> program
%type <psval> declarations
%type <psval> declaration
.
.
%type <sval> relop
%type <strval> identifier
%type <sval> constant

%%
program:
block
{ syntrace("program - without declarations"); }
| declarations block
{ syntrace("program - with declarations"); }
functiondeclaration:
IDENTIFIER ’(’ ’)’ ’;’ functionbody
{ syntrace("functiondeclaration - no args"); } 
126 5 Practicalities of Syntax Analysis
| IDENTIFIER ’(’ arglist ’)’ ’;’ functionbody
{ syntrace("functiondeclaration - with args"); }
ifstatement:
IFSYM ’(’ bexpression ’)’ block ELSESYM block
{ syntrace("ifelsestatement"); 
$$ = newnode(N_IF, 0, $3, $5, $7); }
| IFSYM ’(’ bexpression ’)’ block
{ syntrace("ifstatement");
$$ = newnode(N_IF, 0, $3, $5, NULL);}
expression:
expression addingop term {
		syntrace("expression");
		$$ = newnode($2, 0, $1, $3, NULL);
}
| term {syntrace("expression - just term"); }
| addingop term {
		syntrace("expression - unary op");
		if ($1 == N_MINUS)
				$$ = newnode(N_MINUS, 0, $2, NULL, NULL);
		else $$ = $2;
		}
statementlist:
statement {
		syntrace("statemenlist");
		$$ = newnode(N_SLIST, 0, $1, NULL, NULL);
		| statement ';' statementlist {
				syntrace("statemenlist");
				$$ = newnode(N_SLIST, 0, $1, $3, NULL);
		}
functiondeclaration:
identifier ’(’ { /* Code placing identifier into symbol table.
Save the state of the symbol table.
Save and reset a pointer to the storage of
local variables in the runtime stack. */ }
arglist ’)’ ’;’ functionbody {
		syntrace("functiondeclaration");
		$$ = newnode(N_FUNCTION, functioncount++, $4, $7, NULL);
/* Save storage requirements of this
function in the symbol table.
Reset local variable pointer. */ }

%%
void syntrace(char *s)
{
if (TRACE) fprintf(stdout, "%s\n", s);
}
void yyerror(char *s)
{
printf("%s on line %d\n",s,yylineno);
}
int main(int argc, char *argv[])
{
if (yyparse() == 0) syntrace("Recogniser succeeds");
return 0;
}
```

Where `newnode()` is a function which generates new nodes and has the following definition.

`newnode(type_of_node, node_value, node_pointer_1, node_pointer_2, node_pointer_3)`

"
- The header file dlrecog_defs.h defines any function prototypes required and can contain #include directives for other (system) header files.
- The %token declarations correspond to the tokens used in the lexical analyser
- Terminal tokens are in upper case and non-terminals are in lower case
- The `syntrace() outputs it's argument`
- The generatd parser/recogniser is called by `yyparse()` in the `main()`program.
"
