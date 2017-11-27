#
#

library(shiny)
library(data.table)
library(magrittr)

source("./textPreparing.R")
# Has following functions:
# prepareWordString(someText)
# getLastNWords(wordString, N = 1)
# text4ngram(someText, n = 1)
source("./textPredicting.R")
# Has the following:
# predictWord(wordString)

shinyServer(function(input, output) {
    
    # Load in data:
    # data2use <- reactive({ruspini})
    
    predictedWord <- reactive({
        return(predictWord(input$text2predict))
    })
    
    output$textPrediction <- renderText({
        predictedWord()

    })
    
})

