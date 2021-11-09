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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    archivo_cargado <- reactive({
        contenido_archivo <- input$cargar_archivo
        if(is.null(contenido_archivo)) {
            return(NULL)
        }
        if(stringr::str_detect(contenido_archivo$name,'csv')) {
            out <- read::read_csv(contenido_archivo$datapath)    
        }
        if(stringr::str_detect(contenido_archivo$name,'tsv')) {
            out <- readr::read_tsv(contenido_archivo$datapath)
        } else {
            out <- data.frame(extension_archivo = "La extension del archivo no es soportada")
        }
        
        return(out)
    })
    
    output_df <- reactive({
        if(!is.null(archivo_cargado())){
            out <- archivo_cargado %>%
                mutate(Date = ymd(Date)) %>%
                filter(Date >= input$fechas[1],
                       Date >= input$fechas[2])
            return(out)
            }
        return(NULL)
    })
    
    output$contenido_archivo <- DT::renderDataTable({
        DT::datatable(output_df())
    })

    output$download_dataframe <- downloadHandler(
        filename = function() {
            paste("data-", Sys.Date(),".csv",step="")
        },
        content = function(){
            write.csv(output_df(),file,row.names = FALSE)
        }
    )    
})