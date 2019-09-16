#include<stdio.h>
#include<conio.h>
#include<stdlib.h>
#include<locale.h>

main()
{
    setlocale(LC_ALL, "Portuguese_Brasil");
    FILE*cadprod;

    struct estoque
    {
        int codigo;
        char descricao[45];
        float valor;
    }prodestoque[5];
    estoque auxiliar;
    int codprod = 0, opcao = 0, quantp = 0;
    char desc_prod[45] = "\0";
    float ver_prod;

    do{
        fflush(stdin);
        system("CLS");
        printf("\n1 - Criar Arquivo");
        printf("\n2 - Incluir Produtos no Arquivo");
        printf("\n3 - Listar todos os produtos");
        printf("\n4 - Sair");

        printf("\nEntre com a opção: ");

        scanf("%d",&opcao);

        switch (opcao)
        {
        case 1:
            if((cadprod = fopen("produtos","a+"))==NULL ){
                printf("\nNão foi possível criar o arquivo");
            }else{
                printf("\nArquivo criado com sucesso! Pressione qualquer tecla...");
                //Recebe apenas um caractere, pausa
                getch();
                fclose(cadprod);
            }
            break;
        
        case 2:
            cadprod = fopen("produtos","a+");
            printf("\nDigite quantos produtos deseja inserir(1-5): ");
            scanf("%d",&quantp);
            for(int i = 0; i < quantp; i++){

                printf("\nDigite o código do produto: ");
                scanf("%d",&prodestoque[i].codigo);
                printf("\nDigite a descrição do produto: ");
                fflush(stdin);
                gets(prodestoque[i].descricao);
                printf("\nDigite o valor: ");
                fflush(stdin);
                scanf("%f",&prodestoque[i].valor);
                fwrite(&prodestoque[i],sizeof(estoque),1,cadprod);

            }
            printf("Produto Incluído com sucesso, digite qualquer tecla...");
            getch();
            fclose(cadprod);
            break;

        case 3:
            cadprod = fopen("produtos","r");
            do{
                fread(&auxiliar,sizeof(estoque),1,cadprod);
                printf("\nCodigo...:%d",auxiliar.codigo);
                printf("\nDescrição...:%d",auxiliar.codigo);
                printf("\nValor...%.2f",auxiliar.valor);
            }while(!feof(cadprod));
            printf("Produtos Listados com sucesso!");
            getch();
            fclose(cadprod);
            break;
        
        case 4:
            break;
        }
    }while(opcao != 4);

}