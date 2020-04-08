#include<stdio.h>
#include<stdlib.h>

//definindo um tipo abstrato de dado "estrutura_Pilha"
typedef struct{
    //inicializando a variável topo, que indica o tamanho da pilha
    int topo;
    //inicializando o ponteiro que referenciará o vetor com os valodes da pilha
    int *dados;
    //Informa a capacidade da pilha
    int capacidade;
} estrutura_Pilha;

//Função responsável por cria a pilha
void criaPilha(estrutura_Pilha *p, int c){
    //atribui o parâmetro c ao atributo capacidade da pilha p
    p->capacidade = c;
    //Aloca um espaço na memória com base na capacidade onde será armazenada a pilha
    p->dados = malloc(p->capacidade * sizeof(estrutura_Pilha));
    //inicializa o atributo topo da pilha p com 0
    p->topo = 0;
}
//Função que empilha um elemento ao final da pilha
void empilha(estrutura_Pilha *p, int A){
    //verifica a capacidade máxima da pilha, em números de elementos
    int n_elementos = (p->capacidade * sizeof(estrutura_Pilha))/sizeof(int);
    //verifica se o número de elementos na lista é menor que sua capacidade máxima
    if (n_elementos > p->topo){
        //atribui o valor do parâmetro A no final da pilha
        p->dados[p->topo]=A;
        //Acrescenta uma unidade no controle do número de elementos da pilha
        p->topo=p->topo+1;
    }else{
        //caso o número de elementos na lista tenha chegado ao limite imprime a mensagem abaixo
        printf("Limite da pilha excedido !");
    }

}
//função que empilha elementos até completa a pilha
void empilhaLaco(estrutura_Pilha *p, int A){
    //armazena o tamanho em bytes de um tipo int em uma variável
    int tamanho = sizeof(int);
    //obtêm a capacidade máxima da pilha
    int n_elementos = (p->capacidade * sizeof(estrutura_Pilha))/tamanho;
    //laço responsável por inserir os elementos na pilha
    for(int i = p->topo; i<n_elementos; i++){
        //chama a função empilha para acrescentar o valor A ao final da pilha
        empilha(p, A);
        //imprime o tamanho da pilha ao final de cada repetição
        printf("Tamanho: %d\n", p->topo);
        //Altera o valor de A
        A++;
    } 
}
//função que remove o ultimo elemento da pilha
int desempilha (estrutura_Pilha *p){
    //verifica se a pilha não está vazia
    if(p->topo ==0){
        //se a pilha estiver vazia imprime a mensagem abaixo e retorna -1 (cod. de erro)
        printf("A pilha está vazia !");
        return -1;
    }else{
        //caso não esteja vazia subtrai uma unidade do topo, 
        //que controla a quantidade de elementos na pilha.
        //Por fim retorna o elemento que foi removido
        p->topo=p->topo-1;
        return p->dados[p->topo];
    }
}
//função responsável por imprimir o tamanho da pilha, atributo topo
void imprimeTamanho(estrutura_Pilha *p){
    printf("Tamanho: %d\n", p->topo);
}
//função responsável por imprimir o valor do ultimo elemento da pilha
void imprimeTopo(estrutura_Pilha *p){
    printf("Topo: %d\n", p->dados[p->topo - 1]);
}
int main(){
    //criação de uma variável do tipo abstrato "estrutura_Pilha"
    estrutura_Pilha pilha1;
    criaPilha(&pilha1, 17);
    empilhaLaco(&pilha1, 80);
    imprimeTamanho(&pilha1);
    desempilha(&pilha1);
    imprimeTopo(&pilha1);

    //função responsável por liberar o espaço alocado pela função malloc
    free(pilha1.dados);
}