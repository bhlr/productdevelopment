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
    titlePanel("UI dinamico"),
    tabsetPanel(tabPanel("Ejemplo1",
                         numericInput("min","limite inferior",value = 5),
                         numericInput("max","limite superior",value = 10),
                         sliderInput('slider_eje1',"Seleccione uno",min=0,max= 10,value=5)
                         ),
                tabPanel("Ejemplo 2",
                         sliderInput('s1','s1', value = 0, min=-5, ma=5),
                         sliderInput('s2','s2', value = 0, min=-5, ma=5),
                         sliderInput('s3','s3', value = 0, min=-5, ma=5),
                         sliderInput('s4','s4', value = 0, min=-5, ma=5),
                         actionButton('clean','limpiar')
                         ),
                tabPanel("Ejemplo 3", 
                         numericInput('n','corridas',value=10),
                         actionButton('correr','correr')
                         ),
                tabPanel("Ejemplo 4", 
                         numericInput('nvalue','valor',value=0)
                         
                ),
                tabPanel("Ejemplo 5", 
                         numericInput('celcius','Temperatura en Celcius',value=NA,step=1),
                         numericInput('farenheith','Temperatura en farenheith',value=NA, step=1)
                ),
                tabPanel("Ejemplo 6", 
                         selectInput('dist','Distribucion',
                                     choices = c('Normal','Uniforme','Exponencial')),
                         numericInput('nrandom','Tamaño de la muestra',
                                      value = 100),
                         tabsetPanel(id='params',type='hidden',
                                     tabPanel('Normal',
                                              numericInput('media','media',value=0),
                                              numericInput('sd','sd',value=1)
                                              ),
                                     tabPanel('Uniforme',
                                              numericInput('umin','min',value=0),
                                              numericInput('umax','max',value=0)
                                              ),
                                     tabPanel('Exponencial',
                                              numericInput('razon','razon',value=1,min=0)
                                              ),
                                     ),
                         plotOutput('plot_dist')
                
                    )
            )
    
   
))
