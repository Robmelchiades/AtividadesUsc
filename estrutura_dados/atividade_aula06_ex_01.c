#include<stdio.h>

int main(){


    int indice, valor;
    int vet[5] = {10,47,53,108,953};

    printf("Informe o Indice para a multiplicação: ");
    scanf("%d", &indice);

    valor = vet[indice-1] * 10;


    printf("O valor é %d\n", valor);
}