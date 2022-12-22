This is an outline of a potential presentation I created after having read `A Practical Approach to Compiler Construction - Des Watson`.

# TOC

# 1. What is a compiler? - 5'
---
# 2. Difference between a compiler and interpreter? - 5'
---
# 3. The buildings blocks of a compiler. - 10'
---
```txt
A compiler consists of the frontend and the backend.
The 2 parts interface with eacho ther through an Intermedia Representation.
```
## 3.1 frontend
```txt
The complexity of the frontend dictated its segmentation into the following parts.
```
### 3.1.1 lexical analyser
### 3.1.2 syntax analyser
### 3.1.3 semantic analyser
## 3.2 Intermediate representation (IR, AST, Semantic context tree)
## 3.3 backend

```txt
The compiler backend is concerned with the following:
```
### 3.3.1 optimisation (memory, power, parallelisation)
### 3.3.2 code generation (machine dependent)

# 4. How are compilers built today? - 10'
---
## 4.1 Hand written frontends.
## 4.2 Machine written frontends.
### 4.2.1 flex
### 4.2.2 bison
### 4.2.3 yacc
## 4.3 Hand written backends.
## 4.4 Machine written backends.
### 4.4.1 LLVM (clang and LLVMIR)
### 4.4.2 GCC (C family, Go, Ada)

# 5. What to study next? - 5'
---
- Compilers for quantum computing.
- Compilers for bio computing.
- How to parallelise instructions to take advantage of multicore systems?
- How to think in parallel instead of sequentially when designing algorithms?

# 6. How compiler development plays a role in ML? - 5'
---
```txt
Machine Learning (ML) is a hot topic these days.
How compiler design and implementation relates with ML and why its critical for further advancements in the field?
```
---

Estimated Presentation Time (EPA): 30'-40'<br>
QnA time: 10'
