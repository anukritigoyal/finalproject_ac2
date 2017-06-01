# Final project ui
#install.packages("shinythemes")
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
                    tabPanel("Diabetes", br(), br(), plotlyOutput("diabetesMap")),
                    tabPanel("Pulmonary", br(), br(),plotlyOutput("pulmonaryMap")),
                    tabPanel("Cardiovascular", br(), br(),plotlyOutput("cardiovascularMap"))
                    
                 ) 
                    
               )
               
             )
    ),
    tabPanel('Documentation',
<<<<<<< HEAD
          includeMarkdown("documentation.Rmd")
    )       
))
=======
          includeMarkdown("document.Rmd")
    )
  
  
    
   
))


# The purpose of the project, source of the data, and any pertinent information about the topic area are introduced. You may also want to include links to the code, or information about the team.
>>>>>>> new
