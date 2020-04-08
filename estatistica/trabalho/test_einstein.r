library(formattable)
library(ggplot2)
library(ggrepel)



setwd("/home/robson/repositorios/AtividadesUsc/estatistica/trabalho/")

#======================================= Importando o Dataset
dataset <- read.csv("dataset.csv")

library(dplyr)

dataset <- mutate_all(dataset, list(~na_if(.,"")))
dataset <- dataset[!is.na(dataset$Hematocrit),]


# dataset <- dataset[,2:3]

dataset_pos <- dataset[dataset$SARS.Cov.2.exam.result=="positive",]
dataset_neg <- dataset[dataset$SARS.Cov.2.exam.result=="negative",]


plt <- ggplot() + geom_point(aes(x=dataset$Hemoglobin, y=dataset$Hematocrit, color=dataset$SARS.Cov.2.exam.result))

hist <- ggplot() + geom_line(aes(x=dataset_pos$Patient.age.quantile, 
                                 y=as.numeric(gsub(",", ".", dataset_pos$Hematocrit))))

hist <- ggplot() + geom_histogram(aes(x=as.numeric(gsub(",", ".", dataset_pos$Hematocrit))))
hist <- ggplot() + geom_histogram(aes(x=as.numeric(gsub(",", ".", dataset_pos$Hemoglobin))))

hist <- ggplot() + geom_histogram(aes(x=as.numeric(gsub(",", ".", dataset_pos$Platelets))))
hist <- ggplot() + geom_histogram(aes(x=as.numeric(gsub(",", ".", dataset_neg$Platelets))))

hist <- ggplot() + geom_histogram(aes(x=as.numeric(gsub(",", ".", dataset_pos$Mean.platelet.volume))))
hist <- ggplot() + geom_histogram(aes(x=as.numeric(gsub(",", ".", dataset_pos$Red.blood.Cells))))
hist <- ggplot() + geom_histogram(aes(x=as.numeric(gsub(",", ".", dataset_pos$Lymphocytes))))
