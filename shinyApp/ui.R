#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(data.table)
library(magrittr)

# Define UI for application
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Text Prediction Application"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        
        sidebarPanel(
            h3("Enter your text:"),
            textInput(inputId = "text2predict",
                      value = "", 
                      label = NULL)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            h3("Baldvin Einarsson, PhD"),
            helpText(a("See RPubs presentation for more information on data and methods",
                       href="http://rpubs.com/baldvine/textPrediction",
                       target="_blank")
            ),
            h3("Prediction:"),
            textOutput(outputId = "textPrediction")
        )
    )      
))
