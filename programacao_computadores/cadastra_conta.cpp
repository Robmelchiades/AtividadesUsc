//#include "iostream.h"
#include "conio.h"
#include "string.h"
#include "stdio.h"
main()
{ 
    //Criando a Estrutura do reistro
    struct REGISTRO
    { int num;
      char nome[35];
      float saldo;
    } conta[15]; 

    //Declaração de variáveis
    int i, op, posi, achou, num_conta;
    float saldo_cliente, menor_saldo;
    char nome_cliente[35];

    //Inicializando os saldos com o valor definido 0
    for (i=0;i<15;i++){
        conta[i].num = 0;
        strcpy(conta[i].nome,"                                   ");
        conta[i].saldo = 0;
    }

    //Início laço prncipal
    do{ 
        achou=0;
        printf("\nMenu de Opções");
        printf("\n1 - Cadastrar contas");
        printf("\n2 - Visualizar todas as contas de um determinado cliente");
        printf("\n3 - Excluir conta de menor saldo");
        printf("\n4 - Sair");
        printf("\nDigite sua opcao: ");
        scanf("%d",&op);

        if ((op < 1) || (op > 4)){
           printf("\nOpcao Invalida");
        }
        //Cadastro
        if (op == 1){ 
            achou = 0;
            printf("\nDigite o numero da conta a ser incluida: ");
	        scanf("%d",&num_conta);

            //Verifica se já existe uma conta com o mesmo número
	        for (i=0;i<15;i++){
                if (num_conta == conta[i].num){
                    achou = 1;
                }
	        }

	        if (achou == 1){
                printf("\nJá existe conta cadastrada com este numero");
            }
	        else{
                posi = -1;
		        i = 0;

                //Adiciona a conta na próxima posição vaga
		        while (i < 15){ 
                    if (conta[i].num == 0){
                        posi = i;
			            i = 15;
                    }
                    i++;
                }

                //Array de conta está cheia
		        if (posi == -1){
		            printf("\nImpossivel cadastrar novas contas");
                }

		        else{ 
                    fflush(stdin);
                    printf("\nDigite o nome do cliente: ");
			        gets(nome_cliente);
			        printf("\nDigite o saldo do cliente: ");
			        scanf("%f",&saldo_cliente);
			        conta[posi].num = num_conta;
			        strcpy(conta[posi].nome,nome_cliente);
			        conta[posi].saldo = saldo_cliente;
			        printf("\nConta cadastrada com sucesso");
		        }
		    }
	        getch();
	    }

        //Buscar uma conta pelo nome
        if (op == 2){ 
            fflush(stdin);
            printf("\nDigite o nome do cliente a ser consultado: ");
	        gets(nome_cliente);
	        achou = 0;
	        for (i=0;i<15;i++){
                //Compara String Para encontrar o nome do cliete 
                if (stricmp(conta[i].nome,nome_cliente) == 0){
                    printf("\nNumero conta: %d - Saldo: %f",conta[i].num,conta[i].saldo);
		            achou = 1;
                }
            }
	        if (achou == 0){
		        printf("\nNao existe conta cadastrada para este cliente");
            }

	     getch();
	    }
        //Excluir conta de menor saldo
        if (op == 3){
            fflush(stdin);
            i = 0;
	        achou = 0;
	        while (i < 15){
                
                /*Encontra a conta de menor saldo, pega o valor da primeira e compara
                com as demais*/
                if (conta[i].num != 0){
                    if (i==0){
                        menor_saldo = conta[i].saldo;
			            posi = i;
                    }
		            else{
                        if (conta[i].saldo < menor_saldo){
                            menor_saldo = conta[i].saldo;
			                posi = i;
			            }
                    }
                    achou = 1;
		        }
		        i++;
	        }

	        if (achou == 0){
                printf("\nNenhuma conta foi cadastrada");
            }
	        else{
                for (i=posi;i<14;i++){
                    conta[i] = conta[i+1];
		        }
		        conta[i].num = 0;
		        strcpy(conta[i].nome,"\0");
		        conta[i].saldo = 0;
		        printf("\nconta excluida com sucesso");
            }
	       getch();
	    }
    } while (op!=4);
}
