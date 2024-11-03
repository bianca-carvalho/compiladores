%{
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

extern int yylineno;
extern FILE *yyin;
extern char *yytext;

void yyerror(const char *s);
int yylex();
%}

%union {
    int intValue;
    char* strValue;
}

%type <strValue> ID CADEIA_CARACTERES
%type <intValue> INT_CONST CAR_CONST

/* Definição dos tokens */

%token PROGRAMA
%token CARACTERE INTEIRO RETORNE LEIA ESCREVA NOVA_LINHA
%token SE ENTAO SENAO ENQUANTO EXECUTE
%token OU E NEGACAO
%token IGUAL DIFERENTE MENOR MENOR_IGUAL MAIOR MAIOR_IGUAL
%token ATRIBUICAO ADICAO SUBTRACAO MULTIPLICACAO DIVISAO
%token ABRE_PARENTESES FECHA_PARENTESES ABRE_CHAVES FECHA_CHAVES
%token VIRGULA PONTO_VIRGULA
%token ID INT_CONST CAR_CONST CADEIA_CARACTERES

%%

/* Definição da gramática */

Programa:
    DeclFuncVar DeclProg
;

DeclFuncVar:
    Tipo ID DeclVar PONTO_VIRGULA DeclFuncVar
    | Tipo ID DeclFunc DeclFuncVar
    | /* cadeiavazia */
;

DeclProg:
    PROGRAMA Bloco
;

DeclVar:
    VIRGULA ID DeclVar
    | /* cadeiavazia */
;

DeclFunc:
    ABRE_PARENTESES ListaParametros FECHA_PARENTESES Bloco
;

ListaParametros:
    /* cadeiavazia */
    | ListaParametrosCont
;

ListaParametrosCont:
    Tipo ID
    | Tipo ID VIRGULA ListaParametrosCont
;

Bloco:
    ABRE_CHAVES ListaDeclVar ListaComando FECHA_CHAVES
    | ABRE_CHAVES ListaDeclVar FECHA_CHAVES
;

ListaDeclVar:
    /* cadeiavazia */
    | Tipo ID DeclVar PONTO_VIRGULA ListaDeclVar
;

Tipo:
    INTEIRO
    | CARACTERE
;

ListaComando:
    Comando
    | Comando ListaComando
;

Comando:
    PONTO_VIRGULA
    | Expr PONTO_VIRGULA
    | RETORNE Expr PONTO_VIRGULA
    | LEIA LValueExpr PONTO_VIRGULA
    | ESCREVA Expr PONTO_VIRGULA
    | ESCREVA CADEIA_CARACTERES PONTO_VIRGULA
    | NOVA_LINHA PONTO_VIRGULA
    | SE ABRE_PARENTESES Expr FECHA_PARENTESES ENTAO Comando
    | SE ABRE_PARENTESES Expr FECHA_PARENTESES ENTAO Comando SENAO Comando
    | ENQUANTO ABRE_PARENTESES Expr FECHA_PARENTESES EXECUTE Comando
    | Bloco
;

Expr:
    OrExpr
    | LValueExpr ATRIBUICAO Expr
;

OrExpr:
    OrExpr OU AndExpr
    | AndExpr
;

AndExpr:
    AndExpr E EqExpr
    | EqExpr
;

EqExpr:
    EqExpr IGUAL DesigExpr
    | EqExpr DIFERENTE DesigExpr
    | DesigExpr
;

DesigExpr:
    DesigExpr MENOR AddExpr
    | DesigExpr MAIOR AddExpr
    | DesigExpr MAIOR_IGUAL AddExpr
    | DesigExpr MENOR_IGUAL AddExpr
    | AddExpr
;

AddExpr:
    AddExpr ADICAO MulExpr
    | AddExpr SUBTRACAO MulExpr
    | MulExpr
;

MulExpr:
    MulExpr MULTIPLICACAO UnExpr
    | MulExpr DIVISAO UnExpr
    | UnExpr
;

UnExpr:
    SUBTRACAO PrimExpr
    | NEGACAO PrimExpr
    | PrimExpr
;

LValueExpr:
    ID
;

PrimExpr:
    ID ABRE_PARENTESES ListExpr FECHA_PARENTESES
    | ID ABRE_PARENTESES FECHA_PARENTESES
    | ID
    | CAR_CONST
    | INT_CONST
    | ABRE_PARENTESES Expr FECHA_PARENTESES
;

ListExpr:
    Expr
    | ListExpr VIRGULA Expr
;

%%

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Uso: %s <arquivo>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("Erro ao abrir o arquivo");
        return 1;
    }
    
    yyin = file;

    yyparse();

    fclose(file);
    return 0;
}

void yyerror(const char* s) {
    fprintf(stderr, "ERRO SINTÁTICO: %s próximo ao token '%s' na linha %d\n", s, yytext, yylineno);
}