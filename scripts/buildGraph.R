# Builds a bar chart showing the mortality in each state due to a chronic disease in a given year

library(plotly)
library(dplyr)

BuildGraph <- function(diabetes, pulmonary, cardio, year) {
  
  # Initial data files are rendered to provide data specific for this plot 
  diabetes.data <- diabetes %>% filter(YearStart == year, DataValueType == "Number", LocationDesc != "United States") %>% 
                    group_by(LocationDesc) %>% summarise(Diabetes = sum(DataValue, na.rm = TRUE))
  
  cardiovascular.data <- cardiovascular %>% filter(YearStart == year, DataValueType == "Number", LocationDesc != "United States") %>% 
                          group_by(LocationDesc) %>% summarise(Cardiovascular = sum(DataValue, na.rm = TRUE))
  
  pulmonary.data <- pulmonary %>% filter(YearStart == year, DataValueType == "Number", LocationDesc != "United States") %>% 
                      group_by(LocationDesc) %>% summarise(Pulmonary = sum(DataValue, na.rm = TRUE))
  
  data <- left_join(diabetes.data, cardiovascular.data, by = "LocationDesc")
  data <- left_join(data, pulmonary.data, by = "LocationDesc")
  
  # Margins for the plot 
  m <- list (
    l = 125,
    r = 0,
    t = 0,
    b = 50,
    pad = 4
  )
  
  # Creates a stacked bar plot
  graph <- plot_ly(data, y = ~LocationDesc, x = ~Diabetes, type = 'bar', name = 'Diabetes') %>%
    add_trace(x = ~Cardiovascular, name = 'Cardiovascular') %>%
    add_trace(x = ~Pulmonary, name = 'Pulmonary') %>%
    layout(xaxis = list(title = 'Total Number of Mortalities'), yaxis = list(title = 'State'),
           barmode = 'stack', margin = m, height = 800)
  
  return(graph)
}

