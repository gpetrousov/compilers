# Flex and Bison
Most of these notes were taken by reading the book Flex and Bison by John Levine. All the sources are mentioned in the References section.

---

# Generic

When creating `flex` files we need to define the main function which calls `yylex()` and `yywrap()` which is used to indcate the end of a file stream or the beginning of another. If we don't define those, we'll get an error when running `gcc` on the generated scanners. Alternatively, we can use teh `-lfl` flag on `gcc` which adds the missing code automatically. So,

```shell
flex:
        flex calculator.l

alt: flex
        gcc -lfl lex.yy.c
```

The `syntax analyser` calls the `scanner` to get the next token. So, there's a continuous communication between the two.

`tokens` are the symbols that we want the lexer to return to the parser.

On returns from the scanner. Here, when the `return` is encountered, `yylex()` returns immediately. When there's no `return`, scannign resumes immediately.

```flex
"+" { return ADD; }
[0-9]+ { return NUMBER; }
[ \t] { /* ignore whitespace */ }
```

The symbols `%token` in `bison` are the names of the symbols that are tokens in the parser.

In `bison`'s rules section, each line is a symbol and `$$` is the value of that symbol.

By **default** `token`s in `bison` are defined in `*.tab.h` file and their values start from 258 to avoid collisions.

It's possible to use `flex` + `bison` for the frontend and use `LLVM` for the backend.
To achieve that, you need to generate the IR that LLVM accepts.
To generate the correct IR, you need to create define and create the nodes of the AST and instruct `bison` on how to build it.
Example: https://github.com/lsegal/my_toy_compiler

When defining rules: Small letters for the non-terminals and caps for the terminals.

## Ambiguous patterns in Flex

- if keywords precede patterns, keywords are matched first
- between keywords, longest ones are preferred

```C
"+" { return ADD; }
"=" { return ASSIGN; }
"+=" { return ASSIGNADD; }
"if" { return KEYWORDIF; }
"else" { return KEYWORDELSE; }
[a-zA-Z_][a-zA-Z0-9_]* { return IDENTIFIER; }
```

Symbol tables store information about identifiers that occur in the (source) program. Symbol tables can be implemented using hashtables (dictionaries in Python).
In case of collisions, chaining is implemented. See, `exercises/c-tutorials/hashtables*.c`.

# Flex


## FSM states

- A state can be defined with `%x ML_COMMENT` in the definitions section
- The FSM rules are defined as `<target state>regex { rule to follow }`
```
"/*"		{ printf("Eat up comment from line %d ", lineno); BEGIN(ML_COMMENT); }
<ML_COMMENT>"*/" 	{ printf("to line %d\n", lineno); BEGIN(INITIAL); }
<ML_COMMENT>[^*\n]+		
<ML_COMMENT>"*"			
<ML_COMMENT>"\n"	{ lineno += 1; }
```
---

# Bison

- A token is defined using `%token` in the definitions section.
- With `%start` we define the starting symbol.

## Precedence and Associativity (to resolve conflicts)

- With `%left, %right, %nonassoc` etc. we define associativity.

		Associativity controls how the grammar groups expressions using the same operator or
		different operators with the same precedence. They can group from the left, from the
		right, or not at all. If `-` were left associative, the expression A-B-C would mean (A-B)-
		C, while if it were right associative, it would mean A-(B-C).

```
%left PLUS MINUS
%right MOD
%nonassoc EQUALS

OR

%left '+' '-'
%left '*' '/'
%right POW
```

- Priority (or precedence) is defined by the order that those semantic rules are placed wth. The priority is increasing downwards. So, from above, `POW` has higher priority than `*` and `/` and those have higher priority than `+` and `-`.

- With `%prec`, we can define precedence and associativity in the rule. See Using Precedence and Associativity to Resolve Conflicts.

## The following actions take place on the stack:

```
shift -> insert the next input element to the stack.
reduce -> applied to the head of the stack when the right-side of a rule has been found by replacing the right-side with the left-side.
accept and abort that tell us if the analysis was successful or not (grammar error or not)
```

## Bison solves conflicts

Bison solves conflicts with the following actions:

		shift/reduce -> use the shift rule
		reduce/reduce -> use the first reduce rule that was defined
		With bison -v we can generate a file that describes the conflicts.

## From regex to CFG in Bison

`?`: 
	- (option 1): create 2 rules one that container the part and one that does not.
	- (option 2): define new rule that will be of the form "something | nothing".

`*` and `+`: create left-recursive rules

`Example`

```
variable: ID |
    ('*')+ID |
    ID('['ICONST']')+
;

# becomes

variable: ID |
    pointer ID |
    ID array
;
pointer: pointer '*' | '*' ;
array: array '[' ICONST ']' | '[' ICONST ']' ;
```

## Defining token and rule types

Each token, returned from the lexer, can be only of one type, so we specify which type each token and each rule uses.

```
// Setting types for tokens
%token <type> token_name

// Setting types for rules
%type <type> rule_name
```

We specify the types with a `%union`.

```
%union
{
    char char_val;
	int int_val;
	double double_val;
    char* str_val;
	list_t* symtab_item; // This is the symbolic table item
}

// We define tokens as follows.
%token<int_val> CHAR INT FLOAT DOUBLE IF ELSE WHILE FOR CONTINUE BREAK VOID RETURN
...
%token<int_val> LPAREN RPAREN LBRACK RBRACK LBRACE RBRACE SEMI DOT COMMA ASSIGN REFER
%token <symtab_item> ID // An identifier is part of the symbol table.
...
%token <str_val>     STRING
```

All tokens need to have a specific type

Once we create the `%union`, we can set the various member of the variable `yylval`. So, using the union from above, we can set

```
yylval.char_val = yytext[0];
```

from the lexer.

**Ref:** https://steemit.com/utopian-io/@drifter1/writing-a-simple-compiler-on-my-own-passing-information-from-lexer-to-parser

---

# References

- https://github.com/drifter1/compiler#syntax-analysis
- https://www.goodreads.com/en/book/show/6772167
