<p align="center">

# Compilers

</p>

<p align="center">
  <img align=center width=50% src="assets/header.jpeg">
</p>

Following, are the notes I created while studying compilers primarily from 2 books:

1. [A Practical Approach to Compiler Construction](https://www.goodreads.com/en/book/show/35081146)
2. [Flex & Bison: Text Processing Tools](https://www.goodreads.com/book/show/6772167-flex-bison?ref=nav_sb_ss_1_14)

**Why study compilers?**

```
A higher level programming language, say C, is compiled into machine code by a compiler.
A compiler is written in C, a higher level programming language.
So, how was the compiler… compiled???
How does a compiler know C?
How was C created?
```

# Chapter 1

## What is a compiler?

A program which translates a program (source) from a higher level programming language into another language.

## Why study compilers?
- Many of the design aspects of compilers have application to other fields, such as:
		- language interpretation
		- parsing techniques
		- transformation of one language into another
- We haven't really cracked a way to generate machine code which can full take advantage of parallel architectures
		- That is apparent in video games where most of them cannot take full advantage of parallelisation and thus load slower
- A look into and understaning of how processors work
- Opportunity to learn programming data structures and algorithms
- Understand why a programming language is designed the way it is
- ```"one of the best ways of learning a programming language is to write a compiler for that language, preferably writing it in its own language"```

## Machine code

- Is binary instructions
- Programmed by humans explicitly in the early days of computers

## Assembly code

- Replaced the development of machine code
- Set of short instructions which translate into machine code
- The translation from assembly to machine code is done by assemblers
- Assembler: a specialised program which translates assembly code into machine code

## The speed/efficiency of higher level programming languages

The speed or efficiency of a higher level programming language, lies in the compilation of source code into assembly and the generation of efficient machine code, by the assembler. If the assemlber produces unoptimized code, the program will execute slower.
That's why some programming language are slower than others.

## How compilers are simplified today?

- Additional tools have been developed which generate parts of the compiler
		- Lexical analysers and syntax analysers (two early stages of the compilation)
				- Are language specific
				- Take as input the source language specification
				- Produce an output for the compiler
				- Reduce compiler workload
- Compiler modularization into multiple tools and/or stages, helped reduce their complexity
- Some compilers features several parts: forntend and backend
		- Frontend:
				- generates an intermediate representation (IR) language
				- The frontend can be **machine independent**
		- Intermediate representation (IR) language
				- interface between frontend and backend
		- Backend
				- consumes IR and produces machine code
				- The backend can be **source language independent**
- Frontends and Backends can be mixed and matched (since they're independent from eachother)

## Interpreters

- All programming languages implementations are somewhat interpreted.

There are 3 forms of interpretation:

		1. Source level interpretation:
				- on consecutive runs, the interpreter analyses the source program and translate each command into machine instruction and runs the instructions
				- low runtime efficiency
				- interpreter and source code in memory
		2. Intermediate code interpretation:
				- the analysis of the program is performed once and produces an intermediate form
				- on consecutive runs, the interpreter executes the intermediate form, which is faster
				- the intermediate form is a form of compilation
				- interpreter and intermediate form code in memory
		3. Target code interpretation:
				- full compilation
				- no need for an interpreter
				- on consecutive runs the hardware performs the commands directly since they're already compiled
				- initial compilation cost
				- only machine code in memory

# Chapter 2

## VM based programming languages
1. The **compiler**, generates code for a virtual machine
2. The **interpreter**, reads the virtual machine code and emulates the execution of the virtual machine, instruction by instruction

##  Programming language semantics

[Semantics assign computational meaning to valid strings in a programming language syntax.](https://en.wikipedia.org/wiki/Semantics_(computer_science)#:~:text=In%20programming%20language%20theory%2C%20semantics,program%20in%20that%20specific%20language)

## How are semantics defined

1. Attribute grammars (complex)
2. Reference implementation (error prone)
3. Specify semantics in a natural language (English) (common, easiest)

## Operators and Operands

- Operators: Mathematical symbols: `+-*/`
- Operands: Numbers/Variables: `1,2,x,y`

## Operator associativity

- Defines how operations are executed without the presence of parenthesis in a mathematical expression
Examples: `1+2*3`

## Metalanguages

- languages used to describe the syntax of other higher level langauge
- BNF (Backus Naur Form)
- EBNF (Extended BNF)

## BNF (Backus Naur Form)

```
<expr> ::= <term> | <expr> + <term> | <expr> - <term>
<term> ::= <factor> | <term> * <factor> | <term> / <factor>
<factor> ::= <integer> | (<expr>)
<integer> ::= <digit> | <integer> <digit>
<digit> ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
```

## EBNF
- Extended BNF
- Has the following aditional symbols.

| Usage            | Notation                     |
|------------------|------------------------------|
| definition       | `=`                          |
| concatenation    | `,`                          |
| termination      | `;`                          |
| alternation      | `|`                         |
| optional         | `[ ... ]`                    |
| repetition       | `{ ... }` zero or more times |
| grouping         | `( ... )`                    |
| terminal string  | `" ... "`                    |
| terminal string  | `' ... '`                    |
| comment          | `(* ... *)`                  |
| special sequence | `? ... ?`                    |
| exception        | `-`                          |
| becomes 		   | `::=`                        |

- Ref: https://en.wikipedia.org/wiki/Extended_Backus%E2%80%93Naur_form#EBNF

## A valid programming language has

1. A defined syntax
		- is defined with the use of matalanguages
2. Defined semantics
		- defined by reference sheets

## Grammars

```
G = (N, T, S, P)
N: non-terminal symbols
T: terminal symbols
S: starting symbol
P: production rules (α → β)
U = N ∪ T (union of non-terminal and terminal symbols)
```

## Chomsky Hierarchy

- Defined hierarchical classification of formal grammars
- Which provides a framework for the defnition of programming languages
- And the analysis of programs writen in these languages
- Essentially: it defines productions in the form (x → y)
- 4 types

- Chomsky type 0: __free grammar__ or an __unrestricted grammar__

		- simple productions of the form α → β
		- no constraints

- Chomsky type 1: __context-sensitive grammar__

		- αAβ → αγβ
		where α, β, γ ∈ U∗
		γ is non-null
		A is a single non-terminal symbol

- Chomsky type 2: __context free grammar__

		- productions (A → γ) correspond directly to BNF
		- if a language can be defined in BNF
				- the language is no more complex than Chomsky type 2
		- "Programming languages are generally defined using type 2 grammars
		and these grammars are used directly in the production of code for program analysis."

- Chomsky type 3: __regular grammar__

		- Used in the lexical analysis in the compiler
		- Programs in these languges can be described by FSMs (Finite State Machines)
		- Grammar productions: A → a or A → a B

- Ref: https://en.wikipedia.org/wiki/Chomsky_hierarchy#The_hierarchy

## Parsing

- Is one of the key tasks performed by a compiler.
- Performs **Reduction steps**

		- Source program => BNF and check syntax correctness 
		- reverse process of going from BNF into valid program expressions
		- Much harder
		- Different reduction steps can lead to a non-starting symbol
				- Algorithms have been developed to tackle this issue.

- The parsing is successful when the transformation (program => BNF) ends with the starting symbol.

## Production vs Reduction processes

- Production: BNF => Source program
- Reduction: Source program => BNF (reverse process)

## Prasing strategies

1. Top-down (start with root)
2. Bottom-up (start with leaves)

## Phases of compilation

1. Lexical analysis

		- Group lexical tokens
		- Examples of lexical tokens: numbers, identifiers, punctuation, operators, strings, etc.
		- Chomsky type 3
		- OUTPUT: group of lexical tokens

2. Syntax analysis

		- INPUT: groups of lexical tokens
		- Perform reduction on the lexical token group and reduce them into BNF statements
		- If reduction fails, recover with message
		- Construct the program's syntax tree
		- Chomsky type 2
		- OUTPUT: Abstract Syntax Tree

3. Semantic analysis

		- INPUT: Abstract Syntax Tree
		- Traverses the tree and inserts the following:
				- types, operator overload, scopes, etc.
		- Flatten the parse tree to produce some form of intermediate code
		- OUTPUT: Intermediate Representation

4. Machine-independent optimization (optional)

		- Applies code optimization techniques on the intermediate code
				- I.E. Loop unrolling, Function expansion, etc.
5. Code generation

		- Depending on the target generates:
				- Hardware code (Machine)
				- or  Assembly code
				- or Virtual Machine code

6. Machine-dependent optimization (optional)

		- Optimizes generated machine code

![Phases of compilation](assets/phases_of_compilation.png)

# Chapter 3

- Examine 2 approaches to designing a lexical analyser.

		1. Direct implmementation.
				- Hand crafted lexical analyser (we write the code).

		2. Syntactic specification of lexical tokens (formal path).
				- Use regexes to identify lexical tokens.

## 1. Direct implementation

### Lexical analysis

- Break the program into a sequence of tokens.
- All the lexical tokens should be definable in terms of regular expressions Chomsky type 3.
- Nested structures cannot be expressed with regexes and are left for the next stage.
- Does not check for syntax correctness, i.e. "The syntax correctness of the while loop".
- In general, comments can be ignored.
- Some whitespeces cannot be ignored (int a; // Note space after 'a')
- Source line numbers can be included in the Output.
		- Easier to debug later in case of errors or warnings.
- INPUT: Source program
- Output: Lexical tokens

Example

```C
// Input
while (i <= 100) {
tot += a[i]; /* form vector total */
i++;
}
```

```txt
// Output
while (reserved word), (, i (identifier), <=, 100 (integer constant), ), {, tot (identifier),
+=, a (identifier), [, i (identifier), ], ;, i (identifier), ++, ;, }
```

#### Enum in C

- Special kind of data type defined by the user.
- Consists of constant integrals or integers that are given names by a user.
-  The use of enum in C to name the integer values makes the entire program easy to learn.
- Enum is derrived from the mathematical constant ingegration:

```txt
d/dx f(x) = f'(x)
∫f′(x).dx = g(x)+C
And g(x)+C = f(x).
```

So, the integration ∫f′(x).dx is equal to g(x) plus a constant 'C', which can be any random constant.

Example

```C
enum flag {const1, const2, ..., constN};
// By default const1=0, const2=1, ...
// OR, custom values
enum days {
		Monday = 1,
		Tuesday = 2,
		Wednesday = 3,
		Thursday = 4,
};
```
- Ref: https://www.cuemath.com/calculus/constant-of-integration/
- Ref: https://www.programiz.com/c-programming/c-enumeration

#### typedef in C

- Used to give a type a new name.
- Or create an entirely new type, such as when using enum.

Example

```C
// Define a custom type named BYTE
typedef unsigned char BYTE;
// Use BYTE to create variables b1 and b2
BYTE b1, b2;

typedef enum {
		Monday,
		Tuesday,
		Wednesday,
		Thursday,
} days;

days day_of_week();
```
- Ref: https://www.tutorialspoint.com/cprogramming/c_typedef.htm

#### Case statement in C

```C
switch (expression)
{
    case constant1:
      // statements
      break;

    case constant2:
      // statements
      break;
    .
    .
    .
    default:
      // default statements
}
```
- Ref: https://www.programiz.com/c-programming/c-switch-case-statement

#### Union in C

- Type of data structure which can store multiple data types under a single name.

```C
...
union Data {
   int i;
   float f;
   char str[20];
};
 
int main( ) {
   union Data data;
   ...
```

#### Maximun integer value in C

- Defined in `/usr/include/limits.h`
- `#  define INT_MAX   2147483647`
- `2^31-1`
 
#### Sidenote on the lexical analyser

- Define a function lex().
- Takes no arguments.
- Returns a lextokens result.

```C
typedef enum {a,b,c,d} lextokens;
lextokens lex();
```

#### Error handling by the lexical analyser

- Ideally, you want the lexical analyser to communication the errors it finds to the syntax analyser.
- Then the syntax analyser should know how to handle these errors.
- Until the communication (lexical analyser <=> syntax analyser) is established, the first one should print the errors to `stderr`.

#### Testing (lexical analyser)

- The lexical analyser has to be sufficiently tested.
- Test are automated, a main program feeds the lexical analyser with code and expects the correct results back.
- Edge cases must be taken into account.
- Writing test for the lexical analyser can prevent later issues with syntax analyser.

---

## 2. Implementation via regexes (Tool based implementation)

### Regular expressions

- A regex is made up of symbols of the language + operators
- Operators:

		- concatenation: specified by symbol adjacency
		- alteration: specified with '|'
				- One or the other.
				- If succeded by *, then you can repeat symbols zero of multiple times
		- repetition: specified with '*'
				- applied to the left.
				- Zero or more repetitions.
		- Parenthesis: denote grouping of actions.

- Precedence:

		1. repetition
		2. concatenation
		2. alteration

```txt
• abc denotes the set of strings with the single member {abc}.
• a|b|c denotes the set {a, b, c}.
• a∗ denotes {ε, a, aa, aaa,...}. ε is the empty string.
• ab∗ denotes the infinite set {a, ab, abb, abbb,...}.
• (a|b)∗ denotes the set of strings made up of zero or more a’s or b’s.
• a(bc|d)∗e denotes the set of strings including {ae, abce, abcde, ade,...}.
```
- A specification in regex is not necessarily unique: a(b|c) == ab|ac

### Other regex symbols

- `+`: 1 or more repetitions
- `.`: represents the wildcard character (match any single character)
- `?`: zero or one occurrence of the one-character regular expression(match as little as possible): https://stackoverflow.com/questions/8575281/regex-plus-vs-star-difference
- `\\`: to match a special character
- `^`: https://stackoverflow.com/questions/16944357/carets-in-regular-expressions

		- when at the start and inside `[]` means "not the following", so `[^...]`
		- when inside [] but not at the start, it means the actual ^ character
		- Examples:
				1. [^abc] 		 -> not a, b or c
				2. [ab^cd] 		 -> a, b, ^ (character), c or d
				3. \^ 			 -> ^ character
				4. Anywhere else -> **start** of string/line.

- `[ ]`: character class which creates a matching list that will match any of the characters in the list, so [abc] == any of a, b, or c
- `$`: matches only the ending of a line, so `o$` == only words ending in o
- `{}`: Braces:

		- If braces contain one or two numbers, they indicate minumum and maximum number of times the previous pattern can match.
				Example : A{1,3} matches one to three occurences of A
		- If the braces container a name, they refer to a named pattern by that name, see `wc` program.
- `()`: Groups series of regexes into new regexes.
		Example: (01) matches exactly 01. a(bc|de) matches abc or ade.
- `&`: ???

**Resources**

- Online regex tester: https://regexr.com/
- Ref: https://users.cs.cf.ac.uk/Dave.Marshall/Internet/NEWS/regexp.html
- Online regex exercises: https://regexone.com/lesson/capturing_groups

### Finite State Machines (Finite State Automata)

- Transition diagram.

		- Each node is called a state.
		- You have a starting state.
		- You have an ending/acceptable sate (double circles).
		- Edges are labeled.

![FSM example](assets/FSM_example.png)

- Transition tables can be used to describe machines as well.

![FSM transition table](assets/FSM_transition_table.png)

- **Deterministic finite-state machines**

		- For each state there is there is at most one possible state for each input symbol.
		- "The entries in the transition table are either empty or contain a single next state."

- **Non-Deterministic finite-state machines**

		- An input symbol can trigger the machine into more than one next state simultaneously.
		- Multiple starting states.

### Lexical analyser implementation with regex

- Is a hard and time consuming process.
		- Simplify transition tables is hard.
- We use sofwrare which generates lexers by providing language specification.

### Lexical analyser constructor (tools) software

- Unix tool: lex (look man page || `info lex`)

		- Lesk ME (1975) Lex – a lexical analyser generator. AT&T Bell Laboratories, Murray Hill. Computing Science Technical Report 39

- Flex (look man page || `info flex`)

		- Levine J (2009) Flex & bison. O’Reilly Media, Sebastopol

- More out there...
- Easy to use and easy to generate lexers.
- Generate very efficient lexical analysers

### Flex

- Popular tool for generating lexers.
- INPUT:

```Flex
# file: lex.l
definitions
%%
rules
%%
user code
```
- OUTPUT (C program `lex.yy.c.`)

		- yylex()
				- Returns the next token and executes its code from the rules.
- Example
```Flex
letter			[a-zA-Z]
digit 			[0-9]
letter_or_digit [a-zA-Z0-9]
white_space 	[ \t\n]
other 			. # .: Any single character except newline
%%
{white_space}+ 			   ; # +: Repeat once or multiple times; Null statement in C (ignore)
{letter}{letter_or_digit}* return 1;
{digit}+ 				   return 2;
{other} 				   return 3;
%%
int main() {
		int lextoken;
		while (lextoken = yylex())
				printf("%d - %s\n",lextoken, yytext);
		}
int yywrap()
{
		return 1;
}
```

- The `rules` in are defined in 2 columns separated by space:

		- The left column contains regexes to identify expressions.
		- The right column contains actions to be executed when the expressions are matched.
		- The colums are dictated by space.

Example

```C
integer printf("found keyword INT");
// Looks for the "integer" string and prints "found keyword INT"
```

- Generates lexers in C and C++
- Can be connected with scripting languages with SWIG: https://en.wikipedia.org/wiki/SWIG
- `yytext`: contains the text that matched the regular expression pattern in the rule

		- When called outside of a `while` loop, it only returns a single character.
		- When it reads multiple characters, it evaluates an action multiple times.
- The `yywrap` function:

		- Used to determine whether the lexer has reached the end of a file.
		- Automatically called from yylex.
		- If yywrap returns 1: no more characters to analyze (EOF).
		- if yywrap returns 0: yywrap opened a new file for processing.
		- It's a mechanism which allows processing of multiple files.
		- If skipped, `gcc` will complain, should skip it with `%option noyywrap` at the very top of the lexer source file.

### Which one to use (tool or manual)

- There is no correct answer here.
- There are serveral ways to generate lexers, you don't need to memorize or know them all.

		- Knowing one way, can lead to understaning of the rest.
- A combination of both is also possible:

		- Write flex + custom code in the same file to recognize symbols.

# Chapter 4

## Derivation

- Is the process of going from (E)BNF to forming the tokens
- Two types:

		- **Left-most derivation**: expand from left to right (Equal to top-down reductions)
		- **Right-most derivation**: expand from right to left (Equal to buttom-up reductions)
- Choice matters, as seen in Chapter 2
- The process of parsing is equivalent to performing derivation in reverse.

		- source => BNF

## Lookahead

- Prasing becomes difficult for uncertain productions, such as P → Q|R (Which production is correct?)
- Lookahead solves that issue: used for non-simple grammars (alterations)

		- Alternative to backtracking (which is difficult to implement)
		- Looks ahead of the production to see if it produces the correct result based on what has already been produced.
		- One Lookahead is usually enough for most languages.

## Traditional parsers

- Associate a function with each non-terminal symbol.

		- It's task is to recognise an instance of that non-terminal.
		- Functions call each other according to the syntax rules of the grammar, matching terminal tokens from the input as they go.
		- This is a recursive descent parser.

## Factoring

- Is a transformation to avoid backtracking or having multiple `Lookaheads`.
- A complicated alteration is replaced with a simpler one in which one lookahead can predict the correct production.
Example

```
A → αβ|αγ # Which way is correct?

# Instead, we factor to the following where a single Lookahead is enough.
A → αA1
A1 → β|γ
```
- "There are of course grammars that are best dealt with by increasing the parser lookahead, but this comes at a cost of increased complexity."

## Types of parsers

- Top-down parsers: left-most derivation
- Bottom-up parsers; right-most derivation in reverse

		- Rarely writen by hand.
		- Usually generatd by software.
		- Are more powerful.
		- Have added complexity.

## Grammar to parser classification

- `LL(k)`: Read Left to right, Leftmost derivation, k lookaheads max.
- `LR(k)`: Read Left to right, Rightmost derivation in reverse, k lookaheads max.
- Most programming languages: `LL(1)`.
- `LL(k)` grammars are `LR(k)`
- `LR(k)`: harder to implement, more powerfull than `LL(k)`

## Bottom-up parsing - "canonical parsing"

- Rightmost derivation in reverse.
		- Given an expression: `x+y*z`
		- Produce BNF: `<expr>` 

**Example**

![Rightmost derivation in reverse](assets/rightmost_derivation_reverse.png)
- Standardized algorithms exist.
- Some lookahead is necessary.
- `The handle`:

		- The substring match with the production on the right hand side.
		- Key problem in bottom-up parsing, identification of the handle.

**Example**

In `x+y*z`, which substring to use to produce BNF, i.e. of the form `<expr>+<term>`?

## Syntax tree simplification

- Each node has to contain the data and some meta-data about its content (if statement, integer, constant, etc..).
- The form of data depends on the content.

![Syntax tree to AST](assets/syntax_tree_simplification.png)

## Further reading
- #WIP Great further reading about dynamic parsers.

# Chapter 5 (Syntax analysis)

## Generating parsers

- There are many ways of writing a parser and their complexity varies.
- You don't need to know all of them, just a single technique from which you can derrive the rest.
- Powerful tools generating bottom-up parsers: `yacc`, `bison` or `CUP`

## Simple top-down C parser

- Single lookahead stage.
- The lookahead variable ch should already contain the first token of the non-terminal being recognised.
- Lookahead consistency is a common error in this type of parsers.
This is all best illustrated by an example (from Sect. 4.2.3).

```
S → Az|z
A → x A|B
B → y
```

Here is a complete C program to recognise strings of this language.

```C
#include <stdio.h>
#include <stdlib.h>
int ch;
void error(char *msg) {
printf("Error - found character %c - %s\n",ch,msg);
exit(1);
}
void b() {
if (ch == ’y’) ch = getchar();
else error("y expected");
}
void a() {
if (ch == ’x’) {
ch = getchar();
a();
}
else b();
}
void s() {
if (ch == ’z’) ch = getchar();
else {
a();
if (ch != ’z’) error("z expected");
else ch = getchar();
}
printf("Success!\n");
}
int main(int argc, char *argv[])
{ ch = getchar();
s();
return 0;
}
```

Examples
```shell
$ ./simpletopdown
xyz
Success!
$ ./simpletopdown
xxxxyz
Success!
$ ./simpletopdown
xxxxz
Error - found character z - y expected
$ ./simpletopdown
z
Success!
```

## Shift reduce parsers

![Shift reduce parsers](assets/shift_reduce_parsers.png)

- **The choices of the parser have been done without justification or explanation.**
- Programming the choice logic is:

		- Difficult to implement by hand.
		- Relies on 2 or 3 dimensional arrays.
		- Gets complicated.
		- Simplified by parser generators: bison

- _precedence parsing_:

		- Consists of 2 indexes:
				1. index for the top of the stack.
				2. index for the next input character (shift).
		- Based on these 2 tokens, the parser can decide whether to reduce, shift or error.

### Shift-Reduce conflicts

Shift-Reduce conflicts appear when the the same expression can have more than one syntax trees.
In other words, when the parser is reading an expression, it can arrive to a point in where it can choose either shift the next token or to reduce the token at the top of the stack.

### Reduce-Reduce conflicts

Reduce-Reduce conflicts appear when the symbols on the right-hand side can be reduced to more than one token on the left-hand side.

**Example**

   ```
   A -> a
   B -> Ab
   C -> a
   ```

   We can see that `a` can either be reduced into `A` or `C`, which leads to an ambiquity.

## LALR(k)

- `LA`: Read left to right
- `LR`: Uses the revers Rightmost derivation
- `k`: lookaheads

## Parser generators

- `yacc`: LALR(1) parsers in C
- `bison`: GNU Project version of yacc

		- Can generate table-driven LALR(1) in C
		- Includes support for other bottom-up parsing methods.

- `bison` and `flex` are used in tandem.

## The `bison` parser generator

- Similar input as `flex`.
- Instead of regexes, it accepts _grammar production rules_.
- Produces parsers in `C`.
- Is combined with `flex`:
		- The generated parser calls functions from the generated lexer/scanner.
- `yyparse()`: bison generated parser function (just like `yylex()` for `flex`).
		- return 0 :Successful parse.

## Reverse Right-most derivation

```
S → Az|z
A → x A|B
B → y
```

- normal: `S → Az → x Az → xBz → xyz`.
- reverse: read the normal from right to left.

		- Start with the terminal symbol.

## bison input files (terminated by *.y)

```
definitions
%%
rules
%%
user code
```

- Similar strcture with `flex` with 2 columns: patterns and instructions

		<patterns> <instructions>

- The patterns are __grammar reduction rules__
- A colon is used to separate the **non-terminal** from its **definition**

**Example**

```C
%{
#include <stdio.h>
void yyerror(char*);
int yylex(void);
%}
%%
S:
A ’z’ { printf("S->Az, done\n"); }
| ’z’ { printf("S->z, done\n"); }
A:
’x’ A { printf("A->xA\n"); }
| B { printf("A->B\n"); }
B:
’y’ { printf("B->y\n"); }
%%
void yyerror(char *s)
{
printf("***%s\n",s);
}
int yylex() {
int ch;
ch=getchar();
while (ch==’\n’) ch=getchar();
return ch;
}
int main()
{
if (yyparse() == 0) printf("Parsing successful\n");
else printf("Parsing failure\n");
return 0;
}
```

- "Because A is not enclosed in quote marks, it is taken as a non-terminal and bison expects its definition to appear in due course"
- "In this grammar, x, y and z are all terminal symbols because they are enclosed by single quote marks."
- "And because S is the first non-terminal to be defined, it is taken as the starting symbol."
- "
Each rule consists of a pattern and a corresponding action. The idea is simple.
When the bison-generated parser runs, it matches these patterns with the input,
controlled by the parsing algorithm, and if a pattern matches, the corresponding
action is executed. Here, the actions are used for tracing the execution of the
parsing process. We will worry about more complex actions later, specifically the
generation of the parse tree.
"
- "
The final section of user code defines additional functions required by the parser.
Bison simply copies this section straight to its output. The yyerror function is
called by the parser when an error has been detected and here we just output a
message. We will tackle the problem of error reporting and recovery later in this
chapter. The yylex function is the lexical analyser. Here, it gets the next character
from the input, ignoring newline characters. Although the original BNF grammar
says nothing about ignoring newlines they are ignored here to result in a slightly
cleaner user interface, removing the potential confusion caused by the need for a
newline to send an input buffer to the running program when running interactively.
Finally the main function is defined. This calls the yyparse function which is
the bison-generated parser. If yyparse returns the value zero, the parse has been
successful.
"
- `yylex()` is hand-written, should be generated by `flex`


## Shift and Reduce operations

- A shift pushes the current symbol from the input onto the stack.
- A reduce matches the right hand side of a rule of the grammar against the top of the stack and replaces it by the left-hand side.
- If we have to make a decision between shift and reduce this is called a shift-reduce conflict.

## Ambiquity problems with parsers

- Can occur when both `reduce/reduce` and `shift/reduce` are possible.
- "Can occure when two or more rules can be applied to perform a reducion on the same input sequence."
- Solution: Grammar modification
- Sometimes difficult to understand from `bison` error outputs.


## Bison calculator example

**Grammar definitoin**

```
<calculation> :: = <expr> \n
<expr> :: = <term> |<expr> + <term> | <expr> - <term>
<term> :: = <factor> | <term> * <factor> | <term> / <factor>
<factor> :: = CONSTANT | (<expr>)
```

```C
%{
#include <stdio.h>
#include <ctype.h>
void yyerror(char*);
int yylex(void);
int ival;
%}
%token CONSTANT
%%
calculation:
expr ’\n’ { printf("%d\n", $1); }
expr:
term { $$ = $1; }
| expr ’+’ term { $$ = $1 + $3; }
| expr ’-’ term { $$ = $1 - $3; }
term:
factor { $$ = $1; }
| term ’*’ factor { $$ = $1 * $3; }
| term ’/’ factor { $$ = $1 / $3; }
factor:
CONSTANT { $$ = ival; }
| ’(’ expr ’)’ { $$ = $2; }
%%
void yyerror(char *s)
{
printf("***%s\n",s);
}
int yylex() {
int ch;
ch=getchar();
while (ch==’ ’) ch=getchar();
if (isdigit(ch)) {
ival=0;
while (isdigit(ch)) {
ival=ival*10+(int)ch-(int)’0’; /* ignore overflow */
ch=getchar();
}
ungetc(ch,stdin);
return CONSTANT;
}
else return ch;
}
int main()
{
return yyparse();
}
```

- `$$`: the result
- `$1`: left token
- `$2`: middle token | constant
- `$3`:  right token
- `ival`: holds the value of the calculation
- `CONSTANT`: used to recognize a constant (flex)

## Hand writen or Generated compiler Front-end

- There is no perfect option here.
- It depends on the use case and the requirements of the language.

## Implementation of compiler frontend (`lexer+parser`) for DL

See [DL_compiler_frontend.md](file://DL_compiler_frontend.md)

## How to pracrise

- Checkout the grammar of known languages and try to implement it.

		- The C programming language, see KR Book.
- Checkout `Pyparsing`: https://pypi.org/project/pyparsing/

		- https://en.wikipedia.org/wiki/Parsing_expression_grammar

# Chapter 6 (Semantic analysis & Code generation)

## Semantic analysis

- Concerned with type checking.
- Type casting.
- Usually, static typing is more helpful in compiler design.
- Uses the symbol table to record types of variables and track complex/user defined types.

example: `struct, typedef, union`

```C
typedef struct tnode {
int asttype;
int astdata1,astdata2;
astptr p1,p2,p3;
} astnode;

union utype {
char xch;
int xint;
float xfloat;
} uval;
```

- Updates/Annotates the syntax tree by adding types to its nodes (`recursive post-order traversal`).

		- A node's type is derived from the types of its children.

Example: `expression: expression ’+’ term { $$ = $1 + $3; }`

![Semantic tree annotation](assets/semantic_tree_annotation.png)

- Deals with variable scope:

		- Using a stack.
		- A stack pointer points to local variables within a context.
		- Once out of a context, we the stack pointer is restored to the outter context.

![Stack pointer for scope](assets/function_scoping.png)
		- Global variables are access via a different pointer (`gp`).

## 2D Arrays in C

Defined as arr[i][j] where:

		- `i` is the row
		- `j` is the column

```C
int arr[3][4];
```

![2D array in C](assets/2d_array_C.png)

Any element (e) is accessible via its memory address:

`addr(e) = (i*4 + j) * size_of_int`

## Attribute grammar

- Complements the Chomsky type 2 grammer (free context).
- Describes the types of the nodes (**semantic information**) in the AST (Abstract Syntax Tree).
- Semantic informaiton is stored in attributes associated with terminal and non-terminal symbols.

## Intermediate Code (`IR`)

- Interface between the frontend and backend of a compiler.
- Multiple IRs can be used to generate machine code.
- "It should not be regarded as an interface with which the user of the
compiler is particularly concerned, but ensuring that there is a way for the compiler
writer or interested user to inspect a human-readable representation of the IR is
important."
- Should be easily translatable into machine code.
- Should permit aggressive code optimization.
- Graph based IRs and Linear based IRs.

		- Each type has its tradeoffs.
		- There is no standard.

## Linear IRs

- Is regarded as machine code for a virtual machine.
- We can use higher level programming languages (i.e. C or Rust) as IRs.
		
		- Generated C IR.
		- Compile the C IR using GCC and produce machine code.

## Traditional IRs

- Implemented in hte early days of compilers.
- Targeted stack-based hardware.
- Don't work well with the powerful optimization algorithms today.
- Example is JVM.

## Non-stacked IRs (modern IRs)

- More modern and powerful.
- Linear IRs, container an operator, up to 2 arguments and a result.
- Are more popular.
- Representation in a 3 address code:

Example
```
x = y*3 + z;
is
t1 = y ∗ 3
x = t1 + z
```
- **There are similarities in RISC commands and 3-address code instructions.**

## Graph based IRs

- Optimization is difficult.
- Common sub-expressions in the AST.
- An AST becomes a i(Directed Acyclic Graph) DAG.

Example

![AST to DAG in Graph based IRs](assets/AST_to_DAG.png)

## Control Flow Graphs (`CFG`)

- Is a directed graph.
- Nodes represent instructions.
- Edges represent possible flows.


## Data Dependence Graphs (`DDG`)

- Show the control flow of a program.

Example

```C
x = a + b;
y = a + 2;
z = x * b;
```

- Here the value of `z` depends on the vlaue of `x`.
- The operation of `x` must be preceded.
- So, in the DDG, the node for `x` is connected with the node for `z`
- The node for `z` is independent, that's why this representation is complementary and not complete.

## Three-Address code IR

- Local variables: v0,v1,v2,..vn
- Global variables: vg0,vg1,vg2,..vgn
- Registers: r0,r2,r3,..,rn
- None of the instructions can use more than three addresses.
- Instructions:

		- Assignments with two arguments and a destination (a = b op c), with a single argument for a unary operator and a destination (a = op b) and simple copy assignments (a = b).
		- Unconditional jumps (goto label).
		- Conditional jumps (if a relop b goto label).
		- Array access (a = x[i] and x[i] = a).
		- Function call (call function, and arguments are passed by preceding the call with
		an appropriate number of param instructions of the form param arg).
		- Function return (return).
		- Input and output (read a and write a).

**Example**

![DL to Three-address IR](assets/DL_to_three-address-IR.png)

### Practical considerations for three-address code IR

- Checkout the dragon book for three-address IRs.

### How we translate a tree-based representation to a three-address code

- There's no definitive way to create an IR.
- An example could be a function, named `cg()` which traverses the tree and generates IR.
- The decission on what to generated is performed with a lengthy `switch` statement.

**Example**

```C
typedef enum {
R_REG, R_GLOBAL, R_LOCAL, R_CONST, R_NONE} regtags;
/* r5, vg5, vl5, 5, nothing returned */

/* Structure returned by the cg function */
typedef struct regstruct {
		regtags regtype; /* R_REG, R_GLOBAL, R_LOCAL, R_CONST, R_NONE */
int regvalue; /* which register or integer value of constant */
} a3token;

a3token cg(astptr p) {
		int nodetype;
		a3token noresult = {R_NONE, -1};
		astptr left,right;
		if (p==NULL) return noresult;
		nodetype = p->asttype;
		switch (nodetype) {
				.
				.
				.
				case N_PLUS:
				case N_MINUS:
				case N_MUL:
				case N_DIV:
						left=p->p1;
						right=p->p2;
						t=genreg();
						t2=cg(left);
						t3=cg(right);
						opreg(t);
						printf("="); opreg(t2); outop(nodetype); opreg(t3); // CODEGEN
						printf("\n");
						return t;
						/*
						outop():  Output the arithmetic instruction for the node.
						opreg():  Outputs an argument for the machine instruction, either a temporary register, a register storing
								     a variable or an integer constant.
						genreg(): Returns the identity (as an a3token) of the next unused temporary register.
					    */
				case N_IF:
				case N_IF:
						l1=genlab();
						cnode=p->p1; /* point to the cond node */
						t2=cg(cnode->p1); t3=cg(cnode->p2);
						printf("if ("); opreg(t2); invcondition(cnode); opreg(t3); // CODEGEN
						printf(") goto l%d\n",l1); /* jump to else part or end of statement*/
						t=cg(p->p2); /* cg then part */
						if (p->p3 != NULL) { /* else present */
								l2=genlab();
								printf("goto l%d\n",l2);
								printf("l%d:\n",l1);
								t=cg(p->p3); /* cg else part */
								printf("l%d:\n",l2);
						}
						else /* no else present */
						printf("l%d:\n",l1);
						return noresult;
						/*
						invcondition():  inverts the conditions to make them work with goto expressions
						*/
				case N_WHILE:
						l1=genlab();
						l2=genlab();
						cnode=p->p1; /* point to the cond node */
						t2=cg(cnode->p1); t3=cg(cnode->p2);
						printf("l%d:\nif (",l1); opreg(t2);
						invcondition(cnode); opreg(t3);
						printf(") goto l%d\n",l2); /* jump out of while */
						t=cg(p->p2); /* cg do part */
						printf("goto l%d\n",l1);
						printf("l%d:\n",l2);
						return noresult;
		}
}
```

Example using above code for the expression `1*2+3+4` will generated the following three-address-code.

```C
r3 = 1 * 2
r2 = r3 + 3
r1 = r2 + 4
```

Example using above code for the expression `if (a+b > a*b) c = 1 else c = 2` will generated the following three-address-code.

```C
r1 = vg0 + vg1
r2 = vg0 * vg1
if (r1<=r2) goto l1
vg2 = 1
goto l2
l1:
vg2 = 2
l2:
```

Example using above code for the expression `while (i<=10) i = i + 1` will generated the following three-address-code.

```C
l1:
if (vg0>10) goto l2
r1 = vg0 + 1
vg0 = r1
goto l1
l2:
```

So, what this generates is which registers should store which result.

**!It's important to remember that at this point we're not conserned with optimization. We don't want to get into premature optimization. So, the IR can be as simple as necessary to achieve the goal of translation.**


# Chapter 8 (Code Generation)

- If quality code is not required, writing a code generator is fairly easy
- Target machine processor manuals should be at hand.
- Code generation happens with or without prior optimization.
- No standard way or universal solution for generating code.
- No formal techniques exists to represent information about the target machine and generate code for it.

## RISC and CISC

- Classification of processors into either reduced instruction set computers (RISC) or complex instruction set computers (CISC).
- Both types of processor are used today.

### RISC

- Simple instruction set.
- Smaller instructions.
- Each instruction runs fast because smaller commands require less CPU cycles.
- Uniform instructions.

### CISC

- Complex instructions.
- Require more CPU cycles.
- Complex addressing modes.

## VM interpreter

- Another approach towards code generation is to generate code which can be executed on a VM.
- This is an interpreter.
- The target language cna be another high level language, like C.
- The generated laguage is then compiled using an existing compiler, like `gcc`.

## Generating target machine instructions

- "The process of instruction selection forms the core of code generation."
- There are infinite ways to generate target code.
- A widely used approach is:
		- Transform the IR into a tree representation.
		- Find patters in the tree which can be re-writen into machine code instructions.
- The proceess of finding these tree patterns is called "tiling".
- One successful algorithm used for tiling is the `maximal munch` (consume the largest input possible to generate an output).

## `register spilling`

- The hardware registers are being shared and their intermediate values are stored in memory.
- Should be avoided as much as possible.
- Is time consuming (load, store, load, store,....).


## `Live Rangers`

```txt
Is the process of finding code blocks in which a single register can be used to carry values for multiple variables without overlapping.
```
- Live ranges in straight code are easy to find.
- Complex control logic make finding live rangers difficult.

**Example**

```txt
.
x = 1;   ⎤
	.	 ⎥ <= live range 1
	.	 ⎥
... = x; ⎦
```

## Graph coloring

- Algorithm used to find if we can allocate an X amount of physical registes without `spiling`.
- If that's not possible, we have to have spilling.
- If we have to have shared registers `spilled`, then, ideally we store infrequently used values in them.
- #WIP (create the graph colouring algorithm in C)

## Practical matters over registers

- Registers are a precious commodity.
- C's indirection operation can wreak havoc to register allocation.
		- `int *p; *p=3;`
		- Where is 'p' pointing to?
		- If it's pointing to a register, we also need to update that register's value.
		- If it's pointing to a memory address, we need to update that one as well.


## Automatic code generation approaches

- It's possible to create a one-off custom generator which does pattern matching against the IR and data structures derived from trees.

		- Complexity rises from the amount of patterns.
		- Usually, on-off generators, for a specific architecture, are written.

- use the peephole optimization on the IR instruction and generate machine code.

		- Each IR instruction is translated in isolation.
		- Poor machine code is produced.
		- Danger that not all input will be matched.

- Graham-Glanville approach (Use regex on the IR and replace it with machine code).

		- Use context-free grammars matchers on the IR.
		- Replace matching text with machine code.
		- Essentially, it's a parser for the IR.

- Other systems:

		1. Dynamic programming
		2. `twig`
		3. `BURS` (Bottom-Up Rewrite System)
		4. `BURG`

---

# Learnings

Things I realized after studying compilers.

## How do we target a specific architecture or device with our programming language?

In high overview,

- We need a front-end capable or prducing an IR.
- We need a backend capable or consuming the IR.
- The backend needs to generate machine code targeting our architecture.

**Example**

GCC has several front-ends: C, C++, Go see: [https://gcc.gnu.org/frontends.html](https://gcc.gnu.org/frontends.html)

GCC has several target backends: aarch64, i386, arm see: [https://gcc.gnu.org/backends.html](https://gcc.gnu.org/backends.html).

**Example**

Rust uses LLVM for code generation, see https://rustc-dev-guide.rust-lang.org/backend/codegen.html.<br>
The front-end of Rust produces the LLVM IR which is consumed by LLVM to produce targe machine code.

Particularly, Rust has multiple IRs: https://rustc-dev-guide.rust-lang.org/overview.html#intermediate-representations

ref: https://rustc-dev-guide.rust-lang.org/backend/codegen.html

## What is the LLVM project all about?

Is a reusable compiler backend.<br>
Takes input in the form of LLVM IR.<br>
Produces output for a plethora of targets.<br>

## What is clang? https://clang.llvm.org/

`clang` is a frontend (for the C language family), replacement for `GCC` which uses `LLVM` as its backend.

ref: https://clang.llvm.org/

## What about OO and functional programms?

These are a subject of their own.

## Where can I see the grammar spec for Python?

https://docs.python.org/3/reference/grammar.html

## Why Compiler infrastructure is closely related with AI and ML?

Machine Learning relies on specific operations (operations on matrixes) which are performed faster on application specific hardware, such as GPUs or TPUs.

Making a higher level programming language (HLPL) work (compiled) on this hardware is a primary concern of compiler infrastructure creation (GCC, CUDA, LLVM,...).

So

```txt
HLPL => (compiler) => MC => HW

Where
HLPL     : higher level programming language
MC       : machine code
HW 		 : Hardware
Hardware : GPU | TPU | NPU
NPU		 : Network Processing Unit
```

That is why compiler infrastructure creation is so closely correlated with AI.

## How to write a compiler in language L which compiles itself and runs on machine M?

- Developing a brand new compiler from scratch, is very tough.

However, if machine M already supports another develompent environment/compiler for another language, C.<br>
Then, we can write a compiler for L using C tools, like `flex`, `bison`, `GCC`. This compiler will be written in `C`.
Once we have a compiler for `L` in `C`. We can write a compiler for `L` in `L` using the previously developed compiler in `C`.
The last compiler, written in `L`, should also be able to compiler itself, essentially making `L` a primary language.

**Testing if a compiler can compile itself is a very strong validity test.**

## What is `dynamic class loading` in `Java`?

The Java programming language is compiled into a specific language which is ran on the JVM.<br>
The JVM, is a stack-based interpreter which receives Java bytecode and interpretes it to machine code.<br>
Because JVM reads Java byte code, that means that we can load some Java bytecode from another class on the run.<br>
That class, can be located locally or on another machine on the internet.<br>
So, the ability to load a class during runtime into the JVM is what defines `dynamic class loading` in `Java`.

## What is Just in Time `JIT` compilation?

`JIT` is the process of compiling specific pieces of a program into machine code during its execution time.<br>
The reason to use `JIT` for a specific routine is because that routine might be called several times.<br>
`JIT` compilation of a routine, should resolve in fast execution times.

# Future of developments

- Algorithms which can take advantage of parallelisation are immature.

		- People are very ingrained into thinking sequentially.

- What about compilers for quantum computers?
- Can you apply an AI program to generate or parallelise sequential alrorithms?

# Great resources

Baby Steps to a C Compiler
- https://www.wilfred.me.uk/blog/2014/08/27/baby-steps-to-a-c-compiler/
