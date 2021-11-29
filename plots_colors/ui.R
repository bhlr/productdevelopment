#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Interacciones de usuarios con graficas"),
    tabsetPanel(
        tabPanel('Clicks plots',
                plotOutput("plot_click_options",
                           click = 'clk',
                           dblclick = 'dclk',
                           hover = 'mouse_hover',
                           brush = 'mouse_brush'),
                verbatimTextOutput("click_data"),
                DT::dataTableOutput('mtcars_tbl')
                 )
    )

  
))
