#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(lubridate)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Cargar Archivo a Shiny"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            fileInput("Cargar_archivo","Cargar archivo",
                      buttonLabel = "Seleccionar"),
            downloadButton("download_dataframe","Descargar Archivo"),
            dateRangeInput('fechas',"Seleccionar fechas",
                           start = ymd('1900-01-05'),
                           end = ymd('2007-09-30'),
                           min = ymd('1900-01-05'),
                           max = ymd('2007-09-30')
            )
        ),

        # Show a plot of the generated distribution
        mainPanel(
            DT::dataTableOutput("contenido_archivo")
        )
    )
))
