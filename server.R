# Final project server

library(dplyr)
library(plotly)
library(shiny)

source("./scripts/buildMap.R")

# Data
cardiovascular <- read.csv("./cardiovascular.csv", stringsAsFactors = FALSE)
diabetes <- read.csv("./diabetes.csv", stringsAsFactors = FALSE)
pulmonary <- read.csv("./pulmonary.csv", stringsAsFactors = FALSE)
cardiovascular <- read.csv("./cardiovascular.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output, session) {
  
  output$myui <- renderUI({
    if(input$dstrat == "Gender") {
      checkboxGroupInput(inputId = "dstrat.gender", label = "Select Gender",
                         choices = list("Female" = "Female", "Male" = "Male"),
                         selected = c("Female", "Male"))
    } else if(input$dstrat == "Race/Ethnicity") {
      checkboxGroupInput(inputId = "dstrat.race.ethnicity", label = "Select Race/Ethnicity",
                         choices = list("American Indian or Alaska Native" = "American Indian or Alaska Native",
                                        "Asian or Pacific Islander" = "Asian or Pacific Islander",
                                        "Hispanic"= "Hispanic",
                                        "Black, non-Hispanic" = "Black, non-Hispanic",
                                        "White, non-Hispanic" = "White, non-Hispanic"),
                         selected = c("American Indian or Alaska Native", "Asian or Pacific Islander",
                                      "Hispanic", "Black, non-Hispanic", "White, non-Hispanic"))
    }
  })
  
  output$diabetesMap <- renderPlotly({
    if (is.null(input$dstrat.gender) && is.null(input$dstrat.race.ethnicity)) {
      # Debugging tools  filtering by overall
      print(paste0("input$dstrat: ", input$dstrat))
      print(paste0("input$dstrat.gender: ", input$dstrat.gender))
      print(paste0("input$dstrat.race.ethnicity ", input$dstrat.race.ethnicity))

      mapping <- BuildMap(diabetes, input$diabetes.year, input$dstrat)
    } else if(!is.null(input$dstrat.gender)) {
      # Debugging tools   filter by gender
      print(paste0("input$dstrat: ", input$dstrat))
      print(paste0("input$dstrat.gender: ", input$dstrat.gender))
      print(paste0("input$dstrat.race.ethnicity ", input$dstrat.race.ethnicity))

      mapping <- BuildMap(diabetes, input$diabetes.year, input$dstrat.gender)
    } else {
      # Debugging tools   filter by race/ethnicity
      print(paste0("input$dstrat: ", input$dstrat))
      print(paste0("input$dstrat.gender: ", input$dstrat.gender))
      print(paste0("input$dstrat.race.ethnicity ", input$dstrat.race.ethnicity))

      mapping <- BuildMap(diabetes, input$diabetes.year, input$dstrat.race.ethnicity)
    }
    
    # Previous line of code:
    # mapping <- BuildMap(diabetes, input$diabetes.year, input$dstrat)
    #mapping
  })
  
  
  
  
  
  output$pulmonaryMap <- renderPlotly({
    if (is.null(input$dstrat.gender) && is.null(input$dstrat.race.ethnicity)) {
      mapping <- BuildMap(pulmonary, input$diabetes.year, input$dstrat)
    } else if(is.null(input$dstrat.gender)) {
      mapping <- BuildMap(pulmonary, input$diabetes.year, input$dstrat, input$dstrat.race.ethnicity)
    } else {
      mapping <- BuildMap(pulmonary, input$diabetes.year, input$dstrat, input$dstrat.gender)
    }
  })
  
  output$cardiovascularMap <- renderPlotly({
    if (is.null(input$dstrat.gender) && is.null(input$dstrat.race.ethnicity)) {
      mapping <- BuildMap(cardiovascular, input$diabetes.year, input$dstrat)
    } else if(is.null(input$dstrat.gender)) {
      mapping <- BuildMap(cardiovascular, input$diabetes.year, input$dstrat, input$dstrat.race.ethnicity)
    } else {
      mapping <- BuildMap(cardiovascular, input$diabetes.year, input$dstrat, input$dstrat.gender)
    }
  })
  
})