#include<stdio.h>

int main(){

    float nota1, nota2, nota3, nota4,media;
    int continua=1;
    char digito;

    while(continua){
        printf("Digite as 4 notas do aluno para calcular sua média\n");
        scanf("%f" "%f" "%f" "%f", &nota1, &nota2, &nota3, &nota4 );
        media = (nota1+nota2+nota3+nota4)/4;
        printf("A média é %f \n", media);
        printf("Continuar? (s/n): ");
        __fpurge(stdin);
        scanf("%c", &digito);
        if(digito!='s') continua=0;
    }

    return 0;
}
