#include<stdio.h>

int main(){


    int vet[20], min, max;

    for(int i=0;i<20;i++){

        scanf("%d", &vet[i]);
    }

    min = vet[0];
    max = vet[0];

    for(int i=1;i<20;i++){

        if(vet[i]<min){
            min =vet[i];
        }

        if(vet[i]>max){
            max =vet[i];
        }
    }

    printf("O número minimo é %d, o npumero mázimo é %d", min, max);
}