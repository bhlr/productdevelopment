#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),
    tabsetPanel(tabPanel('tablas en DT',
                h1('Vista Basica'),
                fluidRow(
                    column(12,DT::dataTableOutput('tabla_1')),
                    column(12,DT::dataTableOutput('tabla_2'))
                )
    ),
    tabPanel('Click en tablas',
             fluidRow(
                 column(6,
                        h2('Single select row'),
                        DT::dataTableOutput('tabla_3'),
                        verbatimTextOutput('output_1')
                        ),
                 column(6,
                        h2('Single select row'),
                        DT::dataTableOutput('tabla_4'),
                        verbatimTextOutput('output_2')
                 )
             ),
             fluidRow(
                 column(6,
                        h2('Single select column'),
                        DT::dataTableOutput('tabla_5'),
                        verbatimTextOutput('output_3')
                        ),
                 column(6,
                        h2('Multiple select column'),
                        DT::dataTableOutput('tabla_6'),
                        verbatimTextOutput('output_4'))
             ),
             fluidRow(
                 column(6,
                        h2('Single select column'),
                        DT::dataTableOutput('tabla_7'),
                        verbatimTextOutput('output_5')
                 ),
                 column(6,
                        h2('Multiple select column'),
                        DT::dataTableOutput('tabla_8'),
                        verbatimTextOutput('output_6'))
             )
             )
    ))
)
