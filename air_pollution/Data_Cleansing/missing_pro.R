install.packages("VIM")
library(mice)
library(VIM)


chumma <- read.csv(file = "orginal_5.csv")
str(chumma)
table(is.na(chumma))

summary(chumma)
 
# Missing data
p <- function(x) {sum(is.na(x))/ length(x)*100}
apply(chumma, 2, p)
md.pattern(chumma)
md.pairs(chumma)
marginplot(chumma[,c('so2', 'no2')])



#impute


impute <- mice(chumma, m=3, seed = 123)
print(impute)  #predictive mean matching (pmm)  polyreg(multi nominal logistic regression)

impute$imp$so2



#complete data

new_chumma <- complete(impute, 1)


# Distribution of observed/imputed values
stripplot(impute, pch = 20, cex = 1.2)
xyplot(impute, so2 ~ no2 | .imp, pch = 20, cex = 1.4)
write.csv(new_chumma, "orginal_5.csv")
