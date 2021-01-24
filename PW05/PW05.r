# BEDU DS-2021 - M02 - PW05
library(tidyverse)
library(fbRanks)

# 1. A partir del conjunto de datos de soccer de la liga española de las
#  temporadas 2017/2018, 2018/2019 y 2019/2020, crea el data frame SmallData,
#  que contenga las columnas date, home.team, home.score, away.team y
#  away.score; esto lo puede hacer con ayuda de la función select del paquete
#  dplyr. Luego establece un directorio de trabajo y con ayuda de la función
#  write.csv guarda el data frame como un archivo csv con nombre soccer.csv.
#  Puedes colocar como argumento row.names = FALSE en write.csv.

datasets <- c('1718', '1819', '1920')  # datasets file names
colNames <-
  c('Date', 'HomeTeam', 'FTHG', 'AwayTeam', 'FTAG')  # columns to be selected
smallData <-
  data.frame(matrix(ncol = length(colNames), nrow = 0))  # create empty data.frame
colnames(smallData) <- colNames  # rename colnames

# merge all datasets into one
for (set in datasets) {
  path <- paste('../datasets/SP1_', set , '.csv', sep = '')
  smallData <- rbind(smallData, read.csv(path)[colNames])
}

# modify data.frame for fbFranks data.frame specs
colnames(smallData) <-
  c('date', 'home.team', 'home.score', 'away.team', 'away.score')  # rename cols
smallData$date <-
  strptime(as.character(smallData$date), '%d/%m/%Y')  # parse factor -> date
format(smallData$date, '%Y-%m-%d')  # change date formating

write.csv(smallData, file = 'soccer.csv')  # save data.frame to CSV

# 2. Con la función create.fbRanks.dataframes del paquete fbRanks importe el
#  archivo soccer.csv a R y al mismo tiempo asignelo a una variable llamada
#  listasoccer. Se creará una lista con los elementos scores y teams que son
#  data frames listos para la función rank.teams. Asigna estos data frames a
#  variables llamadas anotaciones y equipos

listaSoccer <- create.fbRanks.dataframes(scores.file = 'soccer.csv')
scores <- listaSoccer$scores
teams <- listaSoccer$teams

# 3. Con ayuda de la función unique crea un vector de fechas (fecha) que no se
#  repitan y que correspondan a las fechas en las que se jugaron partidos.
#  Crea una variable llamada n que contenga el número de fechas diferentes.
#  Posteriormente, con la función rank.teams y usando como argumentos los data
#  frames anotaciones y equipos, crea un ranking de equipos usando unicamente
#  datos desde la fecha inicial y hasta la penúltima fecha en la que se jugaron
#  partidos, estas fechas las deberá especificar en max.date y min.date.
#  Guarda los resultados con el nombre ranking.

uDates <- unique(scores$date)
n <- length(uDates)

ranking <- rank.teams(
  scores = scores,
  teams = teams,
  min.date = uDates[1],
  max.date = uDates[n - 1]
)

# 4. Finalmente estima las probabilidades de los eventos, el equipo de casa gana,
#  el equipo visitante gana o el resultado es un empate para los partidos que se
#  jugaron en la última fecha del vector de fechas fecha. Esto lo puedes hacer
#  con ayuda de la función predict y usando como argumentos ranking y fecha[n]
#  que deberá especificar en date.

predict(ranking, date = uDates[n])
