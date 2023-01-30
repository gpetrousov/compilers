all: bison flex
	gcc -o calculator calculator_scanner.c calculator_parser.c -lfl

bison:
	bison -o calculator_parser.c -d calculator.y

flex:
	flex -o calculator_scanner.c calculator.l

clean:
	rm *.c *.h
	rm calculator
