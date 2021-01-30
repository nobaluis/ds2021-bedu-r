# Importa el conjunto de datos match.data.csv a R y realiza lo siguiente:
suppressMessages(suppressWarnings(library(dplyr)))
match_data <- read.csv("match.data.csv")
match_data <- mutate(match_data, date = as.Date(date,"%Y-%m-%d"))

# Agrega una nueva columna sumagoles que contenga la suma de goles por partido.
match_data$sumagoles <- match_data$home.score + match_data$away.score

# Obtén el promedio por mes de la suma de goles.
match_data <- mutate(match_data, Ym = format(date, "%Y-%m"))
data <- group_by(match_data,Ym) %>% summarise(goles = round(mean(sumagoles),2))

# Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019.
data <- ts(data$goles, start = c(2017, 8), end = c(2019, 12), frequency = 12)

# Grafica la serie de tiempo.
library(ggplot2)
library(ggfortify)
autoplot(data, ts.colour = "red", xlab = "Tiempo", ylab = "Promedio de goles",
         main = "Serie de tiempo") +
      geom_hline(yintercept=mean(data), linetype="dashed", color = "black", size=1)

