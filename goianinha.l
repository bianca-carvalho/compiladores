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

"programa"             { return PROGRAMA; }
"car"                  { return CARACTERE; }
"int"                  { return INTEIRO; }
"retorne"              { return RETORNE; }
"leia"                 { return LEIA; }
"escreva"              { return ESCREVA; }
"novalinha"            { return NOVA_LINHA; }
"se"                   { return SE; }
"entao"                { return ENTAO; }
"senao"                { return SENAO; }
"enquanto"             { return ENQUANTO; }
"execute"              { return EXECUTE; }

"ou"                   { return OU; }
"e"                    { return E; }
"!"                    { return NEGACAO; }
"=="                   { return IGUAL; }
"!="                   { return DIFERENTE; }
"<="                   { return MENOR_IGUAL; }
">="                   { return MAIOR_IGUAL; }
"<"                    { return MENOR; }
">"                    { return MAIOR; }
"="                    { return ATRIBUICAO; }
"+"                    { return ADICAO; }
"-"                    { return SUBTRACAO; }
"*"                    { return MULTIPLICACAO; }
"/"                    { return DIVISAO; }
"("                    { return ABRE_PARENTESES; }
")"                    { return FECHA_PARENTESES; }
","                    { return VIRGULA; }
";"                    { return PONTO_VIRGULA; }
"{"                    { return ABRE_CHAVES; }
"}"                    { return FECHA_CHAVES; }

{id}                   { yylval.strValue = strdup(yytext); return ID; }
{intconst}             { yylval.intValue = atoi(yytext); return INT_CONST; }
{carconst}             { yylval.intValue = yytext[1]; return CAR_CONST; }
{cadeiaCaracteres}     { yylval.strValue = strdup(yytext); return CADEIA_CARACTERES; }

\n                     { /* Ignorar nova linha */ }
{comentario}           { /* Ignorar comentários */ }
{espaco}               { /* Ignorar espaços em branco */ }

"/*".*                 { printf("ERRO LEXICO: COMENTARIO NAO TERMINA na linha %d\n", yylineno); exit(1); }
\"([^\\\"\n]|\\.)*     { printf("ERRO LEXICO: CADEIA DE CARACTERES NAO TERMINA na linha %d\n", yylineno); exit(1); }
.                      { printf("ERRO LEXICO: CARACTERE INVALIDO '%s' na linha %d\n", yytext, yylineno); exit(1); }

<<EOF>>                { return -1; }

%%