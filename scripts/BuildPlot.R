library(plotly)
library(dplyr)

BuildPlot <- function(data1, data2, data3, data.year) {
  
  avg1 <- data1 %>% filter(YearStart == data.year) %>% 
    filter(DataValueType == "Number") %>%  filter(!is.na(DataValue)) %>% summarise(avg = mean(DataValue))
  
  avg2 <- data2 %>% filter(YearStart == data.year) %>% 
    filter(DataValueType == "Number") %>%  filter(!is.na(DataValue)) %>%summarise(avg= mean(DataValue))
  
  avg3 <- data3 %>% filter(YearStart == data.year) %>% 
    filter(DataValueType == "Number") %>%  filter(!is.na(DataValue)) %>% summarise(avg = mean(DataValue))
  
  numbers <- c(avg1, avg2, avg3)
  diseases <- c(data1$Topic, data2$Topic, data3$Topic)
  #data <- data.frame(diseases, numbers)
  
  #bar chart comparing ave mortality rate of different disease in different years
  m <- list(
    l = 150,
    r = 50,
    b = 100,
    t = 100,
    pad = 4
  )
   p <- plot_ly( x = ~numbers,
                 y = ~diseases,
                 name = 'Average Mortality Rate',
                 type= "bar" ) %>%
     layout(autosize = F, width = 500, height = 500, margin = m,xaxis = list(title = 'Average Mortality'), yaxis = list(title = " "))

  return(p)
}

