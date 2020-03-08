#Atividade 01

variavel <- c("[0,2[", "[2,4[", "[4,6[", "[6,8[")
fi <- c(20,6,3,1)
xi <- c(1,3,5,7)

df = data.frame(variavel, fi, xi)

df

freq.total = sum(df$n.dias)

df <- transform(df,  fri = round((prop.table(fi)), digits = 2), Fi = cumsum(fi))
df <- transform(df, fri.percent = fri*100, fri.grau = fri*360, Fri = round((prop.table(Fi)), digits = 2))
df <- transform(df, Fi.percent = Fri *100, Fi.grau = Fri*360, fxi = fi * xi)
df


hist <- ggplot(data=df, aes(x=variavel, y=fi))
hist <- hist + geom_col(color='black', fill = 'blue') +   
  geom_text(stat = 'identity', aes(label = fri.percent,y = fi + 0.5, x = variavel, vjust = -0.2))

hist <- hist +   
  xlab("Nº de Acidentes") + 
  ylab("Nº de Dias") +
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

hist

fi.extendido <- c(0,20,6,3,1,0)
xi.extendido <- c(-1,1,3,5,7,9)
fri.percent.extendido <- df$fri.percent
fri.percent.extendido <- append(fri.percent.extendido, 0, 0)
fri.percent.extendido <- append(fri.percent.extendido, 0)
fri.percent.extendido

df.extendido <- data.frame(fi.extendido, xi.extendido, fri.percent.extendido)

?geom_line()

poli.freq.simples <- ggplot(data=df.extendido, aes(x=xi.extendido, y=fi.extendido))
poli.freq.simples <- poli.freq.simples + geom_line() +
  geom_text(stat = 'identity', aes(label = fri.percent.extendido,y = fi.extendido + 0.5, x = xi.extendido + 0.1, vjust = -0.2))+
  scale_x_continuous("Nº Acidentes", breaks = xi.extendido)

poli.freq.simples <- poli.freq.simples +  
  xlab("Nº de Acidentes") + 
  ylab("Nº de Dias") +
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


poli.freq.acumulada <- 
