#include<stdio.h>
#include<stdlib.h>

//definindo um tipo abstrato de dado "estrutura_Fila"
typedef struct{
    //variável com a capacidade da Fila
    int capacidade;
    //ponteiro para o vetor que armazenará os elementos da Fila
    int *dados;
    //variável que representa a posição do primeiro elemento da Fila
    //na medida em que os primeiros forem retirados
    int primeiro;
    //Variável que representa a posição do ultimo elemento da Fila
    //na medida em que forem acresncentados elementos ao final da Fila
    int ultimo;
    //Quantidade total de elementos na Fila
    int quantidade;
} estrutura_Fila;

//função criação da fila 
void criarFila(estrutura_Fila *f, int c){

    f->capacidade = c;
    //aloca o espaço na memória para o armazenamento da Fila
    f->dados = malloc(f->capacidade * sizeof(estrutura_Fila));
    //Define primeiro elemento como sendo 0
    f->primeiro = 0;
    //define ultimo elemento inicialmente como 1
    f->ultimo = 1;
    //inicializa quantidade em 0
    f->quantidade = 0;
}

//Insere um elemento ao final da Fila
void inserirFinal(estrutura_Fila *f, int v){
    //Caso o ultimo elemento seja igual a capacidade da Fila
    //ou ainda não exista elemnto na fila é subtraido 1 do atributo
    //ultimo
    if(f->ultimo == f->capacidade-1 || f->quantidade==0){
        f->ultimo--;
    }
    //a posição subsequente ao ultimo valor recebe o parÂmetro v
    f->dados[f->ultimo] = v;
    //o atributo ultimo é deslocado
    f->ultimo++;
    //o atributo quantidade aumenta em uma unidade
    f->quantidade++;
}

//função para remover primeiro elemento
int removerComeco(estrutura_Fila *f){
    //variável temporária armazena o valor que será removido
    int temp = f->dados[f->primeiro];
    //atributo primeiro é deslocado
    f->primeiro++;
    //atributo quantidade é reduzido
    f->quantidade--;
    //a função retorna a variável temporária
    return temp;
}

//laço varre toda a fila imprimindo os elementos
void mostrarFila(estrutura_Fila *f){
    //laço varre fila do primeiro ao ultimo elemento
    for(int cont= f->primeiro; cont < f->ultimo; cont++){
        printf("%d\t", f->dados[cont]);
    }
    printf("\n");
}

int main(){
    estrutura_Fila fila1;
    criarFila(&fila1, 20);
    inserirFinal(&fila1, 18);
    inserirFinal(&fila1, 17);
    inserirFinal(&fila1, 22);
    mostrarFila(&fila1);
    removerComeco(&fila1);
    mostrarFila(&fila1);

    //função destinada a desalocar os espaço em memória
    //alocado para a criação da fila
    free(fila1.dados);
}

