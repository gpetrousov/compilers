flex:
	flex -o lexer.c lexer.l

bison:
	bison -d parser.y

sc:
	gcc -o sc lexer.c parser.tab.c

all: bison flex sc

clean:
	rm parser.tab.h
	rm parser.tab.c
	rm lexer.c
	rm sc
