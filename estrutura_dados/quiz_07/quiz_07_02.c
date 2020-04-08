#include<stdio.h>
#include<stdlib.h>

//definindo um tipo abstrato de dado "estrutura_Lista"
typedef struct{
    //variável que armazena a quantidade de elementos na lista
    int ultimo;
    //ponteiro para o vetor que armazenará os elementos da lista
    int *dados;
    //variável com a capacidade da lista
    int capacidade;
} estrutura_Lista;

//função de criação da lista
void criarLista(estrutura_Lista *l, int c){
    //atribui o parâmetro c à capacidade da lista
    l->capacidade = c;
    //aloca o espaço na memória para o armazenamento da lista
    l->dados = malloc(l->capacidade * sizeof(estrutura_Lista));
    //atribui o valor zero ao contador de elementos da lista
    l->ultimo = 0;
}

//função responsável por inserir um elemento ao final da lista
void insereFinal(estrutura_Lista *l, int A){
    //atribui o valor do parâmetro A após o ultimo elemento da lsita
    l->dados[l->ultimo]=A;
    //Acrescenta uma unidade no contador de elemntos da lista
    l->ultimo += 1;
}

//Função responsável por retirar um elemento de uma determinada posição
//A posição inicial passará a ter o valor 0
void RetiraPos(estrutura_Lista *l, int p){
    //instância variável auxiliar
    int Aux;
    //subtrai uma posição do ponteiro p->dados deslocando o vetor
    l->dados--;
    //laço percorre o vetor a partir da posição a ser retirada
    for(Aux=p; Aux < l->ultimo; Aux++){
        //cada posição a partir de p recebera o valor de sua subsequente
        l->dados[Aux] = l->dados[Aux+1];
    }
}
//função que insere um valor em uma determinada posição
void inserePos(estrutura_Lista *l, int p, int v){
    //subtrai uma posição do ponteiro p->dados deslocando o vetor
    l->dados--;
    //acrescenta uma unidade no número de elementos
    l->ultimo++;
    //laço para realocar os elementos anteriores à posição p
    //para completar o espaço do deslocamento
    for(int i = 0; i < p; i++){
        //cada posição anterior de p recebera o valor de sua subsequente
        l->dados[i] = l->dados[i+1];
    }
    //atribui o valor do parâmetro v na posição p
    l->dados[p] = v;

}
//função imprime todos os valores do vetor
int imprimeLista(estrutura_Lista *l){

    //laço varre todo o vetor imprimindo cada elemento
    for(int i=0; i<=l->ultimo-1; i++){
        printf("%d\t", l->dados[i]);
    }
    //pula uma linha ao final da impressão do vetor
    printf("\n");
}
//função retorna o número de elementos da lista
int retornaTamanho(estrutura_Lista *l){
    return l->ultimo;
}

int main(){
    estrutura_Lista lista1;
    criarLista(&lista1, 20);
    insereFinal(&lista1, 10);
    insereFinal(&lista1, 20);
    insereFinal(&lista1, 30);
    imprimeLista(&lista1);
    RetiraPos(&lista1, 2);
    imprimeLista(&lista1);
    inserePos(&lista1, 2, 50);
    imprimeLista(&lista1);
    printf("%d\n", lista1.dados[3]);
    printf("\n O tamanho do vetor é: %d\n", retornaTamanho(&lista1));

    free(lista1.dados)
}