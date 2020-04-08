#include<stdio.h>

int main(){

    int qtd = 50;
    int valores[50];
    int cont = 175;
    int soma = 0;

    for(int i = 0; i<qtd;i++){
        valores[i] = cont;
        cont++;
    }

    for(int i = 0; i<qtd;i++){


        if((valores[i] % 2 != 0 && (valores[i] <= 200) && (valores[i] >= 100))){
            soma = soma + valores[i];
            printf("%d\n",valores[i]);
        }
    }

    printf(" A soma dos números ímpares é: %d\n", soma);
}