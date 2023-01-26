all: flex
	gcc teac.yy.c
flex:
	flex -o teac.yy.c teac.l
