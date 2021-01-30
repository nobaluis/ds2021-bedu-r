#SOLUCION POSTWORK SESION 3

data <- read.csv("temporadas.csv")

#1.Con el ?ltimo data frame obtenido en el postwork de la sesi?n 2, elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:

# La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)
casa <- table(data$FTHG)
casa_pr_mar <- prop.table(casa)
# La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)
visita <- table(data$HTAG)
visita_pr_mar <- prop.table(visita)

# La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
conjunta <- table(data$FTHG,data$HTAG)
conjunta_pr_con <- prop.table(conjunta)

# 3. Realiza lo siguiente:

# Un gr?fico de barras para las probabilidades marginales estimadas del n?mero de goles que anota el equipo de casa
library(ggplot2)
casa <- as.data.frame(casa_pr_mar)

ggplot(data=casa, aes(x=Var1, y=Freq)) +
      geom_bar(fill = "#FF6666", stat="identity") +
      ggtitle("Casa") +
      ylab("Frecuencia") +
      xlab("Goles") + 
      theme_dark()

# Un gr?fico de barras para las probabilidades marginales estimadas del n?mero de goles que anota el equipo visitante.
visitante <- as.data.frame(visita_pr_mar)

ggplot(data=visitante, aes(x=Var1, y=Freq)) +
      geom_bar(fill = "#ACEACE", stat="identity") +
      ggtitle("Visitante") +
      ylab("Frecuencia") +
      xlab("Goles") + 
      theme_dark()

#Un HeatMap para las probabilidades conjuntas estimadas de los n?meros de goles que anotan el equipo de casa y el equipo visitante en un partido.
prob_conjunta <- as.data.frame(conjunta_pr_con)

ggplot(data=prob_conjunta, aes(x=Var1, y=Var2, fill = Freq)) +
      geom_tile() + scale_fill_gradient(low = "white", high = "steelblue") +
      ggtitle("Porbabilidad conjunta") +
      ylab("Visitante") +
      xlab("Casa") +
      theme_light()







