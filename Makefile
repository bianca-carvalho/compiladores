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
	rm -f   goianinha*.c  *.o    goianinha 

cleanObj:
	rm -f   *.o  

# Quando seu trabalho estiver pronto. No diretorio onde estão fontes digite na 
#linha de comando: make tgz
# este comando ira criar um arquivo do tipo tar zipado com extensao .tgz contendo os 
#fontes do seu programa e o Makefile.
# envie um mail com este arquivo para o professor.
tgz: 
	rm -f *.o rm goianinha *.tgz 
	tar -zcvf goianinha.tgz *
	echo "O arquivo goianinha.tgz com os fontes e Makefile foi gerado. Pode ser enviado."