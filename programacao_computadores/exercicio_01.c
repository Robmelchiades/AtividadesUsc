#include <stdio.h>
#include <stdlib.h>
#include <locale.h>

//no terminal: chcp 65001

int main(){
    setlocale(LC_ALL, "Portuguese_Brasil");

    printf("\n\t Isso é um teste");
    int magic;
    int palpite;
    magic = rand();
    printf("\n\t Adivinhe o número gerado: ");
    scanf("%d", &palpite);

    if(palpite==magic){
        printf("Você Acertou");
    }else{
        printf("Você errou");
    }

}