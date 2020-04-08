#Atividade 01

library(formattable)
library(ggplot2)
library(ggrepel)



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
variavel <- c("[6,12[", "[12,18[", "[18,24[","[24,30[", "[30,36[", "[36,42[", "[42,48[", "[48,54[", "[54,60[")
#informe os valores da frequência simples
fi <- c(5,16,15,11,10,9,6,5,3)
#informe os nomes das colunas
nomes.colunas <- c("Teste Rac. Lógico","Nº de Programas")
#informe o valor da amplitude do intervalo
hi <- 4
variacao <- 1

xi <- (recuperaLimites(variavel) +(hi/2))[1:length(fi)]
df = data.frame(variavel, fi, xi)
rm(variavel, fi)

df <- transform(df,  fri = round((prop.table(fi)), digits = 2), Fi = cumsum(fi))
df <- transform(df, fri.percent = fri*100, fri.grau = fri*360, Fri = round(Fi / sum(df$fi), digits = 2))
df <- transform(df, Fri.percent = Fri *60, fxi = fi * xi)
df <- transform(df, xi_2 = xi*xi, fi_xi_2 = fi*xi*xi)

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

#Desvio Padrão - Desvio dos valores em relação a média

S <- sqrt((sum(df$fi_xi_2)/sum(df$fi)) - ((sum(df$fxi)/sum(df$fi)))^2)


#Coeficiente de Variação
#Cc < 0,263 -> Estreita
#Cc = 0,263 -> Moderada
#Cc > 0,263 -> Achatada


Cv <- (S/Me)*100


# Criação do dataframe métricas:

nomes <- c("Média: ", "Moda: ", "Mediana: ", "Desvio Padrão: ", "Coeficiente de Variação: ")
valores <- c(Me, Mo, Md, S, Cv)

df.metricas <- data.frame(nomes, valores)
df.metricas$valores <- round(df.metricas$valores, 2)
colnames(df.metricas) <- c("Métricas", "Valores")



#====================================== Calculos Separatrizes

K <- calcSeparatriz(4)
D <- calcSeparatriz(10)
P <- calcSeparatriz(100)

vetK <- c(K)
vetD <- c(D[c(1,3,5,7,9)])
vetP <- P[c(10,25,50,75,90)]
vetValores <- c(vetK, vetD, vetP)

vetnomes <- c("K1","K2","K3","D1","D3","D5","D7","D9","P10","P25","P50","P75","P90")

df.separatrizes <- data.frame(vetnomes, vetValores)

rm(vetK, vetD, vetP, vetValores, vetnomes, K, D, P)


#====================================== Coeficientes Estatísticos
#Tipo Assimetria - Nome no gráfico
#Ta < 0 - Assimétrico Negativo/ esqueda
#Ta = 0 - Assimétrico Nulo
#Ta > 0 - Assimétrico Positivo / direita
Ta <- Me - Mo


#Coeficiente Assimetria
Ca <- (3*(Me-Mo))/S



#Coeficiente de Curtose
#Grau de achatamento, pico do gráfico até o eixo X
k3 <- df.separatrizes$vetValores[df.separatrizes$vetnomes == "K3"]
k1 <- df.separatrizes$vetValores[df.separatrizes$vetnomes == "K1"]
p90 <- df.separatrizes$vetValores[df.separatrizes$vetnomes == "P90"]
p10 <- df.separatrizes$vetValores[df.separatrizes$vetnomes == "P10"]

Cc <- (( k3-k1)/(2*(p90-p10)))

vetValores <- c(Ta, Ca, Cc)

vetnomes <- c("Tipo Assimetria","Coeficiente Assimetria","Coeficiente Curtose")
df.coeficientes <- data.frame(vetnomes, vetValores)
rm(k3,k1,p90,p10)

#====================================== Criação do Histograma
hist <- ggplot(data=df, aes(x=variavel, y=fi))
hist <- hist + geom_col(color='black', fill = 'blue') +   
  geom_text(stat = 'identity', aes(label = percent(fri, digits = 0),y = fi + 0.5, x = variavel, vjust = -0.2))

hist <- hist +   
  xlab(nomes.colunas[1]) + 
  ylab(nomes.colunas[2]) +
  ggtitle("Histograma") +
  theme(axis.title.x = element_text(color="Black", size=15),
        axis.title.y = element_text(color="Black", size=15),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=10),
        
        legend.title = element_text(size=12),
        legend.text = element_text(size=10),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        
        plot.title = element_text(color="Black",
                                  size=20,
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
  geom_text(data = df.extendido, stat = 'identity', 
            aes(label = percent((fri.percent.extendido)/100, digits = 0),
                y = fi.extendido + 0.5, x = xi.extendido + 0.1, vjust = -0.2))+
  scale_x_continuous(nomes.colunas[1], breaks = df.extendido$xi.extendido)

poli.freq.simples <- poli.freq.simples +  
  xlab(nomes.colunas[1]) + 
  ylab(nomes.colunas[2]) +
  ggtitle("Frequência x Ponto central") +
  theme(axis.title.x = element_text(color="Black", size=15),
        axis.title.y = element_text(color="Black", size=15),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=10),
        
        legend.title = element_text(size=12),
        legend.text = element_text(size=10),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        
        plot.title = element_text(color="Black",
                                  size=20,
                                  family="Courier")) +
  theme_classic()
rm(fi.extendido, xi.extendido, fri.percent.extendido, df.extendido)



#====================================== Criação polígono frequência acumulada Métricas

Fri.percent.graf <- append(df$Fri.percent, 0,0)
Fi.graf <- append(df$Fi, 0,0)
Fri.graf = round(Fi.graf / sum(df$fi), digits = 2)

df.poli.freq.acumulada <- data.frame(variaveis.valores, Fri.percent.graf, Fi.graf,Fri.graf)

poli.freq.acumulada <- ggplot()
poli.freq.acumulada <- poli.freq.acumulada + geom_line(data = df.poli.freq.acumulada, 
                                                       aes(x = variaveis.valores, y= Fi.graf, group = 1)) + 
  geom_text(data = df.poli.freq.acumulada, stat = 'identity', 
            aes(label = percent((Fri.graf),digits = 0),y = Fi.graf + 0.5, x = variaveis.valores + 0.1, vjust = -0.2))

poli.freq.acumulada <- poli.freq.acumulada +  
  xlab(nomes.colunas[1]) + 
  ylab(nomes.colunas[2]) +
  ggtitle("Frequência Acumulada com Separatrizes") +
  theme(axis.title.x = element_text(color="Black", size=15),
        axis.title.y = element_text(color="Black", size=15),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=10),
        
        legend.title = element_text(size=12),
        legend.text = element_text(size=10),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        
        plot.title = element_text(color="Black",
                                  size=20,
                                  family="Courier"))

rm(Fri.percent.graf, Fi.graf)


#====================================== Criação polígono frequência acumulada Métricas

valores.y.me <- descobreFuncao(df.metricas$Valores[1:3], variaveis.valores, df.poli.freq.acumulada$Fi.graf)
poli.freq.acumulada.me <- poli.freq.acumulada + 
  geom_point(aes(x=df.metricas$Valores[1:3], y=valores.y.me,color=df.metricas$Métricas[1:3])) + 
  geom_label_repel(aes(x=df.metricas$Valores[1:3], y=valores.y.me,label = df.metricas$Métricas[1:3]),
                   nudge_x = 1,
                   nudge_y = 32,
                   box.padding   = 0.8, 
                   point.padding = 1,
                   segment.color = 'grey50') +
  theme_classic()

#====================================== Criação polígono frequência acumulada Separatrizes

valores.y.sep <- descobreFuncao(df.separatrizes$vetValores, variaveis.valores, df.poli.freq.acumulada$Fi.graf)
poli.freq.acumulada.sep <- poli.freq.acumulada + 
  geom_point(aes(x=df.separatrizes$vetValores, y=valores.y.sep,color=df.separatrizes$vetnomes)) + 
  geom_label_repel(aes(x=df.separatrizes$vetValores, y=valores.y.sep,label = df.separatrizes$vetnomes),
                   nudge_x = 1,
                   nudge_y = 35,
                   box.padding   = 0.8, 
                   point.padding = 1,
                   segment.color = 'grey50') +
  theme_classic()



poli.freq.acumulada.sep
#====================================== Criação Gráfico Circular

grafico.barras<- ggplot(df, aes(x="", y=fi, fill=variavel)) + geom_bar(width = 1, stat = "identity")
grafico.circular <- grafico.barras + coord_polar("y", start=0)
grafico.circular <- grafico.circular + geom_text(data=df, aes(label = percent(fri,digits = 0)), size=5, x=1, position = position_stack(vjust = 0.4))

rm(grafico.barras)

#====================================== Poligono Frequência Simples