#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
  vals <- reactiveValues(
    keeprows = rep(TRUE, nrow(mtcars)),
    grayrows  = rep(TRUE, nrow(mtcars))
  )
 
   
    observeEvent(input$clk, {
      df <- nearPoints(mtcars, input$clk,xvar='wt',yvar='mpg',allRows = TRUE)
      vals$keeprows <- xor(vals$keeprows, df$selected_)
      output$mtcars_tbl <- DT::renderDataTable({
        mtcars[!vals$keeprows, , drop = FALSE]
      })
    })
    observeEvent(input$mouse_brush, {
      df <- brushedPoints(mtcars, input$mouse_brush,xvar='wt',yvar='mpg',allRows = TRUE)
      vals$keeprows <- xor(vals$keeprows, df$selected_)
      output$mtcars_tbl <- DT::renderDataTable({
        mtcars[!vals$keeprows, , drop = FALSE]
      })
    })
    observeEvent(input$dclk, {
      df <- nearPoints(mtcars, input$dclk,xvar='wt',yvar='mpg',maxpoints=1,allRows = TRUE)
      vals$keeprows <- xor(vals$keeprows, df$selected_)
    })
    observeEvent(input$mouse_hover, {
      df <- nearPoints(mtcars, input$mouse_hover,xvar='wt',yvar='mpg',maxpoints=1,allRows = TRUE)
      vals$grayrows <- xor(vals$grayrows, df$selected_)
    })
    output$plot_click_options <-renderPlot({
        keep    <- mtcars[ vals$keeprows, , drop = FALSE]
        clicked <- mtcars[!vals$keeprows, , drop = FALSE]
        grayed <- mtcars[!vals$grayrows, , drop = FALSE]
        ggplot(data = keep, aes(x = wt, y = mpg)) + geom_point() +
          geom_point(data = clicked, color = "green")
    })
    
    output$click_data <- renderPrint({
        rbind(
            c(input$clk$x,input$clk$y),
            c(input$dclk$x,input$dclk$y),
            c(input$mouse_hover$x,input$mouse_hover$y),
            c(input$mouse_brush$xmin,input$mouse_brush$ymin),
            c(input$mouse_brush$xmax,input$mouse_brush$ymax)
            
        )
    })
    
    output$mtcars_tbl <- DT::renderDataTable({
      mtcars
    })
    
  #  output$mtcars_tbl <- DT::renderDataTable({
   #     #df <- nearPoints(mtcars, input$clk,xvar='wt',yvar='mpg')
   #     df <- brushedPoints(mtcars,input$mouse_brush,
   #                         xvar = 'wt', yvar = 'mpg')
    #    df
  #  })

})
