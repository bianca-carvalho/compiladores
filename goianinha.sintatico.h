/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_GOIANINHA_SINTATICO_H_INCLUDED
# define YY_YY_GOIANINHA_SINTATICO_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    PROGRAMA = 258,                /* PROGRAMA  */
    CARACTERE = 259,               /* CARACTERE  */
    INTEIRO = 260,                 /* INTEIRO  */
    RETORNE = 261,                 /* RETORNE  */
    LEIA = 262,                    /* LEIA  */
    ESCREVA = 263,                 /* ESCREVA  */
    NOVA_LINHA = 264,              /* NOVA_LINHA  */
    SE = 265,                      /* SE  */
    ENTAO = 266,                   /* ENTAO  */
    SENAO = 267,                   /* SENAO  */
    ENQUANTO = 268,                /* ENQUANTO  */
    EXECUTE = 269,                 /* EXECUTE  */
    OU = 270,                      /* OU  */
    E = 271,                       /* E  */
    NEGACAO = 272,                 /* NEGACAO  */
    IGUAL = 273,                   /* IGUAL  */
    DIFERENTE = 274,               /* DIFERENTE  */
    MENOR = 275,                   /* MENOR  */
    MENOR_IGUAL = 276,             /* MENOR_IGUAL  */
    MAIOR = 277,                   /* MAIOR  */
    MAIOR_IGUAL = 278,             /* MAIOR_IGUAL  */
    ATRIBUICAO = 279,              /* ATRIBUICAO  */
    ADICAO = 280,                  /* ADICAO  */
    SUBTRACAO = 281,               /* SUBTRACAO  */
    MULTIPLICACAO = 282,           /* MULTIPLICACAO  */
    DIVISAO = 283,                 /* DIVISAO  */
    ABRE_PARENTESES = 284,         /* ABRE_PARENTESES  */
    FECHA_PARENTESES = 285,        /* FECHA_PARENTESES  */
    ABRE_CHAVES = 286,             /* ABRE_CHAVES  */
    FECHA_CHAVES = 287,            /* FECHA_CHAVES  */
    VIRGULA = 288,                 /* VIRGULA  */
    PONTO_VIRGULA = 289,           /* PONTO_VIRGULA  */
    ID = 290,                      /* ID  */
    INT_CONST = 291,               /* INT_CONST  */
    CAR_CONST = 292,               /* CAR_CONST  */
    CADEIA_CARACTERES = 293        /* CADEIA_CARACTERES  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 14 "goianinha.y"

    int intValue;
    char* strValue;

#line 107 "goianinha.sintatico.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_GOIANINHA_SINTATICO_H_INCLUDED  */
