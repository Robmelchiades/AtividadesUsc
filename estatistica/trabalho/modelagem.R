library(formattable)
library(ggplot2)
library(ggrepel)



setwd("/home/robson/repositorios/AtividadesUsc/estatistica/trabalho/")

#======================================= Importando o Dataset
dataset <- read.csv("time_series_Confirmed.csv")
# dataset <- dataset[,2:3]

#======================================= Ajustando o Dataset

brazil_cases <- dataset[dataset$Country.Region =='Brazil',]

brazil_cases <- brazil_cases[40:length(brazil_cases)]
dias <- c(colnames(brazil_cases), "X3.21.20","X3.22.20")
idx <- seq(1,length(dias))
#n_infectados <- as.numeric(brazil_cases[1,])
n_infectados <- c(1,1,1,2,2,2,2,3,8,13,25,25,25,34,52,77,98,98,98,98,234,291,428,621,978,1178)
brazil_cases <- data.frame(idx, n_infectados)

rm(idx, n_infectados)
#======================================= Preparando o modelo de regressão polinominal
brazil_cases$idx2 = brazil_cases$idx^2
brazil_cases$idx3 = brazil_cases$idx^3
brazil_cases$idx4 = brazil_cases$idx^4
poly_reg = lm(formula = n_infectados ~ .,
              data = brazil_cases)




#======================================= Predição pelo modelo
idx <- seq(from = 27, to = 31, by = 1)
n_infectados <- vector()
for (i in idx) {
  n_infectados[i-26] <- predict(poly_reg, data.frame(idx = i,
                               idx2 = i^2,
                               idx3 = i^3,
                               idx4 = i^4))
}

previsoes <- data.frame(idx, n_infectados)
previsoes$idx2 = previsoes$idx^2
previsoes$idx3 = previsoes$idx^3
previsoes$idx4 = previsoes$idx^4



total <- rbind(brazil_cases, previsoes)
#======================================= Predição pelo modelo
library(ggplot2)
plot <- ggplot() +
  geom_point(aes(x = brazil_cases$idx, y = brazil_cases$n_infectados),
             colour = 'red') +
  geom_point(aes(x = previsoes$idx, y = previsoes$n_infectados),
             colour = 'green') +
  geom_text(aes(x = total$idx, y = total$n_infectados + 100, label=paste(round(total$n_infectados),
                                                                         total$idx, sep = " / "))) +
  ggtitle('Casos Confirmados x Número de Dias') +
  xlab('Dias') +
  ylab('Nº Casos Confirmados')

plot <- plot + geom_line(aes(x = total$idx, y = predict(poly_reg, newdata = total)),
            colour = 'blue')
plot

#======================================= Plotando a curva polinomial com o número de casos
library(ggplot2)
ggplot() +
  geom_point(aes(x = brazil_cases$idx, y = brazil_cases$n_infectados),
             colour = 'red') +
  geom_line(aes(x = brazil_cases$idx, y = predict(poly_reg, newdata = brazil_cases)),
            colour = 'blue') +
  ggtitle('Casos Confirmados x Número de Dias') +
  xlab('Dias') +
  ylab('Nº Casos Confirmados')



time_series <- ggplot()
time_series <- time_series + geom_line(data = brazil_cases, aes(x=idx, y = n_infectados, group=0))





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


