# Final project ui

library(shinythemes)
library(shiny)
library(markdown)
library(plotly)

shinyUI(navbarPage(theme = shinytheme("cerulean"),
  "Chronic Diseases in the US",
    tabPanel('Overview',
             sidebarLayout(
               sidebarPanel(
                 sliderInput(inputId = "year", label = "Select Year", min = min(diabetes$YearStart),
                             max = max(diabetes$YearEnd), value = min(diabetes$YearStart), step = 1,
                             sep = ""
                             )
               ),
               mainPanel(
                 plotlyOutput("overviewMap", width = "100%")
               )
             ),
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
                               in the past 20 years.It is projected by the CDC that 1 in 3 adults could have diabetes by 2050. The map above
                               shows the mortality rates for any kind of diabetes. The mortality rate has slowly increased from 2010 to 2014 
                               especially in California, Texas and the Northeast."),
                             p("*Note: States with no deaths mean that no data was collected in that state due to too few respondents or cases")),
                    
                    tabPanel("Pulmonary Disease", br(), br(),plotlyOutput("pulmonaryMap"),
                             p("Chronic Obstructive Pulmonary Disease (COPD) is the third leading cause of death in the United States 
                               as almost 6.4% of the population had been diagnosed with it in 2014. The map above shows the mortality rates
                               for adults with COPD as the underlying cause of their death, over the age of 45. Mortality rates increased
                               from 2010 to 2013 but in California, Texas and Florida, where COPD mortality rates are the highest, the 
                               number of deaths decreased from 2013 to 2014."),
                             p("*Note: States with no deaths mean that no data was collected in that state due to too few respondents or cases")),
                    
                    tabPanel("Cardiovascular Disease", br(), br(),plotlyOutput("cardiovascularMap"),
                             p("In the United States, about every 1 in 4 deaths each year are due to Cardiovascular Disease. 
                               Every year, about 735,000 Americans suffer from a heart attack. The map above shows the mortality rates 
                               for adults who died from any kind of heart disease such as coronary heart disease or a heart failure.
                               Mortality rates slowly increased from 2010 to 2014, however in states such as California and New York, 
                               the mortality rate decreased from 2013 to 2014."),
                             p("*Note: States with no deaths mean that no data was collected in that state due to too few respondents or cases"))
                 ) 
                    
               )
               
             )
    ),
    tabPanel('Documentation',
          includeMarkdown("documentation.Rmd")
    )       
))
