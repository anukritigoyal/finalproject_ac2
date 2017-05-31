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
               h2("Project Description"),
               h3("Purpose"),
               p("The purpose of our project was to depict the relationship between the existence of 
                 of chronic diseases and the different states that they exist in as well as the 
                 different groups of people the diseases affect annually. We chose to focus on 
                 Diabetes, Chronic Obstructive Pulmonary Disease and Cardiovascular Disease
                 as they lead to the most mortalities annually in the United States."),
               br(),
               h3("Data Source"),
               p("The data set that we worked with can be found at: https://catalog.data.gov/dataset/u-s-chronic-disease-indicators-cdi-e50c9"),
               p("The information was found in the Health section of Data.gov, however, was initially
                 published by the Centers for Disease Control and Prevention")
               
             )
    )
    
))


# The purpose of the project, source of the data, and any pertinent information about the topic area are introduced. You may also want to include links to the code, or information about the team.
