#include<stdio.h>

int main(){

    float nota1, nota2, nota3, nota4,media;
    int continua=1;
    char digito;

    char aluno;

    for(aluno=1;aluno<=10;aluno++){
        printf("Digite as 4 notas do aluno para calcular sua média\n");
        scanf("%f" "%f" "%f" "%f", &nota1, &nota2, &nota3, &nota4 );
        media = (nota1+nota2+nota3+nota4)/4;
        printf("A média é %f \n", media);
    }

    printf("Acabou");

    return 0;
}