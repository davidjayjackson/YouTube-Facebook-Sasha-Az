library(xts)
library(ggplot2)
## Scales Library: format x and y labels
library(scales)
library(dplyr)
library(plotly)

#part 1:

data <- data %>%
  mutate(tmp_date = as.numeric(as.Date(date_decision_made, format = "%Y-%m-%d")))
##
### Code is hanging on this function
##
accumulate_by <- function(dat, var) {
  var <- lazyeval::f_eval(var, dat)
  lvls <- plotly:::getLevels(var)
  dats <- lapply(seq_along(lvls), function(x) {
    cbind(dat[var %in% lvls[seq(1, x)], ], frame = lvls[[x]])
  })
  dplyr::bind_rows(dats)
}

data <- data %>% accumulate_by(~tmp_date)
### 
###
data %>%
  plot_ly(
    x = ~tmp_date, 
    y = ~property_damages_in_dollars,
    split = ~class,
    frame = ~frame, 
    type = 'scatter',
    mode = 'lines', 
    line = list(simplyfy = F)
  )



#### Run Part 2
##
#part 2

updatemenus <- list(
  list(
    active = -1,
    type= 'buttons',
    buttons = list(
      list(
        label = "time_series_1",
        method = "update",
        args = list(list(visible = c(FALSE, TRUE)),
                    list(title = "series 1",
                         annotations = list(c(), high_annotations)))),
      list(
        label = "time_series_2",
        method = "update",
        args = list(list(visible = c(TRUE, FALSE)),
                    list(title = "series 2",
                         annotations = list(low_annotations, c() )))),
      
    )
  )
  
)

## Gettig rid of the  "fig"
data %>% plot_ly(type = 'scatter', mode = 'lines') %>%
add_lines(x=~date_decision_made,
                         y=~property_damages_in_dollars, name="High",
                         line=list(color="#33CFA5")) %>%
                          add_lines(x=~date_decision_made, 
                         y=~property_damage_in_dollars, name="Low",
                         line=list(color="#F06A6A")) %>%
                         layout(title = "Apple", showlegend=FALSE,
                          xaxis=list(title="Date"),
                          yaxis=list(title="Price ($)"),
                          updatemenus=updatemenus)



