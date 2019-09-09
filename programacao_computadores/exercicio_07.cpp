#include<stdio.h>
#include<conio.h>
#include<stdlib.h>
#include<ctype.h>
#include<locale.h>
#include<iostream>

using namespace std;

main()
{
    //cout << fixed << setprecision(1);
    setlocale(LC_ALL, "Portuguese_Brasil");
    struct cliente
    { 
        int matricula;
        char nome[35];
        float p1;
        float p2;
        float media;
    } dadosAluno[5]; 

    int condicao=1;
    int i;
    char caractere;

    do{
        for(i =0; i < 5; i++){

            
            cout << "Insira o nome do aluno" << endl;
            cin >> dadosAluno[i].nome;
            cout << "Insira o número da matrícula" << endl;
            cin >> dadosAluno[i].matricula;
            cout << "Insira a nota da P1" << endl;
            cin >> dadosAluno[i].p1;
            cout << "Insira a nota da P2" << endl;
            cin >> dadosAluno[i].p2;

            dadosAluno[i].media = (dadosAluno[i].p1 + dadosAluno[i].p2) / 2;
        }

        for(i =0; i < 5; i++){

            cout << "Nome: " << dadosAluno[i].nome << endl;
            cout << "Matrícula: " << dadosAluno[i].matricula << endl;
            cout << "Média: " << dadosAluno[i].media << endl;

        }

        cout << "Deseja continuar ? (S/N)" << endl;
        cin >> caractere;
        getch();

    }while((caractere == 'S'? condicao = 1 : condicao = 0));

    return 0;
}