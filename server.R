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

shinyServer(function(input, output) {
  
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
      # Debugging tools
      # print("both are null")
      # print(is.null(input$dstrat.gender))
      mapping <- BuildMap(diabetes, input$diabetes.year, input$dstrat)
    } else if(is.null(input$dstrat.gender)) {
      # Debugging tools
      # print("gender is null")
      # print(is.null(input$dstrat.gender))
      mapping <- BuildMap(diabetes, input$diabetes.year, input$dstrat, input$dstrat.race.ethnicity)
    } else {
      # Debugging tools
      # print("race/ethnicty is null")
      # print(is.null(input$dstrat.race.ethnicity))
      mapping <- BuildMap(diabetes, input$diabetes.year, input$dstrat, input$dstrat.gender)
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