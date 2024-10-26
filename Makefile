# Nome do executável final
TARGET = calc

# Compilador e flags
CC = gcc
CFLAGS = -Wall -g

# Arquivos fonte gerados pelo Flex e Bison
LEX_SRC = lexer.c
YACC_SRC = parser.tab.c
YACC_HEADER = parser.tab.h

# Objetos
OBJS = $(LEX_SRC:.c=.o) $(YACC_SRC:.c=.o)

# Regras principais
all: $(TARGET)

# Regra para o executável
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS) -lfl

# Regra para gerar o arquivo lexer.c com Flex
$(LEX_SRC): lexer.l $(YACC_HEADER)
	flex -o $@ $<

# Regra para gerar parser.tab.c e parser.tab.h com Bison
$(YACC_SRC) $(YACC_HEADER): parser.y
	bison -d -Wcounterexamples $<

# Regra de compilação para os arquivos .o
%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

# Limpeza dos arquivos gerados
clean:
	rm -f $(OBJS) $(LEX_SRC) $(YACC_SRC) $(YACC_HEADER) $(TARGET)
