CC = gcc
CFLAGS = -g -Wall -ansi
LFLAGS = -lm

goianinha:    sintatico.o lexico.o
	$(CC) $(CFLAGS) $(LFLAGS) lexico.o sintatico.o -o  goianinha

sintatico.o: goianinha.sintatico.c
	$(CC) $(CFLAGS) -c goianinha.sintatico.c -o sintatico.o

goianinha.sintatico.c: goianinha.y
	bison -d -t -v --output=goianinha.sintatico.c goianinha.y 

lexico.o: goianinha.lexico.c
	$(CC) $(CFLAGS) -c goianinha.lexico.c -o lexico.o
	
goianinha.lexico.c: goianinha.l
	flex  --yylineno --outfile=goianinha.lexico.c goianinha.l 

clean:
	rm -f   goianinha*.c  *.o    goianinha

cleanObj:
	rm -f   *.o  

