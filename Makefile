CC = gcc
CFLAGS = -g -Wall -ansi -D_GNU_SOURCE
LFLAGS = -lm

goianinha:    sintatico.o lexico.o
	$(CC) $(CFLAGS) $(LFLAGS) lexico.o sintatico.o -o  goianinha

sintatico.o: goianinha.sintatico.c
	$(CC) $(CFLAGS) -c goianinha.sintatico.c -o sintatico.o

# main.o: main.c
# 	$(CC) $(CFLAGS) $(FLAGS) -c main.c -o main.o

goianinha.sintatico.c: goianinha.y
	bison -d -t -v -Wcounterexamples --output=goianinha.sintatico.c goianinha.y 

lexico.o: goianinha.lexico.c
	$(CC) $(CFLAGS) -c goianinha.lexico.c -o lexico.o
	
goianinha.lexico.c: goianinha.l
	flex  --yylineno --outfile=goianinha.lexico.c goianinha.l 

clean:
	rm -f   goianinha*.c  *.o    goianinha goianinha.sintatico.h goianinha.sintatico.output

cleanObj:
	rm -f   *.o  

