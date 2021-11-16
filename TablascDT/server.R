#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$tabla_1 <- DT::renderDataTable({
        mtcars %>% DT::datatable(rownames = FALSE,
                                filter = 'top',
                                extensions = 'Buttons',
                                options = list(
                                    pageLength = 5,
                                    lengthMenu = c(5,10,15),
                                    buttons = c('csv')
                                ))
    })
    
    output$tabla_2 <- DT::renderDataTable({
        diamonds %>% 
            mutate(vol = x*y*z,
                   vol_promedio = mean(vol),
                   volp = vol/vol_promedio
                   ) %>%
        DT::datatable() %>%
            formatCurrency(columns = 'price', currency = '$') %>%
            formatPercentage(columns = 'volp',digits = 2)
    })
    
    output$tabla_3 <- DT::renderDataTable({
        mtcars %>% DT::datatable(selection = list(mode = 'single',target = 'row'))
    })
    
    output$output_1 <- renderPrint({
        input$tabla_3_rows_selected
    })
    
    output$tabla_4 <- DT::renderDataTable({
        mtcars %>% DT::datatable(selection = list(mode = 'multiple',target = 'row'))
    })
    
    output$output_2 <- renderPrint({
        input$tabla_4_rows_selected
    })
    
    output$tabla_5 <- DT::renderDataTable({
        mtcars %>% DT::datatable(selection = list(mode = 'single',target = 'column'))
    })
    
    output$output_3 <- renderPrint({
        input$tabla_5_columns_selected
    })
    
    output$tabla_6 <- DT::renderDataTable({
        mtcars %>% DT::datatable(selection = list(mode = 'multiple',target = 'column'))
    })
    
    output$output_4 <- renderPrint({
        input$tabla_6_columns_selected
    })
    
    output$tabla_7 <- DT::renderDataTable({
        mtcars %>% DT::datatable(selection = list(mode = 'single',target = 'cell'))
    })
    
    output$output_5 <- renderPrint({
        input$tabla_7_cells_selected
    })
    
    output$tabla_8 <- DT::renderDataTable({
        mtcars %>% DT::datatable(selection = list(mode = 'multiple',target = 'cell'))
    })
    
    output$output_6 <- renderPrint({
        input$tabla_8_cells_selected
    })
    
})
