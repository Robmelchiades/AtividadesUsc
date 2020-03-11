#include<stdio.h>
#include<string.h>


typedef struct {
    float nota, altura;
    char nome[55];
} TipoAluno;

    void IniciaAluno (TipoAluno *aluno, char *n, float l, float p){
       strcpy(aluno -> nome, n);
        aluno -> altura = l;
        aluno -> nota = p;
    }
    
    void Imprime (TipoAluno aluno){
        printf("Nome: %s\n", aluno.nome);
        printf("Altura: %f\n", aluno.altura);
        printf("Nota: %f\n", aluno.nota);
    }

int main(){
    TipoAluno aluno;
    char nome[55] = "João";
    IniciaAluno(&aluno, nome, 1.8, 9);

    printf("\nAntes da movimentação \n");
    Imprime(aluno);
}