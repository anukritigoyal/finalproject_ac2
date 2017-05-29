shinyUI(navbarPage("Chronic Diseases in the US",
                   tabPanel('Diabetes'),
                   
                   sidebarLayout(
                     
                     sidebarPanel(
                       
                       sliderInput("year", label = "Select Year")
                     )
                   )
  
))
