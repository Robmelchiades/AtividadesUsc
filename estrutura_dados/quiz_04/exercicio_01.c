//Exercício 1:

//================================================= Livro

typedef struct {
    int n_paginas;
    char autor[55], titulo[55];
} TipoLivro;

//inicia um tipo livro
void inicia_livro(char *a, char *b, int c);

//retorna o nome do autor
char* autor();

//retorna o título do livro
char* titulo();

//retorna o número de páginas
int numero_paginas();

//imprime todas as informações do livro
void imprime_livro();


//================================================= Círculo

typedef struct {
    float raio;
    float area;
    float perimetro;
} TipoCirculo;

//inicia um tipo circulo
void inicia_Circulo(float raio);

//retorna a área do circulo
float area();

//retorna o perimetro do circulo
float perimetro();

//retorna o raio do circulo
float raio();

//imprime todas as informações do circulo
void imprime_circulo();

//================================================= Filme

typedef struct {
    float n_horas;
    char diretor[55], titulo[55];
} TipoFilme;

//inicia um tipo filme
void inicia_filme(char *a, char *b, int c);

//retorna o nome do diretor
char* diretor();

//retorna o título do filme
char* titulo();

//retorna a duração do filme
float numero_horas();

//imprime todas as informações do filme
void imprime_filme();

//================================================= Pessoa

typedef struct {
    float altura;
    char nome[55], cpf[55];
} TipoPessoa;

//inicia um tipo pessoa
void inicia_pessoa(char *a. char *b, int c);

//retorna o nome
char* nome();

//retorna o cpf
char* cpf();

//retorna a altura
float altura();

//imprime todas as informações da pessoa
void imprime_pessoa();

//================================================= Aluno

typedef struct {
    float nota, altura;
    char nome[55]
} TipoAluno;

//inicia um tipo aluno
void inicia_aluno(char *a, float b, float c);

//retorna o nome do aluno
char* nome();

//retorna nota do aluno
float nota();

//retorna altura do aluno
float altura();

//imprime todas as informações do aluno
void imprime_aluno();

//================================================= Item de Estoque

typedef struct {
    int quantidade;
    char cod[55], nome[55];
} TipoItemEstoque;

//inicia um tipo item_estoque
void inicia_item(char *a. char *b, int c);

//retorna o nome do item
char* nome();

//retorna o codigo do item
char* codigo();

//retorna a quantidade do item
int quantidade();

//imprime todas as informações do item de Estoque
void imprime_item();

//================================================= Conta bancária

typedef struct {
    float saldo;
    char numero[55], agencia[55];
} TipoConta;

//inicia um tipo conta bancária
void inicia_conta(char *a. char *b, int c);

//retorna o numero da conta
char* numero();

//retorna a agencia da conta
char* agencia();

//retorna o saldo da conta
int saldo();

//imprime todas as informações do livro
void imprime_conta();

//================================================= 