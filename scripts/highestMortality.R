# Finds the highest number of deaths in the given data, based on the selected stratification

library(dplyr)

HighestMortality <- function(data, stratification) {
  
  data.maximum <- data %>%
    select(YearStart, DataValue, DataValueType, Stratification1) %>%
    filter(Stratification1 == stratification & DataValueType == "Number") %>%
    na.omit()
  
  return(max(data.maximum$DataValue))
  
}