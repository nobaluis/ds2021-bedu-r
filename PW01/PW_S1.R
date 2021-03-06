############################PW SESION 1
#Importa los datos de soccer de la temporada 2019/2020 de la primera divisi�n de la liga espa�ola
liga <- read.csv("SP1.csv")

#extrae las columnas que contienen los n�meros de goles anotados por los equipos que jugaron en casa (FTHG) y
liga$FTHG

#los goles anotados por los equipos que jugaron como visitante (FTAG)
liga$FTAG

#Consulta cOmo funciona la funci�n table en R al ejecutar en la consola ?table
?table

#Elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:

#probabilidad (marginal) de que el equipo que juega en casa anote x goles (x = 0, 1, 2, ...)
casa<-table(liga$FTHG)
casa_fr<-casa/margin.table(casa)
casa_fr

#probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y = 0, 1, 2, ...)
visita<-table(liga$FTAG)
visita_fr<-visita/margin.table(visita)
visita_fr

#La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles 
#(x = 0, 1, 2, ..., y = 0, 1, 2, ...)

conjunta <- table(liga$FTHG,liga$FTAG)
conjunta_pr <- conjunta/380
conjunta_pr

casa
