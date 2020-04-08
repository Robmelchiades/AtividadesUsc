#Atividade 01

library(formattable)
library(ggplot2)
library(ggrepel)
source("suporte_estatistica.r")
setwd("/home/robson/repositorios/AtividadesUsc/estatistica")


#====================================== Criação do dataframe
#informe os valores dos intervalos
variavel <- c("[10,14[", "[14,18[", "[18,22[","[22,26[", "[26,30[")
#informe os valores da frequência simples
fi <- c(1,11,17,11,10)
#informe os nomes das colunas
nomes.colunas <- c("Teste Raciocínio Lógico","Nº Programadores")
unidade.medida <- ("")
#informe o valor da amplitude do intervalo
hi <- 4
variacao <- 1

retorno <- preparaDataset(variavel, fi, hi, nomes.colunas)
df <- data.frame(retorno[1])
df.apresentacao <- data.frame(retorno[2])
df.infos <- data.frame(retorno[3])
rm(retorno)

#====================================== Calculos Medidas Estatísticas

df.metricas <- calculaMedidas(df,hi)

#====================================== Calculos Separatrizes

df.separatrizes <- calculaSeparatrizes(df)


#====================================== Coeficientes Estatísticos
retornos <-calculaCoeficientes(df.separatrizes, df.metricas)
df.coeficientes <- data.frame(retornos[1])
df.classificaCurva <- data.frame(retornos[2])
rm(retornos)

#====================================== Criação do Histograma

hist <- criaHistograma(df)

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


poli.freq.simples <- ggplot()
poli.freq.simples <- poli.freq.simples + geom_line(data=df.extendido,aes(x=df.extendido$xi.extendido, y=df.extendido$fi.extendido)) +
  geom_text(stat = 'identity', 
            aes(label = percent((df.extendido$fri.percent.extendido)/100, digits = 0),
                y = df.extendido$fi.extendido + 0.5, x = df.extendido$xi.extendido + 0.1, vjust = -0.2))+
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
valores.y.me.fi <- descobreFuncao(df.metricas$Valores[1:3], xi.extendido, fi.extendido)
poli.freq.simples <- poli.freq.simples +
  geom_point(aes(x=df.metricas$Valores[1:3], y=valores.y.me.fi,color=as.vector(df.metricas$Métricas[1:3]))) + 
  geom_label_repel(aes(x=df.metricas$Valores[1:3], y=valores.y.me.fi,label = as.vector(df.metricas$Métricas[1:3])),
                   nudge_x = 0,
                   nudge_y = 50,
                   box.padding   = 0.8, 
                   point.padding = 1,
                   segment.color = 'grey50')

#rm(fi.extendido, xi.extendido, fri.percent.extendido, df.extendido)
poli.freq.simples

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

valores.y.sep <- descobreFuncao(df.separatrizes$Valor, variaveis.valores, df.poli.freq.acumulada$Fi.graf)
poli.freq.acumulada.sep <- poli.freq.acumulada + 
  geom_point(aes(x=df.separatrizes$Valor, y=valores.y.sep,color=df.separatrizes$Separatriz)) + 
  geom_label_repel(aes(x=df.separatrizes$Valor, y=valores.y.sep,label = df.separatrizes$Separatriz),
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
