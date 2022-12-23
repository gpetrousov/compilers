all: bison flex
	gcc -lfl calculator.tab.c lex.yy.c

bison:
	bison -d calculator.y

flex:
	flex calculator.l

alt: flex
	gcc -lfl calculator.tab.c lex.yy.c

clean:
	rm *.c *.h *.out

