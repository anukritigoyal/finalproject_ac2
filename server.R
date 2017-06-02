# Final project server

library(dplyr)
library(plotly)
library(shiny)

source("./scripts/buildMap.R")
# source("./scripts/highestMortality.R")
source("./scripts/buildGraph.R")

# Reads in relevant data
cardiovascular <- read.csv("./cardiovascular.csv", stringsAsFactors = FALSE)
diabetes <- read.csv("./diabetes.csv", stringsAsFactors = FALSE)
pulmonary <- read.csv("./pulmonary.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  
  # Generates a dynamic UI that allows users to choose specific stratifications if either
  # Gender or Race/Ethnicity is selected
  output$specificGroups <- renderUI({
    if(input$stratification == "Gender") {
      radioButtons(inputId = "strat.specify", label = "Select Gender",
                   choices = list("Female" = "Female", "Male" = "Male"),
                   selected = "Female")
    } else if(input$stratification == "Race/Ethnicity") {
      radioButtons(inputId = "strat.specify", label = "Select Race/Ethnicity",
                   choices = list("American Indian or Alaska Native" = "American Indian or Alaska Native",
                                  "Asian or Pacific Islander" = "Asian or Pacific Islander",
                                  "Hispanic"= "Hispanic", "Black, non-Hispanic" = "Black, non-Hispanic",
                                  "White, non-Hispanic" = "White, non-Hispanic"),
                   selected = "American Indian or Alaska Native")
    }
  })
  
  output$overviewMap <- renderPlotly({
    graph <- BuildGraph(diabetes, pulmonary, cardiovascular, input$year)
  })

  # Creates the map for Diabetes
  output$diabetesMap <- renderPlotly({
    if (input$stratification == "Overall") {
      mapping <- BuildMap(diabetes, input$chosen.year, input$stratification, input$map.type, "Diabetes")
    } else {
      mapping <- BuildMap(diabetes, input$chosen.year, input$strat.specify, input$map.type, "Diabetes")
    }
  })
  
  # Creates the map for Chronic Obstructive Pulmonary Disease
  output$pulmonaryMap <- renderPlotly({
    if (input$stratification == "Overall") {
      mapping <- BuildMap(pulmonary, input$chosen.year, input$stratification, input$map.type, "COPD")
    } else {
      mapping <- BuildMap(pulmonary, input$chosen.year, input$strat.specify, input$map.type, "COPD")
    }
  })

  # Creates the map for Cardiovascular Disease
  output$cardiovascularMap <- renderPlotly({
    if (input$stratification == "Overall") {
      mapping <- BuildMap(cardiovascular, input$chosen.year, input$stratification, input$map.type, 
                          "Cardiovascular Disease")
    } else {
      mapping <- BuildMap(cardiovascular, input$chosen.year, input$strat.specify, input$map.type,
                          "Cardiovascular Disease")
    }
  })
  
})