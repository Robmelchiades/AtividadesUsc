
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

calcSeparatriz <- function(sep, df){
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

preparaDataset <-function(variavel, fi, hi, nomes.colunas){
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
  
  retornos <- list(df, df.apresentacao, df.infos)
  return(retornos)
}

calculaMedidas <-function(df, hi){
  
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
  
  #Desvio Padrão - Desvio dos valores em relação a média
  
  S <- sqrt((sum(df$fi_xi_2)/sum(df$fi)) - ((sum(df$fxi)/sum(df$fi)))^2)
  
  Cv <- (S/Me)*100
  
  # Criação do dataframe métricas:
  
  nomes <- c("Média(Me) ", "Moda(Mo) ", "Mediana(Md) ", "Desvio Padrão(S) ", "Coeficiente de Variação(Cv) ")
  valores <- c(Me, Mo, Md, S, Cv)
  
  df.metricas <- data.frame(nomes, valores)
  df.metricas$valores <- round(df.metricas$valores, 2)
  colnames(df.metricas) <- c("Métricas", "Valores")
  return(df.metricas)
  
}

calculaSeparatrizes <- function(df){
  
  K <- calcSeparatriz(4, df)
  D <- calcSeparatriz(10, df)
  P <- calcSeparatriz(100, df)
  
  vetK <- c(K)
  vetD <- c(D[c(1,3,5,7,9)])
  vetP <- P[c(10,25,50,75,90)]
  vetValores <- c(vetK, vetD, vetP)
  
  vetnomes <- c("K1","K2","K3","D1","D3","D5","D7","D9","P10","P25","P50","P75","P90")
  
  df.separatrizes <- data.frame(vetnomes, vetValores)
  colnames(df.separatrizes) <- c("Separatriz", "Valor")
  
  return(df.separatrizes)
}

calculaCoeficientes <- function(df.separatrizes, df.metricas){
  #Tipo Assimetria - Nome no gráfico
  #Ta < 0 - Assimétrico Negativo/ esqueda
  #Ta = 0 - Assimétrico Nulo
  #Ta > 0 - Assimétrico Positivo / direita
  #Ta = Me - Mo
  Ta <- df.metricas$Valores[1] - df.metricas$Valores[2]
  
  
  #Coeficiente Assimetria
  #Ca = (3*(Me-Md))/S
  Ca <- (3*(df.metricas$Valores[1]-df.metricas$Valores[3]))/df.metricas$Valores[4]
  
  
  
  #Coeficiente de Curtose
  #Grau de achatamento, pico do gráfico até o eixo X
  k3 <- df.separatrizes$Valor[df.separatrizes$Separatriz == "K3"]
  k1 <- df.separatrizes$Valor[df.separatrizes$Separatriz == "K1"]
  p90 <- df.separatrizes$Valor[df.separatrizes$Separatriz == "P90"]
  p10 <- df.separatrizes$Valor[df.separatrizes$Separatriz == "P10"]
  
  #Coeficiente de Variação
  #Cc < 0,263 -> Estreita
  #Cc = 0,263 -> Moderada
  #Cc > 0,263 -> Achatada
  
  Cc <- (( k3-k1)/(2*(p90-p10)))
  vetValores.co <- c(Ta, Ca, Cc)
  
  vetnomes.co <- c("Tipo Assimetria(Ta)","Coeficiente Assimetria(Ca)","Coeficiente Curtose(Cc)")
  df.coeficientes <- data.frame(vetnomes.co, vetValores.co)
  colnames(df.coeficientes) <- c("Coeficiente", "Valor")
  
  #====================================== Classifica Curva
  vetcat <- c("Assimetria (Ca e Ta): ", "Grau de Achatamento (Cc): ")
  achatamento <- ""
  if(Cc >0.263){
    achatamento <- "Achatado"
  }else if(Cc==0.263){
    achatamento <- "Moderado"
  }else{
    achatamento <- "Achatada"
  }
  
  assimetria <- ""
  if(Ta < 0){
    assimetria <- "Assimetrico Negativo"
  }else if(Ta==0){
    assimetria <- "Assimetrico Nulo"
  }else{
    assimetria <- "Assimetrico Positivo"
  }
  vetval <- c(assimetria, achatamento)
  df.classificaCurva <- data.frame(vetcat, vetval)
  
  
  colnames(df.classificaCurva) <- c("Tipo Classificador", "Categoria")
  
  retornos <- list(df.coeficientes, df.classificaCurva)
  return(retornos)
}

criaHistograma <- function(df){
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
  
  
}
