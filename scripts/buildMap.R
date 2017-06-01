# Function that builds the visualizations of the map

library(plotly)
library(dplyr)

# Function takes in the data set for the disease, the year and stratification of concern
BuildMap <- function(data, data.year, data.stratification, max) {
  
  # Filters the data so that the dataframe consists of relevant data that will be used in the plot
  data <- data %>% select(YearStart, LocationAbbr, LocationDesc, Topic, DataValue,
                          DataValueType, DataValueUnit, Stratification1)
  
  data <- data %>% filter(YearStart == data.year) %>% filter(Stratification1 %in% data.stratification) %>%
    filter(DataValueType == "Number") %>% filter(LocationAbbr != "US")
  
  data <- data %>% group_by(LocationAbbr) %>% summarise(newData = sum(DataValue, na.rm = TRUE))
  
  # Properties of the choloropleth map
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
  
  # Creates the map with the given values
  map <- plot_geo(data, locationmode = 'USA-states') %>%
    add_trace(
      z = ~newData, color = ~newData,
      locations = ~LocationAbbr, colors = 'Blues'
    ) %>%
    colorbar(title = "cases per 100,000 people", limits = c(0, max)) %>%
    layout(
      title = 'Mortality Rates in the United States',
      geo = g
    )
  return(map)
}
