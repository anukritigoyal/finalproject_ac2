# Final project ui

library(shinythemes)
library(shiny)
library(markdown)

shinyUI(navbarPage(theme = shinytheme("cerulean"),
  "Chronic Diseases in the US",
    tabPanel('Overview',
           includeMarkdown("overview.Rmd")
    ),
    tabPanel('Graphics',
             sidebarLayout(
               
               sidebarPanel(
                 
                 sliderInput(inputId = "chosen.year", label = "Select Year", min = min(diabetes$YearStart),
                             max = max(diabetes$YearEnd), value = min(diabetes$YearStart), step = 1,
                             sep = ""
                             ),
                 
                 selectInput(inputId = "stratification",label = "Select Stratification",
                             choices = list("Gender" = "Gender", "Race/Ethnicity" = "Race/Ethnicity",
                                            "Overall" = "Overall"),
                             selected = "Overall"
                             ),
                 
                 uiOutput("specificGroups")

               ),
               
               mainPanel(
                 
                 tabsetPanel(
                    tabPanel("Diabetes", br(), br(), plotlyOutput("diabetesMap"),
                             p("Diabetes is the seventh leading cause of death in the United States and its occurrence has almost doubled 
                               in the past 20 years.It is projected by the CDC that 1 in 3 adults could have diabetes by 2050.")),
                    tabPanel("Pulmonary", br(), br(),plotlyOutput("pulmonaryMap"),
                             p("Chronic Obstructive Pulmonary Disease (COPD) is the third leading cause of death in the United States 
                               as almost 6.4% of the population had been diagnosed with it in 2014.")),
                    tabPanel("Cardiovascular", br(), br(),plotlyOutput("cardiovascularMap"),
                             p("In the United States, about every 1 in 4 deaths each year are due to Cardiovascular Disease. 
                               Every year, about 735,000 Americans suffer from a heart attack."))
                    
                 ) 
                    
               )
               
             )
    ),
    tabPanel('Documentation',
          includeMarkdown("documentation.Rmd")
    )       
))
