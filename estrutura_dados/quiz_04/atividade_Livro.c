#include<stdio.h>
#include<string.h>

typedef struct {
    int n_paginas;
    char autor[55], titulo[55];
} TipoLivro;

    void IniciaLivro (TipoLivro *livro, char a[55], char b[55], int c){
        strcpy(livro -> titulo, a);
        strcpy(livro -> autor, b);
        livro -> n_paginas = c;
    }
    
    void Imprime (TipoLivro livro){
        printf("Titulo: %s\n", livro.titulo);
        printf("Autor: %s\n", livro.autor);
        printf("Nº de paginas: %d\n", livro.n_paginas);
    }

int main(){
    TipoLivro livro;
    IniciaLivro(&livro, "teste", "teste2", 200);

    printf("\nAntes da movimentação \n");
    Imprime(livro);

}
