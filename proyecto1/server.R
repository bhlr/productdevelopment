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
library(explore)

# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
  dataset <- reactive( { mtcars[sample(nrow(mtcars), input$bins),] })

   vals <- reactiveValues(
    keeprows = rep(TRUE, nrow(mtcars)),
    grayrows  = rep(TRUE, nrow(mtcars))
  )
 
   observe({
     x <- input$x
     y <- input$y
     smooth <- input$smooth
     bins <- input$bins
     host_name <- session$clientData$url_hostname
     protocol <- session$clientData$url_protocol
     port <- session$clientData$url_port
     query <- paste('?','bins=',bins,'&','x=',x,'&','y=',y,'&','smooth=',smooth, sep = '')
     url <- paste(protocol,'//',host_name,':',port,'/',query,sep='')
     updateTextInput(session,'url_param', value=url)
     
   })
   
   observe({
     query <- parseQueryString(session$clientData$url_search)
     bins <- query[["bins"]]
     x <-query[["x"]]
     y <-query[["y"]]
     smooth <-query[["smooth"]]
     if(!is.null(bins)) {
       updateSliderInput(session,'bins', value = as.numeric(bins))
     }
     if(!is.null(x)) {
       updateSelectInput(session,'x', selected = x)
     }
     if(!is.null(y)) {
       updateSelectInput(session,'y', selected = y)
     }
     if(!is.null(smooth)) {
       updateCheckboxInput(session,'smooth', value = smooth )
     }
   })
   
    observeEvent(input$clk, {
      df <- nearPoints(mtcars, input$clk,xvar='wt',yvar='mpg',allRows = TRUE)
      vals$keeprows <- xor(vals$keeprows, df$selected_)
      output$mtcars_tbl <- DT::renderDataTable({
        mtcars[!vals$keeprows, , drop = FALSE]
      })
    })
    observeEvent(input$mouse_brush, {
      df <- brushedPoints(dataset(), input$mouse_brush,xvar='wt',yvar='mpg',allRows = TRUE)
      vals$keeprows <- xor(vals$keeprows, df$selected_)
      output$mtcars_tbl <- DT::renderDataTable({
        mtcars[!vals$keeprows, , drop = FALSE]
      })
    })
    observeEvent(input$dclk, {
      df <- nearPoints(dataset(), input$dclk,xvar='wt',yvar='mpg',maxpoints=1,allRows = TRUE)
      vals$keeprows <- xor(vals$keeprows, df$selected_)
    })
    observeEvent(input$mouse_hover, {
      df <- nearPoints(dataset(), input$mouse_hover,xvar='wt',yvar='mpg',maxpoints=1,allRows = TRUE)
      vals$grayrows <- xor(vals$grayrows, df$selected_)
    })
    output$plot_click_options <-renderPlot({
      data <- dataset()
        keep    <- data[ vals$keeprows, , drop = FALSE]
        clicked <- data[!vals$keeprows, , drop = FALSE]
        grayed <- data[!vals$grayrows, , drop = FALSE]
        p <- ggplot(data = keep, aes_string(x=input$x, y=input$y)) + geom_point() +
          geom_point(data = clicked, color = "green")
        if (input$smooth)
          p <- p + geom_smooth()
        p
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
      dataset()
    })
    
 #   sample <- reactive({
    observeEvent(input$target, {
      switch (input$target,
              'wt' = explore_all(mtcars,target = wt),
              'mpg' = explore_all(mtcars,target = mpg),
              'Exponencial' = rexp(input$nrandom,rate = input$razon)
      )
    })
    
    output$target_data <- renderPrint({
      input$target
    })
    
    output$plot_all <-renderPlot({
      if (input$target == 'gear') {
          explore_all(mtcars,target = gear)
      } else if (input$target == 'mpg') {
        explore_all(mtcars,target = mpg)
      } else if (input$target == 'cyl') {
        explore_all(mtcars,target = cyl)
      } else if (input$target == 'hp') {
        explore_all(mtcars,target = hp)
      } else if (input$target == 'disp') {
        explore_all(mtcars,target = disp)
      } else if (input$target == 'drat') {
        explore_all(mtcars,target = drat)
      }  else if (input$target == 'wt') {
        explore_all(mtcars,target = wt)
      } else if (input$target == 'qsec') {
        explore_all(mtcars,target = qsec)
      } else if (input$target == 'vs') {
        explore_all(mtcars,target = vs)
      } else if (input$target == 'am') {
        explore_all(mtcars,target = am)
      } else if (input$target == 'carb') {
        explore_all(mtcars,target = carb)
      } else {
        explore_all(mtcars)
      }
    })
  #  output$mtcars_tbl <- DT::renderDataTable({
   #     #df <- nearPoints(mtcars, input$clk,xvar='wt',yvar='mpg')
   #     df <- brushedPoints(mtcars,input$mouse_brush,
   #                         xvar = 'wt', yvar = 'mpg')
    #    df
  #  })

})
