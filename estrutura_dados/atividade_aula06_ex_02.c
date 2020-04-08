#include<stdio.h>

int main(){


    int indice, valor;
    int n_linha = 5, n_coluna=4;
    int mat[n_linha][n_coluna];

    for(int i=0;i<n_linha;i++){
        for(int j=0;j<n_coluna;j++){   
            printf("Informe o valor na posição %d x %d : ", i,j);
            scanf("%d", &mat[i][j]);
        }
    }

    for(int i=0;i<n_linha;i++){
        printf("\n");
        for(int j=0;j<n_coluna;j++){   
            printf("%d", mat[i][j]);
        }
    }
    printf("\n")
}