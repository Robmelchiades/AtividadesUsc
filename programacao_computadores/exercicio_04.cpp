#include<stdio.h>
#include<conio.h>
#include<stdlib.h>
#include<ctype.h>
#include<locale.h>


main (){
    
    setlocale(LC_ALL, "Portuguese_Brasil");
    float vluint = 0, desconto = 0, vlrvenda = 0;
    int quant = 0;
    char descricao[50], resp='S';


    while(resp == 'S'){
        system("cls");
        printf("\n Entre com a descrição do produto: ");
        gets(descricao);
        //scanf("%s",&descricao);

        fflush(stdin);

        printf("\nEntre com a quantidade: ");
        scanf("%d",&quant);

        printf("\nEntre com o valor unitário: ");
        scanf("%f",&vluint);

        vlrvenda = (quant * vluint);

        if(vlrvenda >= 1000){
            desconto = vlrvenda * 0.10;

        }else
        {
            desconto = vlrvenda * 0.05;
        }

        printf("\nO valor final com desconto é: R$%.2f ",(vlrvenda-desconto));
        fflush(stdin);
        printf("\nDeseja continuar (S/N)?:");
        resp = toupper(getche());
        //getche com 'e' mostra o caractere digitado
        
    }
}