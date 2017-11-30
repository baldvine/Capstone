#
#

library(shiny)
library(data.table)
library(magrittr)

# Main source code:
source("./textPreparing.R")
source("./textPredicting.R")
# Load in data:
source("./global.R")

shinyServer(function(input, output) {
    
    predictedWord <- reactive({
        return(predictWord(input$text2predict))
    })
    
    output$textPrediction <- renderText({
        predictedWord()

    })
    
})

