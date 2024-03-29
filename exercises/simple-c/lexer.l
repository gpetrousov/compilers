%option noyywrap yylineno

%{
#include <stdio.h>
#include <string.h>
#include "symtab.h"
#include "parser.h"

extern FILE *yyin;
extern FILE *yyout;

void yyerror();
%}

/* Define an exclusive state */
%x ML_COMMENT

alpha      [a-zA-Z]
digit      [0-9]
alnum      {alpha}|{digit}

/* Any printable character */
print      [ -~]

/* Terminal tokens */
ID         {alpha}+{alnum}*
ICONST      "0"|[0-9]{digit}*
FCONST      "0"|{digit}*"."{digit}+
CCONST      (\'{print}\')|(\'\\[nftrbv]\')
STRING      \"{print}*\"

%%

"//".*		{ printf("Eat up comment at line %d\n", yylineno); } 

"/*"		{ printf("Eat up comment from line %d ", yylineno); BEGIN(ML_COMMENT); }
<ML_COMMENT>"*/" 	{ printf("to line %d\n", yylineno); BEGIN(INITIAL); }
<ML_COMMENT>[^*\n]+		
<ML_COMMENT>"*"			
<ML_COMMENT>"\n"

"char"|"CHAR"          { return  CHAR; }
"int"|"INT"            { return  INT; }
"float"|"FLOAT"        { return  FLOAT; }
"double"|"DOUBLE"      { return  DOUBLE; }
"if"|"IF"              { return  IF; }
"else"|"ELSE"          { return  ELSE; }
"while"|"WHILE"	       { return  WHILE; }
"for"|"FOR"			   { return FOR ; }
"continue"|"CONTINUE"  { return CONTINUE; }
"break"|"BREAK"	       { return BREAK; }
"void"|"VOID"	       { return VOID; }
"return"|"RETURN"      { return RETURN; }

"+"|"-"					{ return ADDOP; }
"*"	     				{ return MULOP; }
"/"	     				{ return DIVOP; }
"++"|"--"   			{ return INCR; }
"||"        			{ return OROP; }
"&&"	    			{ return ANDOP; }
"!"	     				{ return NOTOP; }
"=="|"!="   			{ return EQUOP; }
">"|"<"|">="|"<="      	{ return RELOP; }

"("      { return LPAREN; }
")"      { return RPAREN; }
"["      { return LBRACK; }
"]"      { return RBRACK; }
"{"      { return LBRACE; }
"}"      { return RBRACE; }
";"      { return SEMI; }
"."      { return DOT;}
","      { return COMMA; }
"="      { return ASSIGN; }
"&"      { return REFER; }

{ID} { 
		// Insert identifier into symbol table
		insert(yytext, strlen(yytext), UNDEF, yylineno);
		return ID;
	}

{ICONST}     { yylval.int_val = atoi(yytext); return ICONST; }
{FCONST}     { yylval.double_val = atof(yytext); return FCONST; }
{CCONST}     { yylval.char_val = yytext[0]; return CCONST; }
{STRING}     { yylval.str_val = malloc(yyleng * sizeof(char)); strcpy(yylval.str_val, yytext); return STRING; }


"\n"
[ \t\r\f]+	   /* eat up whitespace */

.		   { yyerror("Unrecognized character"); }

%%
