%{
#include <stdio.h>
#include <stdlib.h>
#include "goianinha.sintatico.h"

extern int yylineno;
%}

%option noyywrap
%option noinput nounput

numero              [0-9]
letra               [a-zA-Z_]
id                  {letra}({letra}|{numero})*
intconst            {numero}+
carconst            \'(\\.|[^\\'])\'
comentario          "/*"([^*]*\*+([^/*][^*]*\*+)*)?"/"
espaco              [ \t\n\r]+
cadeiaCaracteres    \"([^\\\"\n]|\\.)*\"

%%

"programa"             { printf("Palavra reservada PROGRAMA reconhecida: '%s' na linha %d\n", yytext, yylineno); return PROGRAMA; }
"car"                  { printf("Palavra reservada CARACTERE reconhecida: '%s' na linha %d\n", yytext, yylineno); return CARACTERE; }
"int"                  { printf("Palavra reservada INTEIRO reconhecida: '%s' na linha %d\n", yytext, yylineno); return INTEIRO; }
"retorne"              { printf("Palavra reservada RETORNE reconhecida: '%s' na linha %d\n", yytext, yylineno); return RETORNE; }
"leia"                 { printf("Palavra reservada LEIA reconhecida: '%s' na linha %d\n", yytext, yylineno); return LEIA; }
"escreva"              { printf("Palavra reservada ESCREVA reconhecida: '%s' na linha %d\n", yytext, yylineno); return ESCREVA; }
"novalinha"            { printf("Palavra reservada NOVA_LINHA reconhecida: '%s' na linha %d\n", yytext, yylineno); return NOVA_LINHA; }
"se"                   { printf("Palavra reservada SE reconhecida: '%s' na linha %d\n", yytext, yylineno); return SE; }
"entao"                { printf("Palavra reservada ENTAO reconhecida: '%s' na linha %d\n", yytext, yylineno); return ENTAO; }
"senao"                { printf("Palavra reservada SENAO reconhecida: '%s' na linha %d\n", yytext, yylineno); return SENAO; }
"enquanto"             { printf("Palavra reservada ENQUANTO reconhecida: '%s' na linha %d\n", yytext, yylineno); return ENQUANTO; }
"execute"              { printf("Palavra reservada EXECUTE reconhecida: '%s' na linha %d\n", yytext, yylineno); return EXECUTE; }

"ou"                   { printf("Operador OU reconhecido: '%s' na linha %d\n", yytext, yylineno); return OU; }
"e"                    { printf("Operador E reconhecido: '%s' na linha %d\n", yytext, yylineno); return E; }
"!"                    { printf("Operador NEGACAO reconhecido: '%s' na linha %d\n", yytext, yylineno); return NEGACAO; }
"=="                   { printf("Operador IGUAL reconhecido: '%s' na linha %d\n", yytext, yylineno); return IGUAL; }
"!="                   { printf("Operador DIFERENTE reconhecido: '%s' na linha %d\n", yytext, yylineno); return DIFERENTE; }
"<="                   { printf("Operador MENOR_IGUAL reconhecido: '%s' na linha %d\n", yytext, yylineno); return MENOR_IGUAL; }
">="                   { printf("Operador MAIOR_IGUAL reconhecido: '%s' na linha %d\n", yytext, yylineno); return MAIOR_IGUAL; }
"<"                    { printf("Operador MENOR reconhecido: '%s' na linha %d\n", yytext, yylineno); return MENOR; }
">"                    { printf("Operador MAIOR reconhecido: '%s' na linha %d\n", yytext, yylineno); return MAIOR; }
"="                    { printf("Operador ATRIBUICAO reconhecido: '%s' na linha %d\n", yytext, yylineno); return ATRIBUICAO; }
"+"                    { printf("Operador ADICAO reconhecido: '%s' na linha %d\n", yytext, yylineno); return ADICAO; }
"-"                    { printf("Operador SUBTRACAO reconhecido: '%s' na linha %d\n", yytext, yylineno); return SUBTRACAO; }
"*"                    { printf("Operador MULTIPLICACAO reconhecido: '%s' na linha %d\n", yytext, yylineno); return MULTIPLICACAO; }
"/"                    { printf("Operador DIVISAO reconhecido: '%s' na linha %d\n", yytext, yylineno); return DIVISAO; }
"("                    { printf("Token ABRE_PARENTESES reconhecido: '%s' na linha %d\n", yytext, yylineno); return ABRE_PARENTESES; }
")"                    { printf("Token FECHA_PARENTESES reconhecido: '%s' na linha %d\n", yytext, yylineno); return FECHA_PARENTESES; }
","                    { printf("Operador VIRGULA reconhecido: '%s' na linha %d\n", yytext, yylineno); return VIRGULA; }
";"                    { printf("Token PONTO_VIRGULA reconhecido: '%s' na linha %d\n", yytext, yylineno); return PONTO_VIRGULA; }
"{"                    { printf("Token ABRE_CHAVES reconhecido: '%s' na linha %d\n", yytext, yylineno); return ABRE_CHAVES; }
"}"                    { printf("Token FECHA_CHAVES reconhecido: '%s' na linha %d\n", yytext, yylineno); return FECHA_CHAVES; }

{id}                   {
                            yylval.strValue = (char *)malloc(strlen(yytext) + 1);
                                if (yylval.strValue != NULL) {
                                    strcpy(yylval.strValue, yytext);
                                };
                            printf("Token ID reconhecido: '%s' na linha %d\n", yytext, yylineno);
                            return ID;
                        }
{intconst}             { yylval.intValue = atoi(yytext); printf("Token INT_CONST reconhecido: '%s' na linha %d\n", yytext, yylineno); return INT_CONST; }
{carconst}             { yylval.intValue = yytext[1]; printf("Token CAR_CONST reconhecido: '%s' na linha %d\n", yytext, yylineno); return CAR_CONST; }
{cadeiaCaracteres}     {
                            yylval.strValue = (char *)malloc(strlen(yytext) + 1);
                                if (yylval.strValue != NULL) {
                                    strcpy(yylval.strValue, yytext);
                                };
                            printf("Token CADEIA_CARACTERES reconhecido: '%s' na linha %d\n", yytext, yylineno);
                            return CADEIA_CARACTERES;
                        }

{espaco}*\n            { printf("nova linha - lexico\n"); yylineno++; }
{comentario}           { /* Ignorar comentários */ }
{espaco}               { /* Ignorar espaços em branco */ }

"/*".*                 { printf("ERRO LEXICO: COMENTARIO NAO TERMINA na linha %d\n", yylineno); exit(1); }
\"([^\\\"\n]|\\.)*     { printf("ERRO LEXICO: CADEIA DE CARACTERES NAO TERMINA na linha %d\n", yylineno); exit(1); }
.                      { printf("ERRO LEXICO: CARACTERE INVALIDO '%s' na linha %d\n", yytext, yylineno); exit(1); }

<<EOF>>                { return -1; }

%%