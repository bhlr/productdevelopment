#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {

    observe({
        query <- parseQueryString(session$clientData$url_search)
        bins <- query[["bins"]]
        bar_col <-query[["color"]]
        if(!is.null(bins)) {
            updateSliderInput(session,'bins', value = as.numeric(bins))
        }
        if(!is.null(bar_col)) {
            updateSelectInput(session,'set_col', selected = bar_col)
        }
    })
    
    observe({
      bins <- input$bins
      color <- input$set_col
      host_name <- session$clientData$url_hostname
      protocol <- session$clientData$url_protocol
      port <- session$clientData$url_port
      query <- paste('?','bins=',bins,'&','color=',color,sep = '')
      url <- paste(protocol,'//',host_name,':',port,'/',query,sep='')
      updateTextInput(session,'url_param', value=url)
      
    })
    
    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = input$set_col, border = 'white')

    })
    
  

})
