# Final project ui
library(shiny)

shinyUI(navbarPage("Chronic Diseases in the US",
    tabPanel('Graphics',
             sidebarLayout(
               
               sidebarPanel(
                 
                 sliderInput(inputId = "diabetes.year", label = "Select Year", min = min(diabetes$YearStart),
                             max = max(diabetes$YearEnd), value = min(diabetes$YearStart), step = 1,
                             sep = ""
                             ),
                 
                 selectInput(inputId = "dstrat",label = "Select Stratification",
                             choices = list("Gender" = "Gender", "Race/Ethnicity" = "Race/Ethnicity",
                                            "Overall" = "Overall"),
                             selected = "Overall"
                             ),
                 
                 uiOutput("myui")

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
             mainPanel(
               h1("Project Documentation"),
               h5("Created by: Anukriti Goyal, Kristine Ly, Tina Zhuang & Simin Huan"),
               br(),
               h2("Project Description")
               
             )
    )
    
))
