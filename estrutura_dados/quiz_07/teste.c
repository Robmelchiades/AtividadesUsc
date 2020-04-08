#include<stdio.h>
#include<stdlib.h>

int main(){
    int teste[] = {1,2,3,4,5,6};
    teste++;
    for(int i=0; i<sizeof(teste)/sizeof(int);i++){
        printf("%d\n", teste[i]);
    }
}