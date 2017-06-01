# Final project ui
library(shiny)

shinyUI(navbarPage("Chronic Diseases in the US",
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
             mainPanel(
               h1("Project Documentation", style = "font-family: 'trebuchet ms';"),
               h5("Created by: Anukriti Goyal, Kristine Ly, Tina Zhuang & Simin Huan", style = "font-family: 'trebuchet ms';"),
               br(),
               h2("Project Description", style = "font-family: 'trebuchet ms';"),
               h3("Purpose", style = "font-family: 'trebuchet ms';"),
               p("The purpose of our project was to depict the relationship between the existence of 
                 of chronic diseases and the different states that they exist in, as well as the 
                 different groups of people the diseases affect annually. We chose to focus on 
                 Diabetes, Chronic Obstructive Pulmonary Disease and Cardiovascular Disease
                 as they had the most annual indicators of mortality in the United States. We were 
                 interested in seeing the change in the mortality rate as developments in 
                 healthcare advanced over the years and health officials continuous actions
                 lead to improvements in healthcare services ", style = "font-family: 'trebuchet ms';"),
               br(),
               h3("Data Source", style = "font-family: 'trebuchet ms';"),
               p("The data set that we worked with can be found at: https://catalog.data.gov/dataset/u-s-chronic-disease-indicators-cdi-e50c9",
                 style = "font-family: 'trebuchet ms';"),
               p("The information was found in the Health section of Data.gov, however, it was initially
                 published by the Centers for Disease Control and Prevention", style = "font-family: 'trebuchet ms';")
             )
    )
    
))


# The purpose of the project, source of the data, and any pertinent information about the topic area are introduced. You may also want to include links to the code, or information about the team.
