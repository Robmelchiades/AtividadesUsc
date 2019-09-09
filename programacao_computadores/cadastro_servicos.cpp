#include<stdio.h>
#include<iostream>
#include<conio.h>
#include<stdlib.h>
#include<ctype.h>
#include<locale.h>
#include<string>
#include<map>
#include <iterator>

#define MAXLETRAS 11

using namespace std;

int solicita_dia(){
    fflush(stdin);
    int dia = 0;
    printf("Informe o dia do mes em que o serviço foi exeultado:");
    scanf("%d", &dia);

    if(dia < 1 || dia >30){
        printf("Entrada de dia Inválida");
        dia = -1;
    }
    return dia;
}


main(){

    setlocale(LC_ALL, "Portuguese_Brasil");
    //no terminal: chcp 65001

    //Criando a Estrutura do reistro
    struct SERVICOS{
        int codServico;
        string descricao;
    }servicos[4];

    struct TiposServico{
        int numServico;
        int codServico;
        int codCliente;
        float valorServico;
    } mes[30][3];

    int op=0, i, j, codServico, numServico, codCliente, dia, vaga, pos, achou, temp;
    float valor, valorMin, valorMax;
    map<int, string> servicosMap;
    string descricao;

    for(i=0;i<4;i++){
        servicos[i].codServico = 0;
    }
    
    for(i=0;i<30;i++){
        for(j=0;j<3;j++){
            mes[i][j].codServico = 0;
        }
    }



    while(op != 6){

        printf("\nMenu de Opções");
        printf("\n1 - Cadastrar os tipos de serviços");
        printf("\n2 - Cadastrar os serviços prestados");
        printf("\n3 - Mostrar os serviços prestados em determinado dia");
        printf("\n4 - Mostrar os serviços prestados dentro de um intervalo de valor");
        printf("\n5 - Mostrar um relatório geral (separado por dia, que exiba, inclusive a descrição do tipo de serviço)");
        printf("\n6 - Finalizar");
        printf("\nDigite sua opcao: ");
        scanf("%d",&op);

        switch (op)
        {
        case 1:

            achou = 0;
            pos = 0;
            for(i = 0; i<4; i++){
                if(servicos[i].codServico == 0){
                    achou = 1;
                    pos = i;
                }              
            }

            if(achou == 0){
               printf("\nTodos os Serviços já foram cadastrados: "); 
               getch();
               break;
            }
            fflush(stdin);
            printf("\nEntre com o Código do Serviço: ");
            scanf("%d", &codServico);
            fflush(stdin);
            printf("\nEntre com a Descrição do Serviço: ");
            getline(cin, descricao); 

            servicos[pos].codServico = codServico;
            servicos[pos].descricao = descricao;
            servicosMap.insert(pair<int,string>(codServico,descricao));

            break;
        
        case 2:
            dia = solicita_dia();

            if(dia == -1){
                printf("Entrada de dia Inválida");
                break;
            }

            vaga = 0;
            pos = 0;

            //Verigfica se existe vaga para um novo servço no dia
            for(i=0;i<3;i++){
                if(mes[dia][i].codServico == 0){
                    vaga = 1;
                    pos = i;
                    break;
                }
            }

            if(vaga == 0){
                printf("Não é possível acrescentar um novo serviço no dia");
                break;
            }

            fflush(stdin);
            printf("Informe número do serviço prestado: ");
            scanf("%d", &numServico);
            printf("Informe o Valor do serviço prestado: ");
            scanf("%f", &valor);
            printf("Informe o código do serviço prestado: ");
            scanf("%d", &codServico);
            printf("Informe o código do cliente: ");
            scanf("%d", &codCliente);

            achou = 0;
            for(i=0;i<4;i++){
                //servicos[i].codServico == codServico
                auto it = servicosMap.find(codServico);
                if(it != servicosMap.end()){
                    achou = 1;
                }
            }

            if (achou == 0){
                printf("Favor cadastrar o tipo de serviço antes de usa-lo");
                break;
            }

            mes[dia][pos].numServico = numServico;
            mes[dia][pos].valorServico = valor;
            mes[dia][pos].codServico = codServico;
            mes[dia][pos].codCliente = codCliente;

            break;

        case 3:

           dia = solicita_dia();
            if(dia == -1){
                printf("Entrada de dia Inválida");
                break;
            }

            achou = 0;
            printf("\nNo dia %d foram realizados os seguintes serviços: \n", dia);

            for(i = 0; i<3; i++){
                
                if(i==0 && mes[dia][i].numServico == 0){
                    printf("\nNesse dia não foram realizados serviços");
                    getch();
                    break;
                }
                
                if(mes[dia][i].codServico != 0){
                    int count = i;
                    cout << count << " - " << servicosMap[mes[dia][i].codServico] << "\n" << endl;
                }

            }
            getch();
            break;
        case 4:
        
            fflush(stdin);
            printf("\nInforme o valor Mínimo");
            scanf("%f", &valorMin);
            printf("\nInforme o valor Máximo");
            scanf("%f", &valorMax);
            break;

            for(i=0; i<30;i++){
                for(j=0;j<3;i++){
                    if(mes[i][j].valorServico > valorMin && mes[i][j].valorServico < valorMax){
                        cout<< "\n"<<"Dia "<< i+1 <<" - "<<mes[i][j].numServico <<" - " << servicosMap[mes[i][j].codServico] << " - " << "R$ "<< mes[i][j].valorServico << endl;
                    }

                }
            }
        
        case 5:
            for(i=0;i<30;i++){
                if(mes[i][0].codServico =! 0){
                    cout << "\nDia "<< i<<"\n" << endl;
                    printf("%*s", -MAXLETRAS, "Nº do serviço");
                    printf("%*s", -MAXLETRAS, "Valor do serviço");
                    printf("%*s", -MAXLETRAS, "Código do serviço");
                    printf("%*s", -MAXLETRAS, "Descrição");
                    printf("%*s", -MAXLETRAS, "Código do cliente");
                    for(j=0;j<3;j++){
                        if(mes[i][j].codServico =! 0){
                            cout << "\n"<< endl;
                            printf("%d", -MAXLETRAS, mes[i][j].numServico);
                            printf("%.2f", -MAXLETRAS, mes[i][j].valorServico);
                            printf("%d", -MAXLETRAS, mes[i][j].codServico);
                            printf("%s", -MAXLETRAS, servicosMap[mes[i][j].codServico]);
                            printf("%d", -MAXLETRAS, mes[i][j].codCliente);
                        }
                    }
                }
            }
            getch();
            break;
        case 6:
            printf("Sistema finalizado");

        default:
            printf("Opção Inválida");
            break;
        }
        system("cls");

    }
    
}   
