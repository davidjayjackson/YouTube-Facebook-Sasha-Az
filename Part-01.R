library(xts)
library(ggplot2)
## Scales Library: format x and y labels
library(scales)
library(dplyr)
library(plotly)

#create data
##
## time series 1
##
rm(list=ls())
date_decision_made <- seq(as.Date("2014-01-01"), as.Date("2016-01-01"),by="day")
class(date_decision_made)

# date_decision_made <- format(as.Date(date_decision_made), "%Y/%m/%d")

property_damages_in_dollars <- rnorm(731,100,10)
str(property_damages_in_dollars)

final_data <- data.frame(date_decision_made, property_damages_in_dollars)

final_data <- final_data %>%
  mutate(date_decision_made = as.Date(date_decision_made)) %>%
  add_count(week = format(date_decision_made, "%Y-%W"))

final_data$class <- "time_series_1"

##
### time series 2
##
date_decision_made <- seq(as.Date("2014-01-01"), as.Date("2016-01-011"),by="day")

#date_decision_made <- format(as.Date(date_decision_made), "%Y/%m/%d")

property_damages_in_dollars <- rnorm(731,10,10)

final_data_2 <- data.frame(date_decision_made, property_damages_in_dollars)

final_data_2 <- final_data_2 %>%
  mutate(date_decision_made = as.Date(date_decision_made)) %>%
  add_count(week = format(date_decision_made, "%Y-%W"))

final_data_2$class <- "time_series_2"

#combine
data = rbind(final_data, final_data_2)