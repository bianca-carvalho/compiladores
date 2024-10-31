# COMPILADORES
> Repositório para projetos da disciplina de Compiladores - UFG 2024/2

## O PROJETO

Consiste em um trabalho de 3 etapas, sendo elas:
- Analisador Léxico (concluído)
- Analisador Sintático (em progresso)
- Analisador Semantico (nao iniciado)

Os analisadores sao desenvolvidos utilizando a linguagem C e as bibliotecas:
- Flex, para gerar o analisador léxico
- Bison, para gerar o analisador sintático

> ### O ANALISADOR LÉXICO

No arquivo goianinha.l sao definidas:
- as cadeias de caracteres aceitas
- as palavras reservadas
- os operadores
- comentários, delimitados por /* */
- os erros léxicos:
1. Comentários nao terminados
2. Cadeias de caracteres com quebra de linha
3. Cadeias de caracteres nao terminadas

E esse arquivo é utilizado como entrada para que o Flex gere o analisador léxico.

> ### O ANALISADOR SINTÁTICO

No arquivo goianinha.y sao definidos:
- os tokens
- as regras da gramática

E esse arquivo é utilizado como entrada para que o Bison gere o analisador sintático.

## TODO

- **Tratar como os erros sintáticos sao exibidos**

- **Verificar a contagem de linhas para exibiçao do erro**