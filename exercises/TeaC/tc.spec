## TC keywords

```
int real bool string true
false if then else fi
while loop pool const let
return not and or start
```

## TC Program syntax

1. variable declaration (optional)
2. function declaration (optional)
3. main function: start (always returns int)
		```
		const start <- () : int => {
			-- statements
		}
		```

## Variables syntax

- start with keyword `let`

**Example**

		```
		let i, j <- 10 : int;
		let x <- 3.5, y : real;
		let s[80] : string;
		```

## Constant syntax

- start with keyword `const`

```
const C, I, J <- 10 : int;
const message[14] <- "Hello world!\n": string;
```

## Function declaration syntax

```
const function_name <- ( parameters ) : [] return_typ => {
    (Optinal) Variable declartions
    (Optinal) Constant declartions
    Statements
    (Optional) return
}
```

**Example**

```
const f1 <- (x: real) : real => { return x * x; }
const f2 <- (s[]: string) : int => { return 100; }
const f3 <- (x: real) : [] real => { x <- 2 * x; }
```

### Function call syntax

```
function_name(expr1,...,exprn)
```

## Control statements

- optional `else`

```
if expr then stmt1 else stmt2 fi
```

## Loop

```
while expr loop stmt pool.
```
