#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

    observeEvent(input$min, {
        updateSliderInput(session,"slider_eje1",min=input$min)
    })
  
    observeEvent(input$max, {
        updateSliderInput(session,"slider_eje1",max=input$max)
    })
    
    observeEvent(input$clean, {
        updateSliderInput(session,"s1",value=0)
        updateSliderInput(session,"s2",value=0)
        updateSliderInput(session,"s3",value=0)
        updateSliderInput(session,"s4",value=0)
    })
    
    observeEvent(input$n,{
        if(is.na(input$n)){
            label <- paste0('correr')
        } else if(input$n > 1){
            label <- paste0('correr',input$n,' veces')
        } else if(input$n == 1){
            label <- paste0('correr una', ' veces')
        } else {
            label <- paste0('correr')
        }
        updateActionButton(session,"correr",label = label)
    })
    
    observeEvent(input$nvalue, {
        updateNumericInput(session,"nvalue",value=input$nvalue+1)
    })
    
    observeEvent(input$celcius, {
        f <- round(input$celcius*(9/5)+32)
        updateNumericInput(session,"farenheith",value=f)
    })
    observeEvent(input$farenheith, {
        c <- round((input$farenheith-32)*(9/5))
        updateNumericInput(session,"celcius",value=c)
    })
    observeEvent(input$dist, {
        updateTabsetPanel(session,'params',selected = input$dist)
    })
    sample <- reactive({
        switch (input$dist,
            'Normal' = rnorm(n=input$nrandom,mean = input$media,sd=input$sd),
            'Uniforme' = runif(input$nrandom,input$umin,input$umax),
            'Exponencial' = rexp(input$nrandom,rate = input$razon)
        )
    })
    
    output$plot_dist <- renderPlot({
        hist(sample())
    })
})
