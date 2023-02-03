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

- With `%prec`, we can define precedence and associativity in the rule. See Using Precedence and Associativity to Resolve Conflicts

---

# References

- https://github.com/drifter1/compiler#syntax-analysis
- https://www.goodreads.com/en/book/show/6772167
