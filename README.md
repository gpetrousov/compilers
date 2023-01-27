# TeaC - Teaching Compilers

`TeaC` is a language definition and a transpiler from `TeaC` to `C99`.

# TODO

- [ ] move main() from flex to bison file
- [ ] define TeaC tokens in bison
- [ ] include `*tab.h` header in flex file

- [ ] Implement the whole real positive constants rule in lexer

		```
		4.2e1
		0.420E+2
		42000.0e-3
		```

- [ ] Implement multiline comments - `ML_COMMENTS` in lexer
		- Using regex seems tricky.
		- Have to use states to separate comments.
		- https://stackoverflow.com/questions/4755956/unix-flex-regex-for-multi-line-comments
