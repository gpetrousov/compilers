flex:
	flex -o lexer.c lexer.l

bison:
	bison -o parser.c -d parser.y

sc:
	gcc -o sc lexer.c parser.c

all: bison flex sc

clean:
	-rm parser.c
	-rm parser.h
	-rm lexer.c
	-rm sc
