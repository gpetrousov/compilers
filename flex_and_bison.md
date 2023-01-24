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
