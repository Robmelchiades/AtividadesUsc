#include<stdio.h>
#include<conio.h>
#include<stdlib.h>
#include<locale.h>

main()
{
    setlocale(LC_ALL, "Portuguese_Brasil");
    FILE*cadprod;
    char linha [100];
    int cod_prod = 0, opcao=0;
    char desc_prod[45]="\0";
    float vlr_prod = 0;

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
            printf("\nDigite o código do produto: ");
            scanf("%d",&cod_prod);
            printf("\nDigite a descrição do produto: ");
            fflush(stdin);
            gets(desc_prod);
            printf("\nDigite o valor: ");
            fflush(stdin);
            scanf("%f",&vlr_prod);
            fprintf(cadprod,"Código do produto: %d, descrição: %s, valor: %.2f\n",cod_prod,desc_prod,vlr_prod);
            printf("Produto Incluído com sucesso, digite qualquer tecla...");
            getch();
            fclose(cadprod);
            break;

        case 3:
            cadprod = fopen("produtos","r");
            while (!feof(cadprod))
            {
                if(fgets(linha,100,cadprod) != NULL){
                    printf("%s",linha);
                }
            }
            printf("Produtos Listados com sucesso!");
            getch();
            fclose(cadprod);
            break;
        
        case 4:
            break;
        }
    }while(opcao != 4);

}