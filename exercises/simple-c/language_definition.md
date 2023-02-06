/* Types */
CHAR -> to define char datatype
INT -> to define int datatype
FLOAT -> to define float datatype
DOUBLE -> to define double datatype
VOID -> to declare void datatype or function that doesn't return

/* Conditional statements */
IF -> for conditional statement declaration
ELSE -> else condition
ELSE IF combination

/* Loops */
WHILE -> while loop declaration
FOR -> for loop declaration

/* Other keywords */
CONTINUE -> to get to the next iteration of a loop
BREAK -> to break out of a loop
RETURN -> return to function that called (maybe even with return-value) or to the operating system

/* Operators */
ADDOP -> + or  -
MULOP -> *
DIVOP -> /
INCR -> ++ or --
OROP -> ||
NOTOP -> ! 
ANDOP -> &&
EQUOP -> == or !=
RELOP -> > or < or >= or <=

/* Other tokens */
'('   ')' -> parentheses
'['   ']' -> brackets
'{'   '}' -> bracelets
';'   '.'   ',' -> semi, dot and comma
'='   '&' -> assign and reference
(EOF) -> end of file

## Identifiers, constants and strings:

ID's start with a letter and contain character or numbers after that.
ICONST is a integer constant that can be '0' or anything that starts with a number from 1-9 and is followed by the numbers 0-9 only
FCONST is a floating point constant that can be '0' or anything that contains zero or more numbers, the character '.' and 1 or more numbers following the dot.
CCONST is any printable ASCII character in between of two ' or the special character with a '\' in front and in betwen of 2 '. So Line feed is '\n' for example. We will write the regular expression, but because the print function will be custom-made, it will actually be useless.
STRING's are printable ASCII characters in between of two ".

/* Comments */
Anything in a line that starts with '//' is a comment and will be ignored
Anything in between of '/*' and '*/' that can span through multiple lines is also a comment
