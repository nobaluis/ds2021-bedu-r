#SOLUCION POSTWORK SESION 2

#Ahora vamos a generar un cumulo de datos mayor al que se tenia, 
#Esta es una situacion habitual que se puede presentar para complementar un an?lisis, 
#siempre es importante estar revisando las caracteristicas o tipos de datos que tenemos, 
#por si es necesario realizar alguna transformacion en las variables y poder hacer operaciones aritmeticas si es el caso,
#ademas de solo tener presente algunas de las variables, no siempre se requiere el uso de todas para ciertos procesamientos.

#1.Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera division de la liga espa?ola 

lfp1920 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
lfp1819 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
lfp1718 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"

download.file(url = lfp1920, destfile = "lfp1920.csv", mode = "wb")
download.file(url = lfp1819, destfile = "lfp1819.csv", mode = "wb")
download.file(url = lfp1718, destfile = "lfp1718.csv", mode = "wb")

liga <- lapply(list.files(pattern="*.csv"), read.csv)

#2.Obten una mejor idea de las caracteristicas de los data frames al usar las funciones: str, head, View y summary

str(liga)
head(liga)
View(liga)
summary(liga)

#3.Con la funci?n select del paquete dplyr selecciona ?nicamente las columnas 
#Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR; esto para cada uno de los data frames. (Hint: tambi?n puedes usar lapply).

library(dplyr)
lista <- lapply(liga,select,c("Date","HomeTeam","AwayTeam","FTHG","HTAG","FTR"))

#4.Asegúrate de que los elementos de las columnas correspondientes de los nuevos data frames sean del mismo tipo 
#(Hint 1: usa as.Date y mutate para arreglar las fechas). Con ayuda de la función rbind forma un único data frame 
#que contenga las seis columnas mencionadas en el punto 3 (Hint 2: la función do.call podría ser utilizada).
data <- do.call(rbind, lista)
data <- mutate(data,Date = as.Date(Date, "%d/%m/%y"))

# Se escribe un archivo csv que se ocupará para el postwork de la sesión 3
write.csv(data, file = "temporadas.csv", row.names = FALSE)

