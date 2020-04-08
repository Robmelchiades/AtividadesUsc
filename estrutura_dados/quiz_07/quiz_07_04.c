////================================================================================================================
//ATIVIDADE PILHA


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




//================================================================================================================
//ATIVIDADE FILA



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



//=====================================================================================================
//ATIVIDADE LISTA


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