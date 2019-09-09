#include<stdio.h>
#include<conio.h>
#include<stdlib.h>
#include<ctype.h>
#include<locale.h>

main(){
    setlocale(LC_ALL, "Portuguese_Brasil");

    struct CONTA{
        int numero;
        char titular[50];
        float saldo;
    };

    char resp = 'S';

    while( resp == 'S'){
        system("cls");
        CONTA conta;

        fflush(stdin);
        printf("\nEntre com o numero da conta: ");
        scanf("%d",&conta.numero);

        fflush(stdin);
        printf("\nEntre com o nome do titular: ");
        gets(conta.titular);

        fflush(stdin);
        printf("\nEntre com o saldo da conta: ");
        scanf("%f",&conta.saldo);

        printf("\nNúmero da conta: %d",conta.numero);
        printf("\nNome do Titular: %s",conta.titular);
        printf("\nSaldo da conta: R$%.2f",conta.saldo);

        printf("\nDeseja continuar (S/N)?:");
        resp = toupper(getche());
        
    }
}