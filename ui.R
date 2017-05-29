# Final project ui

shinyUI(navbarPage("Chronic Diseases in the US",
    tabPanel('Diabetes',
             sidebarLayout(
               
               sidebarPanel(
                 
                 sliderInput(inputId = "diabetes.year", label = "Select Year", min = min(diabetes$YearStart),
                             max = max(diabetes$YearEnd), value = min(diabetes$YearStart), step = 1,
                             sep = ""
                             ),
                 
                 selectInput(inputId = "dstrat",label = "Select Stratification",
                             choices = list("Gender" = "Gender", "Race/Ethnicity" = "Race/Ethnicity",
                                            "Overall" = "Overall")
                             ),
                 
                 # Only show if stratification is gender
                 conditionalPanel(
                   condition = "input.dstrat == 'Gender'",
                   checkboxGroupInput(inputId = "dstrat.gender", label = "Select Gender",
                                      choices = list("Female" = "Female", "Male" = "Male"))
                   ),
                 
                 # Only show if stratification is race/ethnicity
                 conditionalPanel(
                   condition = "input.dstrat == 'Race/Ethnicity'",
                   checkboxGroupInput(inputId = "dstrat.race.ethnicity", label = "Select Race/Ehtnicity",
                                      choices = list("American Indian or Alaska Native" = "American Indian or Alaska Native",
                                                     "Asian or Pacific Islander" = "Asian or Pacific Islander",
                                                     "Hispanic"= "Hispanic",
                                                     "Black, non-Hispanic" = "Black, non-Hispanic",
                                                     "White, non-Hispanic" = "White, non-Hispanic"))
                   )
               ),
               
               mainPanel(
                 plotlyOutput("diabetesMap")
               )
               
             )
    )
))
