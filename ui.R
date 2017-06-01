# Final project ui
library(shinythemes)
library(shiny)

shinyUI(navbarPage(theme = shinytheme("cerulean"),
  "Chronic Diseases in the US",
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
                    tabPanel("Diabetes", plotlyOutput("diabetesMap")),
                    tabPanel("Pulmonary", plotlyOutput("pulmonaryMap")),
                    tabPanel("Cardiovascular", plotlyOutput("cardiovascularMap"))
                    
                 ) 
                    
               )
               
             )
    ),
    tabPanel('Documentation',
          includeMarkdown("document.Rmd")
    ),
    tabPanel('Overview',
           includeMarkdown("overview.Rmd"))         
    
<<<<<<< HEAD
   
))


# The purpose of the project, source of the data, and any pertinent information about the topic area are introduced. You may also want to include links to the code, or information about the team.
=======
))
>>>>>>> updated documentation.rmd file with current documentation
