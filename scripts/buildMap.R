library(plotly)
library(dplyr)

BuildMap <- function(data, data.year, data.strat.category, data.strat.specific, type) {
  data <- data %>% select(YearStart, LocationAbbr, LocationDesc, Topic, DataValue,
                          DataValueType, DataValueUnit, StratificationCategory1, Stratification1)
  
  if(!is.null(data.strat.specific)) {
    data <- data %>% filter(YearStart == data.year) %>% filter(Stratification1 == data.strat.specific) %>%
      filter(DataValueType == "Number") %>% filter(LocationAbbr != "US")
  } else {
    data <- data %>% filter(YearStart == data.year) %>% filter(StratificationCategory1 == data.strat.category) %>%
      filter(DataValueType == "Number") %>% filter(LocationAbbr != "US")
  }
  
  # Previous line of code:
  # data <- data %>% filter(YearStart == data.year) %>% filter(StratificationCategory1 == data.strat.category) %>%
  #   filter(DataValueType == "Number") %>% filter(LocationAbbr != "US")
  
  
  data <- data %>% group_by(LocationAbbr) %>% summarise(newData = sum(DataValue, na.rm = TRUE))
  
  g <- list (
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showland = TRUE,
    landcolor = toRGB("gray85"),
    subunitwidth = 1,
    countrywidth = 1,
    subunitcolor = toRGB("white"),
    countrycolor = toRGB("white")
  )
  
  map <- plot_geo(data, locationmode = 'USA-states') %>%
    add_trace(
      z = ~newData, color = ~newData,
      locations = ~LocationAbbr, colors = 'Blues'
    ) %>%
    colorbar(title = "cases per 100,000 people") %>%
    layout(
      title = 'Mortality Rates in the United States',
      geo = g
    )
  return(map)
}
