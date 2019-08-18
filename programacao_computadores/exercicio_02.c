#include <stdio.h>
#include <conio.h>
#include <stdlib.h>
#include <locale.h>

//no terminal: chcp 65001

int main(){
    setlocale(LC_ALL, "Portuguese_Brasil");

    float sal=0, bonus=0, salario_final=0;

    printf("\n Entre com o valor do salário: ");
    scanf("%f",&sal);

    printf("\n Entre com o valor do bonus em porcentagem: ");
    scanf("%f",&bonus);

    bonus = bonus / 100;

    salario_final = (sal*bonus) + sal;
    printf("\n O salario reajustado é: %.2f \n",salario_final);

    //system("PAUSE");
    getch();
}