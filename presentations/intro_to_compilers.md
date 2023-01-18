This is an outline of a potential presentation I created after having read `A Practical Approach to Compiler Construction - Des Watson`.

# 1. What is a compiler? - 5'

A black box which makes my code run.

### 1.1 Which compilers do you know?
```text
C
C++
Go
Rust
```
Is `javac` a compiler?

### 1.2 How a compiler works?
---

# 2. The buildings blocks of a compiler. - 15'-20'
---

```txt
A compiler consists of the frontend and the backend.
The 2 parts interface with eacho ther through an Intermedia Representation.
```

## 2.1 frontend
```txt
The complexity of the frontend dictated its segmentation into the following parts.
```
### 2.1.1 lexical analyser
Recognise tokens based on regexes.

### 2.1.2 syntax analyser

### 2.1.3 semantic analyser
Do the recognised tokens adhere to the syntax rules of the language?

## 2.2 Intermediate representation (IR, AST, Semantic context tree)
Interface between the frontend and backend.

## 2.3 backend

```txt
The compiler backend is concerned with the following:
```

### 2.2.1 optimisation (memory, power, parallelisation)
### 2.2.2 code generation (machine dependent)

# 3. How are compilers built today? - 10'
---
## 3.1 Hand written frontends.

## 3.2 Machine written frontends.
### 3.2.1 `yacc`
### 3.2.2 `flex`
### 3.2.3 `bison`

## 3.3 Hand written backends.

## 3.4 Machine written backends.
### 3.4.1 LLVM (clang and LLVMIR)
### 3.4.2 GCC (C family, Go, Ada)

---

Estimated Presentation Time (EPA): 30'-40'<br>
QnA time: 10'

# Additional topics & food for thought

### Difference between a compiler and interpreter?
### What to study next?
### How compiler development plays a role in ML? - 5'
```txt
Machine Learning (ML) is a hot topic these days.
How compiler design and implementation relates with ML and why its critical for further advancements in the field?
```
### Compilers for quantum computing.
### Compilers for bio computing.
### How to parallelise instructions to take advantage of multicore systems?
### How to think in parallel instead of sequentially when designing algorithms?
