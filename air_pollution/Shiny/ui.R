library(shiny)

shinyUI(fluidPage(
  
  titlePanel(title = "PM2.5 Predictor"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file","Upload the file"),
      helpText("Default max. file size is 5MB"),
      tags$hr(),
      h5(helpText("Select the read.table parameters below")),
      checkboxInput(inputId = 'header', label = 'Header', value = FALSE),
      checkboxInput(inputId = 'stringAsFactors', label = 'stringAsFactors', FALSE),
      br(),
      radioButtons(inputId = 'sep', label = 'Separator', choices = c(Comma=',',Semicolon=';',Tab='\t',Space=''), selected = '\t')
      
    ),
    mainPanel(
      uiOutput("tb")
    )
    
  )
)
  
  
)
