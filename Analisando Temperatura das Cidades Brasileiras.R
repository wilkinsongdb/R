# Big Data na prática - Analisando a Temperatura Médias das Cidades Brasileiras


# Configurando o diretório
setwd("C:/Users/wilki/OneDrive/Documentos/Wilkinson/Cursos/DSA/FCD/Big_Data _Analytics_com_R_e_Azure_ML/Cap3")
getwd()

# Dataset:
# Berkeley Earth
# http://berkeleyearth.org/data
# TemperaturasGlobais.csv ~ 78MB(zip) ~ 496MB (unzip)

# Instalando e carregando pacotes
install.packages("readr")
install.packages("data.table")
install.packages("dplyr")
install.packages("ggplot2")
library(readr)
library(dplyr)
library(ggplot2)
library(scales)
library(data.table)

# Carregando os dados (usando um timer para comparar o tempo de carregamento)

# Usando o read.csv2()
system.time(df_teste1 <- read.csv2("TemperaturasGlobais.csv"))

# Usando o read.table()
system.time(df_teste2 <- read.table("TemperaturasGlobais.csv"))

#Usando fread()
?fread
system.time(df <- fread("TemperaturasGlobais.csv"))


#Criando subsets dos dados carregados
cidadesBrasil <- subset(df, Country == 'Brazil')
cidadesBrasil <- na;omit(cidadesBrasil)
head(cidadesBrasil)
nrow(df)
nrow(cidadesBrasil)
dim(cidadesBrasil)


#Preparação e organização 

#Convertendo as datas
cidadesBrasil$dt <- as.POSIXct(cidadesBrasil$dt,format='%Y-%m-%d')
cidadesBrasil$Month <- month(cidadesBrasil$dt)
cidadesBrasil$Year <- year(cidadesBrasil$dt)

# Convertendo os subsets

#Palmas
plm <- subset(cidadesBrasil, City == 'Palmas')
plm <- subset(plm, Year %in% c(1796,1846,1896,1946,1996,2012))


#Curitiba
crt <- subset(cidadesBrasil, City == 'Curitiba')
crt <- subset(crt, Year %in% c(1796,1846,1896,1946,1996,2012))

#Recife
recf <- subset(cidadesBrasil, City == 'Recife')
recf <- subset(recf, Year %in% c(1796,1846,1896,1946,1996,2012))


#Construindo os Plots
p_plm <- ggplot(plm, aes(x = Months, y = AverangeTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE, fil = NA, size =2) +
  theme_light(base_size = 20) +
  xlab("Mês") +
  ylab("Temperatura Média") +
  scale_color_discrete("") +
  ggtitle("Temperatura Média ao longo dos anos em Palmas") +
  theme(plot.title = element_text(size = 18))


p_crt <- ggplot(crt, aes(x = Months, y = AverangeTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE, fil = NA, size =2) +
  theme_light(base_size = 20) +
  xlab("Mês") +
  ylab("Temperatura Média") +
  scale_color_discrete("") +
  ggtitle("Temperatura Média ao longo dos anos em Curitiba") +
  theme(plot.title = element_text(size = 18))


p_recf <- ggplot(recf, aes(x = Months, y = AverangeTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE, fil = NA, size =2) +
  theme_light(base_size = 20) +
  xlab("Mês") +
  ylab("Temperatura Média") +
  scale_color_discrete("") +
  ggtitle("Temperatura Média ao longo dos anos em Recife") +
  theme(plot.title = element_text(size = 18))


#Plotando

p_plm
p_crt
p_recf