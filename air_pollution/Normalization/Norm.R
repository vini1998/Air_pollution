setwd("~/Desktop/pollution")

pollu.full <- read.csv(file = "Original.csv", stringsAsFactors = FALSE, header = TRUE)


#pollu.full$PM10 <- scale(pollu.full$PM10)
pollu.full$scalepm2.5 <- scale(pollu.full$PM.2.5)
var(pollu.full$PM.2.5)
sd(pollu.full$PM.2.5)

y <- pollu.full$scalepm2.5 - mean(pollu.full$scalepm2.5 / sd(pollu.full$scalepm2.5))

y

mean(y)
sd(y)
var(y)
pollu.full$normpm2.5 <- y




pollu.full$PM.2.5


mean(pollu.full$PM.2.5)
var(pollu.full$PM.2.5)
sd(pollu.full$PM.2.5)
