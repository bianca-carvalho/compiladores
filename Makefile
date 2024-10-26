# Nome do executável final
TARGET = goianinha

# Compilador e flags
CC = gcc
CFLAGS = -Wall -g

# Arquivos fonte gerados pelo Flex e Bison
LEX_SRC = goianinha.c
YACC_SRC = goianinha.tab.c
YACC_HEADER = goianinha.tab.h

# Objetos
OBJS = $(LEX_SRC:.c=.o) $(YACC_SRC:.c=.o)

# Regras principais
all: $(TARGET)

# Regra para o executável
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS) -lfl

# Regra para gerar o arquivo goianinha.c com Flex
$(LEX_SRC): goianinha.l $(YACC_HEADER)
	flex -o $@ $<

# Regra para gerar goianinha.tab.c e goianinha.tab.h com Bison
$(YACC_SRC) $(YACC_HEADER): goianinha.y
	bison -d -Wcounterexamples $<

# Regra de compilação para os arquivos .o
%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

# Limpeza dos arquivos gerados
clean:
	rm -f $(OBJS) $(LEX_SRC) $(YACC_SRC) $(YACC_HEADER) $(TARGET)
