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
    keeprows = rep(TRUE, nrow(mtcars))
  )
    output$grafica_base_r <- renderPlot({
        plot(mtcars$wt,mtcars$mpg,
             xlab = 'wt', ylab = 'Millas por galon')
    })
    
    output$grafica_ggplot <- renderPlot({
        diamonds %>%
            ggplot(aes(x=carat, y=price,color=color))+
            geom_point() +
            ylab('Precio')+
            xlab('Kilates')+
            ggtitle("Precio de diamantes por Kilate")
    })
    mtcars$color <- 1
    observeEvent(input$clk, {
      df <- nearPoints(mtcars, input$clk,xvar='wt',yvar='mpg',allRows = TRUE)
      vals$keeprows <- xor(vals$keeprows, df$selected_)
      #mtcars$color[mtcars$values==df$values] <<- "2"
      output$click_data2 <- renderPrint({df})
    })
    output$plot_click_options <-renderPlot({
        keep    <- mtcars[ vals$keeprows, , drop = FALSE]
        exclude <- mtcars[!vals$keeprows, , drop = FALSE]
        ggplot(data = keep, aes(x = wt, y = mpg)) + geom_point() +
          geom_point(data = exclude, color = "green")
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
        #df <- nearPoints(mtcars, input$clk,xvar='wt',yvar='mpg')
        df <- brushedPoints(mtcars,input$mouse_brush,
                            xvar = 'wt', yvar = 'mpg')
        df
    })

})
