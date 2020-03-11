#include<stdio.h>

int main(){
    int idade;

    printf("Digite sua idade: ");
    scanf("%d", &idade);

    if((idade>0) && (idade<18)){
        printf("Não possui carteira de habilitação\n");

    } else if((idade >= 18) && (idade <65)){
        printf("Renove exames a cada 5 anos\n");
    }else if(idade>=65){
        printf("Renove exames a cada 3 anos\n");
    }

    return 0;
}