# Final project server

library(dplyr)
library(plotly)
library(shiny)

source("./scripts/buildMap.R")

# Data
cardiovascular <- read.csv("./cardiovascular.csv", stringsAsFactors = FALSE)
diabetes <- read.csv("./diabetes.csv", stringsAsFactors = FALSE)
pulmonary <- read.csv("./pulmonary.csv", stringsAsFactors = FALSE)


shinyServer(function(input, output) {
  
  output$diabetesMap <- renderPlotly({
    # if (is.null(input$dstrat.gender) && is.null(input$dstrat.race.ethnicity)) {
    #   mapping <- BuildMap(diabetes, input$diabetes.year, input$dstrat)
    # } else if(is.null(input$dstrat.gender)) {
    #   mapping <- BuildMap(diabetes, input$diabetes.year, input$dstrat.gender)
    # } else {
    #   mapping <- BuildMap(diabetes, input$diabetes.year, input$dstrat.race.ethnicity)
    # }
    
    mapping <- BuildMap(diabetes, input$diabetes.year, input$dstrat)
    mapping
  })
  
  
})