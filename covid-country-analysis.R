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

library(reshape2)
melted_cormat <- melt(cor(df[2:14]))
head(melted_cormat)


ggplot(data = melted_cormat, aes(x=Var1, y=Var2, fill=value)) + 
  geom_tile()



## DIMENSIONALITY REDUCTION

df_num = df[2:14]

df_scaled = scale(df_num)

corr_mat = cor(df_scaled)
eig = eigen(corr_mat)

PVE = eig$values/sum(eig$values)
PVE

cumsum(PVE)


df_pca = prcomp(df_scaled)

# compute total variance
variance = df_pca$sdev^2 / sum(df_pca$sdev^2)

# Scree plot
qplot(c(1:13), variance) +
  geom_line() +
  geom_point(size=4)+
  xlab("Principal Component") +
  ylab("Variance Explained") +
  ggtitle("Scree Plot") +
  ylim(0, 1)




## LINEAR REGRESSION

linear_model = lm(formula = Deaths ~ Confirmed + Recovered + Active + New.cases + New.deaths + 
                      New.recovered + Deaths...100.Cases + Recovered...100.Cases + 
                      Deaths...100.Recovered + Confirmed.last.week + X1.week.change +
                      X1.week...increase, data=df)

summary(linear_model)










