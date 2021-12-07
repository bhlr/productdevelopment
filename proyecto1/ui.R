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
    titlePanel("Proyecto 1 Shiny apps"),
    tabsetPanel(
        tabPanel('Mt Cars',
                 sidebarLayout(
                   sidebarPanel(
                     sliderInput('bins', 'Sample Size', min=10, max=nrow(mtcars),
                                 value=min(10, nrow(mtcars)), step=5, round=0),
                     selectInput('x', 'X', names(mtcars), names(mtcars)[[6]]),
                     selectInput('y', 'Y', names(mtcars)),
                     checkboxInput('smooth', 'Smooth'),
                     textInput('url_param',"Copiar Direccion del reporte",value="")
                   ),
                   mainPanel(
                    plotOutput("plot_click_options",
                           click = 'clk',
                           dblclick = 'dclk',
                           hover = 'mouse_hover',
                           brush = 'mouse_brush'),
                    verbatimTextOutput("click_data"),
                    DT::dataTableOutput('mtcars_tbl')
                  )
                 )
    ),
    tabPanel('Exploracion de data',
             sidebarLayout(
               sidebarPanel(
                 selectInput('target', 'Target',  c("NA" = "*",
                                                    "mpg	Miles/(US) gallon" = "mpg",
                                                    "Displacement" = "disp",
                                                    "Horsepower" = "hp",
                                                    "Rear axle ratio" = "drat",
                                                    "Weight (lb/1000)" = "wt",
                                                    "Number of forward gears" = "gear",
                                                    "Cylinders" = "cyl",
                                                    "Transmission" = "am"),selected = NULL),
                 verbatimTextOutput("target_data")
               ),
               mainPanel(
                  plotOutput("plot_all",width = "100%",height = "800px")
               )
             )
    )

  
)
))
