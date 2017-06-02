# Function that builds the visualizations of the map

library(plotly)
library(dplyr)

# Function takes in the data set for the disease, the year and stratification of concern
BuildMap <- function(given.data, data.year, data.stratification, map.type, graph.title, max.count) {
  
  # Filters the data so that the dataframe consists of relevant data that will be used in the plot
  data <- given.data %>% select(YearStart, LocationAbbr, LocationDesc, Topic, DataValue,
                          DataValueType, DataValueUnit, Stratification1)
  
  data <- data %>% filter(YearStart == data.year) %>% filter(Stratification1 %in% data.stratification) %>%
    filter(DataValueType == map.type) %>% filter(LocationAbbr != "US")
  
  data <- data %>% group_by(LocationDesc) %>% summarise(newData = sum(DataValue, na.rm = TRUE))
  
  #data$hover <- with(data, paste0("Mortality rate in ", data.year, " for ", graph.title, "<br>",
   #                               "in ", LocationDesc, "<br>",
  #                                "Data Stratification Group: ", data.stratification))
  
  # Finds the highest and lowest number of deaths in the given data, based on the selected stratification
  data.range <- given.data %>%
    select(YearStart, DataValue, DataValueType, Stratification1) %>%
    filter(Stratification1 == data.stratification & DataValueType == map.type)
  
  min.count <- 0
  if (!any(is.na(data.range$DataValue))) {
    data.range <- na.omit(data.range)
    min.count <- min(data.range$DataValue)
  }
  
  # Properties of the choropleth map
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
      locations = ~LocationDesc, colors = 'Blues'
    ) %>%
    colorbar(title = "Cases", limits = c(min.count, max.count)) %>%
    layout(
      title = paste0('Mortality in the United States Due to ', graph.title),
      geo = g
    )
  return(map)
}
