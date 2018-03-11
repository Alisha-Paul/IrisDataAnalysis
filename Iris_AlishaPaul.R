install.packages(c("psych"))
data("iris")
str(iris)
summary(iris)

set.seed(111)
ind <- sample(2, nrow(iris),
              replace = TRUE,
              prob = c(0.8, 0.2))

training <- iris[ind == 1, ]
testing <- iris[ind == 2, ]

dim(training)
testing <- iris [ind == 2, ]
dim(testing)
View(iris)
View(training)
View(testing)

install.packages("psych")
library(psych)

pairs.panels(training [, -5],
             gap = 0,
             bg = c("red", "yellow", "blue") [training$Species],
             pch = 21)

#only independent variable
pc <- prcomp(training[, -5],
             center = TRUE,
             scale = TRUE) #standard deviation

attributes(pc)
pc$center
print(pc)
summary(pc)
View(pc$x)

#Orthoganality of PCS
pairs.panels(pc$x,
             gap = 0,
             bg = c("red", "yellow", "blue") [training$Species],
             pch = 21)
View(pc$x)

#Predict with PC
trg <- predict(pc, training)
trg <- data.frame(trg, training[5]) #purpose of analysis add training data
tst <- predict(pc, testing)
tst <- data.frame(tst, testing[5])

#Multinomial Logistic regression with First two PCs
library(nnet)
trg$Species <- relevel(trg$Species, ref = "setosa")
mymodel = multinom(Species~PC1+PC2, data=trg)
summary(mymodel)

#confusion Matrix & Misclassification Error Training
p <- predict(mymodel, trg)
tab <- table(p, trg$Species)
tab
1-sum(diag(tab))/sum(tab)

p1 <- predict(mymodel, tst)
tab1 <- table(p1, tst$Species)
tab1
1-sum(diag(tab1))/sum(tab1)
