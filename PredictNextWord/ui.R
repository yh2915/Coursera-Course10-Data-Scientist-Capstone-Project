#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(stringi)
library(stringr)
tsfq_1<-readRDS("tsfq_1.RDS")
tsfq_2<-readRDS("tsfq_2.RDS")
tsfq_3<-readRDS("tsfq_3.RDS")
uniwords<-readRDS("uniwords.RDS")

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Data Science Capstone Final Project"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            textInput("sentence", "Please input your sentence here:",
                      value="I have a case of"),

            sliderInput("alternative",
                        "Please indicate how many alternative suggestions you would like to see:", 
                        min = 1, max=10, value = 5),
        ),
        # Show a plot of the generated distribution
        mainPanel(
            fluidRow(
                h2("The Next word that is most likely to come up is:"),
                textOutput("primaryword")
                ),
            fluidRow(
            h3("Other possible words are:"),
            textOutput("alternativeword")
            ),

        )
    )
))
