library(shiny)
options(shiny.maxRequestSize = 9*1024^2)

shinyServer(
  function(input,output){
    data <- reactive({
      file1 <- input$file
      if(is.null(file1)){return()}
      read.table(file = file1$datapath, sep = input$sep, header = input$header, stringsAsFactors = input$stringAsFactors)
      
    })
      
    output$filedf <- renderTable({
      if(is.null(data())){return()}
      input$file
    })
   
    output$sum <- renderTable({
      if(is.null(data())){return()}
      summary(data())
      
    }) 
    
    output$table <- renderTable({
      if(is.null(data())){return()}
      data()
    })
    output$tb <- renderUI({
      if(is.null(data()))
        h5("Powered by", tags$img(src = 'Rstudio-Ball.png', height=200, width=200))
      else
        tabsetPanel(tabPanel("About file", tableOutput("filedf")),tabPanel("Data", tableOutput("table")),tabPanel("Summary", tableOutput("sum")))
      
    })
    
    
  }
  
  
)