/*
A lexical analyser for DL
*/

% /*Definitions*/
{
.
.
.
int lexnumval;
char lexident[MAXIDLEN+1];
%}

letter [a-z]
digit [0-9]
letter_or_digit [a-z0-9]
white_space [ \t\n]
other .

%% /*Rules*/

"==" return EQSYM;
"<=" return LESYM;
">=" return GESYM;
"!=" return NESYM;

// Symbols
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

%% /*User code*/
.
.
.
