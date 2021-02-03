#Postwork Sesión 4

#OBJETIVO
# Investigar la dependencia o independecia de las variables aleatorias X y Y, el número 
# de goles anotados por el equipo de casa y el número de goles anotados por el equipo visitante.

# Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote X=x goles
# (x=0,1,... ,8), y el equipo visitante anote Y=y goles (y=0,1,... ,6), en un partido. 
# Obtén una tabla de cocientes al dividir estas probabilidades conjuntas por el producto
# de las probabilidades marginales correspondientes.

setwd("C:/Paulo/BEDU")
res_liga <-read.csv("SP1.csv")
View(res_liga)

casa <- table(res_liga$FTHG) # La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)
casa_pr_mar <- prop.table(casa)
View(casa_pr_mar)

visita <- table(res_liga$HTAG) # La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)
visita_pr_mar <- prop.table(visita)
View(visita_pr_mar)

conjunta <- table(res_liga$FTHG,res_liga$HTAG) # La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
conjunta_pr_con <- prop.table(conjunta)
View(conjunta_pr_con)

k=1
cocientes=data.frame()

for (i in 1:4) {
  for(j in 1:7){
    x<-conjunta_pr_con[k]/(casa_pr_mar[j]*visita_pr_mar[i])
    cocientes<-rbind(cocientes,x)
    k<-k+1
  }
}
View(cocientes) # Tabla de cocientes

#Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos en
# la tabla del punto anterior. Esto para tener una idea de las distribuciones de la cual
# vienen los cocientes en la tabla anterior. Menciona en cuáles casos le parece razonable
# suponer que los cocientes de la tabla en el punto 1, son iguales a 1 (en tal caso tendríamos
# independencia de las variables aleatorias X y Y).

install.packages("boot")
library(boot)

fun_cocientes <- function(res_liga,i){
  data<-res_liga[i,]
  return(cor(data$FTHG, data$HTAG))
}
res <-boot(res_liga,fun_cocientes,R=10000)
plot(res)
boot.ci(boot.out = res, type = c("norm", "basic", "perc", "bca"))
