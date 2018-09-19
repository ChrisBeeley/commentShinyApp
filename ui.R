fluidPage(
  
  title = ("Comments application"),
  
  fluidRow(
    column(2, selectInput("directorate", "Directorate:", 
                          unique(testData$Directorate2))),
    
    column(5, dataTableOutput("bestComments")),
    
    column(5, dataTableOutput("improveComments"))
  ),
  
  fluidRow(
    column(5, textOutput("bestText"), offset = 2)
  )
)