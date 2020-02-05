library(shiny)

shinyUI(fluidPage(
  
  titlePanel(title = "PM2.5 Predictor"),
  sidebarLayout(
    sidebarPanel("Data Values"),
    mainPanel("Accuracy of the prediction")
    
  )
)
  
  
)