# Final project server

library(dplyr)
library(plotly)
library(shiny)

source("./scripts/buildMap.R")

# Data
cardiovascular <- read.csv("./cardiovascular.csv", stringsAsFactors = FALSE)
diabetes <- read.csv("./diabetes.csv", stringsAsFactors = FALSE)
pulmonary <- read.csv("./pulmonary.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output, session) {
  
  output$myui <- renderUI({
    if(input$dstrat == "Gender") {
      checkboxGroupInput(inputId = "dstrat.specify", label = "Select Gender",
                         choices = list("Female" = "Female", "Male" = "Male"),
                         selected = c("Female", "Male"))
    } else if(input$dstrat == "Race/Ethnicity") {
      checkboxGroupInput(inputId = "dstrat.specify", label = "Select Race/Ethnicity",
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
    if (input$dstrat == "Overall") {
      # Debugging tool:
      # print(paste0("input$dstrat: ", input$dstrat))
      mapping <- BuildMap(diabetes, input$diabetes.year, input$dstrat)
    } else {
      # Debugging tool:
      # print(paste0("input$dstrat: ", input$dstrat))
      # print(paste0("input$dstrat.specify: ", input$dstrat.specify))
      mapping <- BuildMap(diabetes, input$diabetes.year, input$dstrat.specify)
    }
  })
  
  
  output$pulmonaryMap <- renderPlotly({
    if (input$dstrat == "Overall") {
      mapping <- BuildMap(pulmonary, input$diabetes.year, input$dstrat)
    } else {
      mapping <- BuildMap(pulmonary, input$diabetes.year, input$dstrat.specify)
    }
  })

  output$cardiovascularMap <- renderPlotly({
    if (input$dstrat == "Overall") {
      mapping <- BuildMap(cardiovascular, input$diabetes.year, input$dstrat)
    } else {
      mapping <- BuildMap(cardiovascular, input$diabetes.year, input$dstrat.specify)
    }
  })
  
})