library(plotly)
library(ggplot2)
library(scales)
library(dplyr)
##
rm(list=ls())
##
var_1<- rnorm(100,10,5)
var_2 <- sample( LETTERS[1:4], 100, replace=TRUE, prob=c(0.1, 0.2, 0.65, 0.05) )

df = data.frame(var_1, var_2)
df$var_2 = as.factor(df$var_2)


 plot_ly(df,
              y = ~var_1,
              color = ~var_2,
              type = "box") %>% 
  layout(title = "Income by career stage",
         xaxis = list(title = "Stage",
                      zeroline = FALSE),
         yaxis = list(title = "Income",
                      zeroline = FALSE))
###
### GGPLO2
ggplot() +geom_boxplot(aes(x=var_1,col=var_2))  +
  labs(title="GGPLot Example of Boxplot") +
  geom_vline(xintercept = 0) + coord_flip()
## Convert ggolot2 plot o Plotly
ggplotly(plot1)
