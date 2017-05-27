library(plotly)
library(dplyr)

BuildMap <- function(data, data.year) {
  
}

diabetes <- diabetes.data %>% select(YearStart, LocationAbbr, LocationDesc, Topic, DataValue,
                                     DataValueType, DataValueUnit,
                                     StratificationCategory1, Stratification1)
diabetes <- diabetes %>% filter(YearStart == "2010") %>% filter(StratificationCategory1 == "Overall") %>%
  filter(DataValueType == "Number")

diabetes <- diabetes %>% group_by(LocationAbbr) %>% summarise(DataValue = max(DataValue, na.rm = TRUE))



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

map <- plot_geo(diabetes, locationmode = 'USA-states') %>%
  add_trace(
    z = ~DataValue, color = ~DataValue,
    locations = ~LocationAbbr, colors = 'Blues'
  ) %>%
  colorbar(title = "cases per 100,000 people") %>%
  layout(
    title = 'Mortality Rates of <enter disease here> in <enter year here>',
    geo = g
  )

