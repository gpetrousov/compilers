# What is a compiler?

A program which translates a program (source) from a higher level programming language into another language.

# Notes

## Chapter 1

### Why study compilers?
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

### Machine code
- Is binary instructions
- Programmed by humans explicitly in the early days of computers

### Assembly code
- Replaced the development of machine code
- Set of short instructions which translate into machine code
- The translation from assembly to machine code is done by assemblers
- Assembler: a specialised program which translates assembly code into machine code

### The speed/efficiency of higher level programming languages
The speed or efficiency of a higher level programming language, lies in the compilation of source code into assembly and the generation of efficient machine code, by the assembler. If the assemlber produces unoptimized code, the program will execute slower.
That's why some programming language are slower than others.

### How compilers are simplified today?
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

### Interpreters
- All programming languages implementations are somewhat interpreted.
Tehere are 3 forms of interpretation:
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

## Chapter 2

### VM based programming languages
1. The **compiler**, generates code for a virtual machine
2. The **interpreter**, reads the virtual machine code and emulates the execution of the virtual machine, instruction by instruction

###  Programming language semantics
- Semantics assigns computational meaning to valid strings in a programming language syntax.
- Ref: https://en.wikipedia.org/wiki/Semantics_(computer_science)#:~:text=In%20programming%20language%20theory%2C%20semantics,program%20in%20that%20specific%20language.

### How are semantics defined
1. Attribute grammars (complex)
2. Reference implementation (error prone)
3. Specify semantics in a natural language (English) (common, easiest)

### Operators and Operands
- Operators: Mathematical symbols: +-*/
- Operands: Numbers/Variables: 1,2,x,y

### Operator associativity
- Defines how operations are executed without the presence of parenthesis in a mathematical expression
Examples: 1+2*3

### Metalanguages
- languages used to describe the syntax of other higher level langauge
- BNF (Backus Naur Form)
- EBNF (Extended BNF)

### BNF (Backus Naur Form)
```
<expr> ::= <term> | <expr> + <term> | <expr> - <term>
<term> ::= <factor> | <term> * <factor> | <term> / <factor>
<factor> ::= <integer> | (<expr>)
<integer> ::= <digit> | <integer> <digit>
<digit> ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
```

### A valid programming language has
1. A defined syntax
		- is defined with the use of matalanguages
2. Defined semantics
		- defined by reference sheets

### Grammars
G = (N, T, S, P)
N: non-terminal symbols
T: terminal symbols
S: starting symbol
P: production rules (α → β)
U = N ∪ T (union of non-terminal and terminal symbols)


### Chomsky Hierarchy
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
- Ref: https://en.wikipedia.org/wiki/Chomsky_hierarchy#The_hierarchy

### Parsing
- Is one of the key tasks performed by a compiler.
- Performs **Reduction steps**
		- Source program => BNF and check syntax correctness 
		- reverse process of going from BNF into valid program expressions
		- Much harder
		- Different reduction steps can lead to a non-starting symbol
				- Algorithms have been developed to tackle this issue.
- The parsing is successful when the transformation (program => BNF) ends with the starting symbol.

### Production vs Reduction processes
- Production: BNF => Source program
- Reduction: Source program => BNF (reverse process)

### Prasing strategies
1. Top-down (start with root)
2. Bottom-up (start with leaves)

### Phases of compilation
1. Lexical analysis
		- Group lexical tokens
		- Examples of lexical tokens: numbers, identifiers, punctuation, operators, strings, etc.
		- Chomsky type 3
		- OUTPUT: groups of lexical tokens
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
