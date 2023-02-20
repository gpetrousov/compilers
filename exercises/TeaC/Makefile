all: bison flex

bison:
	bison -d -v teac.y

flex:
	flex teac.l
	gcc -o teac lex.yy.c teac.tab.c

clean:
	-rm teac
	-rm lex.yy.c
	-rm teac.tab.c
	-rm teac.tab.h
