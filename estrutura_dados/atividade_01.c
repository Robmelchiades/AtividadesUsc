#include<stdio.h>

//definição do tipo
typedef struct {
    float altura, largura;
} TipoRetangulo;

    void IniciaRetangulo (TipoRetangulo *retangulo, float a, float l){
        retangulo -> altura = a;
        retangulo -> largura = l;
    }
    void Imprime (TipoRetangulo retangulo){
        printf("Altura: %f\n", retangulo.altura);
        printf("Largura: %f\n", retangulo.largura);
    }

    void Perimetro(TipoRetangulo retangulo){
        float Perimetro = 2*(retangulo.altura + retangulo.largura);
        printf("Perimetro: %f\n", Perimetro);
    }


int main(){
    TipoRetangulo retangulo1;
    IniciaRetangulo(&retangulo1, 3, 4);

    printf("\nAntes da movimentação \n");
    Imprime(retangulo1);
    Perimetro(retangulo1);
}