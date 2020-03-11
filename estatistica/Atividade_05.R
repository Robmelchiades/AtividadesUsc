#Atividade 01

library(formattable)
library(ggplot2)


#====================================== Funções
isEmpty <- function(x) {
  return(length(x)==0)
}

retornaLimiteInf <- function(idx){
  lim.inf <- toString(df$variavel[idx])
  matches <- regmatches(lim.inf, regexpr("[[:digit:]]+", lim.inf))
  lim.inf <- as.numeric(unlist(matches))
  return(lim.inf)
  
}

calcSeparatriz <- function(sep){
  vet.sep <- vector(mode="numeric", length=0)
  for(i in 1:(sep - 1)){
    sep.classe <- (i*sum(df$fi))/sep
    
    x <- vector(mode="numeric", length=0)
    for(j in df$Fi){
      if(sep.classe < j){
        x <- append(x, j)
      }
    }
    idx.classe.sep <- match(min(x), df$Fi)
    
    sep.Fant <- df$Fi[idx.classe.sep - 1]
    if (isEmpty(sep.Fant)) {
      sep.Fant <- 0
    }
    
    sep.li <- retornaLimiteInf(idx.classe.sep)
    sep.fi <- df$fi[idx.classe.sep]
    
    sep.calc <- ((((((sum(df$fi)*i)/sep)-sep.Fant)*hi)/sep.fi)+sep.li)
    vet.sep <- append(vet.sep, sep.calc)
  }
  return(vet.sep)
}

recuperaLimites <- function(vet){
  variaveis <- vector(mode="numeric", length=0)
  for(i in vet){
    i <- toString(i)
    matches <- regmatches(i, gregexpr("[[:digit:]]+", i))
    numeros <- as.numeric(unlist(matches))
    variaveis <- append(variaveis, numeros)
  }
  return(unique(variaveis))
  
}

descobreFuncao <- function(vet, vetx, vety){
  
  valores.y <- vector(mode="numeric", length=0)
  for(i in vet){
    idx <- 0
    for(j in vetx){
      if(i < j){
        idx <- match(j,vetx)
        break
      }

    }
    xant <- vetx[idx - 1]
    xpos <- vetx[idx]
    yant <- vety[idx -1]
    ypos <- vety[idx]
    
    a <- ((ypos - yant)/(xpos - xant))
    b <- yant - (a * xant)
    
    y <- a*i + b
    
    valores.y <- append(valores.y, y)
    
  }
  return(valores.y)
}

#====================================== Criação do dataframe

#informe os valores dos intervalos
variavel <- c("[2,4[", "[4,6[", "[6,8[","[8,10[", "[10,12[", "[12,14[", "[14,16[")
#informe os valores da frequência simples
fi <- c(6,9,11,16,13,10,5)
#informe os nomes das colunas
nomes.colunas <- c("Nº de Acidentes","Nº de Dias")
#informe o valor da amplitude do intervalo
hi <- 2
variacao <- 1

xi <- (recuperaLimites(variavel) +(hi/2))[1:length(fi)]
df = data.frame(variavel, fi, xi)
rm(variavel, fi)

df <- transform(df,  fri = round((prop.table(fi)), digits = 2), Fi = cumsum(fi))
df <- transform(df, fri.percent = fri*100, fri.grau = fri*360, Fri = round(Fi / sum(df$fi), digits = 2))
df <- transform(df, Fri.percent = Fri *100, Fri.grau = Fri*360, fxi = fi * xi)

variaveis.valores <- recuperaLimites(df$variavel)
df.apresentacao <- df
names(df.apresentacao)[1] <- nomes.colunas[1]
names(df.apresentacao)[2] <- nomes.colunas[2]

parametro <- c("Somatória Frequência: ", "Nº Total de Linhas: ", "Amplitude Total: ", "Amplitude Amostral: ", "Amplitude Intervalo: " )
valores <- c(sum(df$fi), length(df$variavel), (max(variaveis.valores)-min(variaveis.valores)), 
             (max(variaveis.valores) - variacao - min(variaveis.valores)), hi)


df.infos <- data.frame(parametro, valores)
colnames(df.infos) <- c("Parâmetros", "Valores")
rm(parametro, valores, variacao)


#====================================== Calculos Medidas Estatísticas

#media
Me <- sum(df$fxi)/sum(df$fi)

#Moda
Classe.Mo <- max(df$fi)
idx.classe.Mo <- match(Classe.Mo, df$fi)



Mo.fant <- df$fi[idx.classe.Mo - 1]

if (isEmpty(Mo.fant)) {
  Mo.fant <- 0
}

Mo.fpos <- df$fi[idx.classe.Mo + 1]

if (isEmpty(Mo.fpos)) {
  Mo.fpos <- 0
}

Mo.D1 <- Classe.Mo - Mo.fant
Mo.D2 <- Classe.Mo - Mo.fpos

Mo.li <- toString(df$variavel[idx.classe.Mo])
valor.string <- regmatches(Mo.li, regexpr("[[:digit:]]+", Mo.li))
Mo.li <- as.numeric(unlist(valor.string))

Mo <- (Mo.li + ((Mo.D1/(Mo.D1+Mo.D2))*hi))

rm(Classe.Mo, idx.classe.Mo, Mo.fant, Mo.fpos, Mo.D1, Mo.D2, Mo.li, valor.string)

#Mediana
Classe.Md <- sum(df$fi)/2

x <- vector(mode="numeric", length=0)
for(i in df$Fi){
  
  if(Classe.Md < i){
    x <- append(x, i)
  }
}

idx.classe.Md <- match(min(x), df$Fi)

Md.Fant <- df$Fi[idx.classe.Md - 1]

if (isEmpty(Md.Fant)) {
  Md.Fant <- 0
}

Md.li <- toString(df$variavel[idx.classe.Md])
valor.string <- regmatches(Md.li, regexpr("[[:digit:]]+", Md.li))
Md.li <- as.numeric(unlist(valor.string))

Md.fi <- df$fi[idx.classe.Md]

Md <- (((((sum(df$fi)/2) - Md.Fant)/Md.fi)*hi)+Md.li)

rm(Classe.Md, x, i, idx.classe.Md, Md.Fant, Md.li,valor.string, Md.fi)

nomes <- c("Média: ", "Moda: ", "Mediana: ")
valores <- c(Me, Mo, Md)

df.metricas <- data.frame(nomes, valores)
df.metricas$valores <- round(df.metricas$valores, 2)
colnames(df.metricas) <- c("Métricas", "Valores")

rm(nomes, valores)
#====================================== Calculos Separatrizes

Q <- calcSeparatriz(4)
D <- calcSeparatriz(10)
P <- calcSeparatriz(100)


#====================================== Criação do Histograma
hist <- ggplot(data=df, aes(x=variavel, y=fi))
hist <- hist + geom_col(color='black', fill = 'blue') +   
  geom_text(stat = 'identity', aes(label = fri.percent,y = fi + 0.5, x = variavel, vjust = -0.2))

hist <- hist +   
  xlab(nomes.colunas[1]) + 
  ylab(nomes.colunas[2]) +
  ggtitle("Histograma") +
  theme(axis.title.x = element_text(color="Black", size=30),
        axis.title.y = element_text(color="Black", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        
        legend.title = element_text(size=30),
        legend.text = element_text(size=20),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        
        plot.title = element_text(color="Black",
                                  size=40,
                                  family="Courier"))

#====================================== Criação do polígono frequeência simples x ponto médio
fi.extendido <- df$fi
fi.extendido <- append(fi.extendido, 0, 0)
fi.extendido <- append(fi.extendido, 0)

xi.extendido <- df$xi
xi.extendido <- append(xi.extendido, (min(xi.extendido)-hi), 0)
xi.extendido <- append(xi.extendido, ((max(xi.extendido)+hi)))


fri.percent.extendido <- df$fri.percent
fri.percent.extendido <- append(fri.percent.extendido, 0, 0)
fri.percent.extendido <- append(fri.percent.extendido, 0)

df.extendido <- data.frame(fi.extendido, xi.extendido, fri.percent.extendido)


poli.freq.simples <- ggplot(data=df.extendido, aes(x=xi.extendido, y=fi.extendido))
poli.freq.simples <- poli.freq.simples + geom_line() +
  geom_text(data = df.extendido, stat = 'identity', aes(label = fri.percent.extendido,y = fi.extendido + 0.5, x = xi.extendido + 0.1, vjust = -0.2))+
  scale_x_continuous(nomes.colunas[1], breaks = df.extendido$xi.extendido)

poli.freq.simples <- poli.freq.simples +  
  xlab(nomes.colunas[1]) + 
  ylab(nomes.colunas[2]) +
  ggtitle("Frequência x Ponto central") +
  theme(axis.title.x = element_text(color="Black", size=30),
        axis.title.y = element_text(color="Black", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        
        legend.title = element_text(size=30),
        legend.text = element_text(size=20),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        
        plot.title = element_text(color="Black",
                                  size=40,
                                  family="Courier"))
rm(fi.extendido, xi.extendido, fri.percent.extendido, df.extendido)
#====================================== Criação polígono frequência acumulada


Fri.percent <- append(df$Fri.percent, 0,0)
Fi <- append(df$Fi, 0,0)

df.poli.freq.acumulada <- data.frame(variaveis.valores, Fri.percent, Fi)

poli.freq.acumulada <- ggplot()
poli.freq.acumulada <- poli.freq.acumulada + geom_line(data = df.poli.freq.acumulada, aes(x = variaveis.valores, y= Fi, group = 1)) + 
  geom_text(stat = 'identity', aes(label = Fri.percent,y = Fi + 0.5, x = variaveis.valores + 0.1, vjust = -0.2))

poli.freq.acumulada <- poli.freq.acumulada +  
  xlab(nomes.colunas[1]) + 
  ylab(nomes.colunas[2]) +
  ggtitle("Frequência  x Ponto central") +
  theme(axis.title.x = element_text(color="Black", size=30),
        axis.title.y = element_text(color="Black", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        
        legend.title = element_text(size=30),
        legend.text = element_text(size=20),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        
        plot.title = element_text(color="Black",
                                  size=40,
                                  family="Courier"))

valores.y <- descobreFuncao(df.metricas$Valores, variaveis.valores, Fi)
poli.freq.acumulada <- poli.freq.acumulada + geom_point(aes(x=df.metricas$Valores, y=valores.y,
                                                            color=df.metricas$Métricas))

poli.freq.acumulada
rm(Fri.percent, Fi, df.poli.freq.acumulada, valores.y)

#====================================== Criação Gráfico Circular

grafico.barras<- ggplot(df, aes(x="", y=fi, fill=variavel)) + geom_bar(width = 1, stat = "identity")
grafico.circular <- grafico.barras + coord_polar("y", start=0)
grafico.circular <- grafico.circular + geom_text(data=df, aes(label = percent(fri,digits = 0)), size=5, x=1, position = position_stack(vjust = 0.4))

rm(grafico.barras)

