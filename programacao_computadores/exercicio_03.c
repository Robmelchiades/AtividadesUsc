#include <stdio.h>
#include <conio.h>
#include <ctype.h>
#include <stdlib.h>
#include <locale.h>

//no terminal: chcp 65001

int main(){
    setlocale(LC_ALL, "Portuguese_Brasil");

    printf("\n Calculador área triângulo\n");
    int condicao = 1;

    while (condicao){
        float base = 0, altura = 0, area = 0;
        char caractere;

        printf("Informe o valor da Base do tiângulo em metros: ");
        scanf("%f", &base);

        printf("Informe o valor da Altura do triângulo em metros: ");
        scanf("%f", &altura);

        area = (base*altura)/2;
        printf("A área do triângulo é: %.2f",area);
        printf("\n\nDeseja relizar uma nova consulta ? (S): ");

        //Esvazia o buffer
        fflush(stdin);

        scanf("%c", &caractere);
        caractere = toupper(caractere);

        if(caractere == 'S'){
            system("cls");
            continue;
        }else{
            printf("\nAté mais\n");
            condicao = 0;
        }
        

    }

    //system("PAUSE");
    getch();
}