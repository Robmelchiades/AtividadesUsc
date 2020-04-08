#include <stdio.h>
#include <stdlib.h>

int main(){


    int *t1, *t2;
   
    t1 = malloc(50 * sizeof(double));
    t2 = t1;
    int n = sizeof(t2);
    int teste = 50*sizeof(double);
    
    for(int i =0; i<103; i++){
        t2[i] = i*i;
    }

    for(int i =0; i<103; i++){
        printf("%d ", t2[i]);
    }
    printf("\n%d\n", t1);
    printf("%d\n", n);
    printf("%d\n", teste);
    printf("%d\n", sizeof(t1));
    printf("\n");
    free(t1);
}