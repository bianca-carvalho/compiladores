%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *s);
int yylex();
%}

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
    Tipo ID DeclVar ';' DeclFuncVar
    | Tipo ID DeclFunc DeclFuncVar
    | /* cadeiavazia */
;

DeclProg:
    PROGRAMA Bloco
;

DeclVar:
    ',' ID DeclVar
    | /* cadeiavazia */
;

DeclFunc:
    '(' ListaParametros ')' Bloco
;

ListaParametros:
    /* cadeiavazia */
    | ListaParametrosCont
;

ListaParametrosCont:
    Tipo ID
    | Tipo ID ',' ListaParametrosCont
;

Bloco:
    '{' ListaDeclVar ListaComando '}'
    | '{' ListaDeclVar '}'
;

ListaDeclVar:
    /* cadeiavazia */
    | Tipo ID DeclVar ';' ListaDeclVar
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
    ';'
    | Expr ';'
    | RETORNE Expr ';'
    | LEIA LValueExpr ';'
    | ESCREVA Expr ';'
    | ESCREVA "CADEIA_CARACTERES" ';'
    | NOVA_LINHA ';'
    | SE '(' Expr ')' ENTAO Comando
    | SE '(' Expr ')' ENTAO Comando SENAO Comando
    | ENQUANTO '(' Expr ')' EXECUTE Comando
    | Bloco
;

Expr:
    OrExpr
    | LValueExpr ATRIBUICAO AssignExpr
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

AssignExpr:
    ID
    | INT_CONST
    | CAR_CONST
;

LValueExpr:
    ID
;

PrimExpr:
    ID '(' ListExpr ')'
    | ID '(' ')'
    | ID
    | CAR_CONST
    | INT_CONST
    | '(' Expr ')'
;

ListExpr:
    Expr
    | ListExpr ',' Expr
;

%%

int main(int argc, char **argv) {
    yyparse();
    return 0;
}