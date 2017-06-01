library(plotly)
library(dplyr)

BuildGraph <- function(diabetes, pulmonary, cardio, year) {
  
}

diabetes.data <- diabetes %>% filter(YearStart == 2010, DataValueType == "Number", LocationDesc != "United States") %>% 
                  group_by(LocationDesc) %>% summarise(Diabetes = sum(DataValue, na.rm = TRUE))
  
cardiovascular.data <- cardiovascular %>% filter(YearStart == 2010, DataValueType == "Number", LocationDesc != "United States") %>% 
                        group_by(LocationDesc) %>% summarise(Cardiovascular = sum(DataValue, na.rm = TRUE))

pulmonary.data <- pulmonary %>% filter(YearStart == 2010, DataValueType == "Number", LocationDesc != "United States") %>% 
                    group_by(LocationDesc) %>% summarise(Pulmonary = sum(DataValue, na.rm = TRUE))

data <- left_join(diabetes.data, cardiovascular.data, by = "LocationDesc")
data <- left_join(data, pulmonary.data, by = "LocationDesc")

m <- list (
  l = 125,
  r = 0,
  b = 0,
  t = 0
)

graph <- plot_ly(data, y = ~LocationDesc, x = ~Diabetes, type = 'bar', name = 'Diabetes') %>%
          add_trace(x = ~Cardiovascular, name = 'Cardiovascular') %>%
          add_trace(x = ~Pulmonary, name = 'Pulmonary') %>%
          layout(xaxis = list(title = 'Number of Mortalities'), yaxis = list(title = 'State'),
                 barmode = 'stack', margin = m)