%{
	#include "calculator_parser.h"
%}

%%

"+"	{ return ADD; }
"-"	{ return SUB; }
"*"	{ return MUL; }
"/"	{ return DIV; }
"|"	{ return ABS; }

"("	{ return OP; }
")"	{ return CP; }

[0-9]+	{
	yylval = atoi(yytext);
	return NUMBER;
	}

[//].*[\n] /* Comments */

"\n"	{ return EOL; }
[ \t]	{ /* Do nothing */ }
.		{ printf("Unknown character %s\n", yytext); }

%%
