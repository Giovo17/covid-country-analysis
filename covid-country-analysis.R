library(ggplot2)
library(hrbrthemes)
library(GGally)
library(corrgram)
library(visdat)
library(ISLR2)
library(e1071)
library(caTools)
library(hopkins)
#library(randomForest)


# Import datasets from csv

# Source: https://www.kaggle.com/datasets/imdevskp/corona-virus-report?resource=download&select=country_wise_latest.csv

# Online from github repo
df = read.csv('https://raw.githubusercontent.com/Giovo17/covid-country-analysis/main/country_wise_latest.csv')

# Local from disk
#df = read.csv("country_wise_latest.csv")


head(df)
str(df)
summary(df)



df = df[!(df$Deaths...100.Recovered=="Inf" ),]




## MULTIVARIATE EDA

library(ellipse)
library(RColorBrewer)

# Build a Pannel of 100 colors with Rcolor Brewer
my_colors <- brewer.pal(5, "Spectral")
my_colors <- colorRampPalette(my_colors)(100)

# Order the correlation matrix
plotcorr(cor(df[2:14]) , col=my_colors[df*50+50] , mar=c(1,1,1,1)  )

heatmap(cor(df[2:14]))

library(reshape2)
melted_cormat <- melt(cormat)
head(melted_cormat)
x <- LETTERS[1:20]
y <- paste0("var", seq(1,20))
ggplot(cor(df[2:14]), aes(X, Y)) + 
  geom_tile()









## Linear regression

lm(formula = Deaths ~ Confirmed + Recovered + Active + New.cases + New.deaths + 
                      New.recovered + Deaths...100.Cases + Recovered...100.Cases + 
                      Deaths...100.Recovered + Confirmed.last.week + X1.week.change +
                      X1.week...increase, data=df)











