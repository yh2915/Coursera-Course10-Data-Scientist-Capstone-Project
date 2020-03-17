#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
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

predict_3<- function(w1, w2, n=5) {
    next_3<-tsfq_3[(tsfq_3$word_1 == w1 & tsfq_3$word_2 == w2),"word_3"]
    next_3<-as.character(unlist(next_3))
    l<-length(next_3)
    if (l == 0){
        next_3<-predict_2(w2, n=5)
    } else if (l >= n) {
        next_3<-next_3[1:n]
    } else if (l < n) {
        next_2<-predict_2(w2, n=5)
        next_2<-next_2[!next_2 %in% next_3]
        next_2<-next_2[1:(n - l)]
        next_3<-c(next_3, next_2)
    }
    return(next_3)
}

predict_2<- function(w2, n=5){
    next_2<-tsfq_2[tsfq_2$word_1 == w2, "word_2"]
    next_2<-as.character(unlist(next_2))
    l<-length(next_2)
    if (l == 0){
        next_2<-as.character(unlist(uniwords[,"word_1"]))
        next_2<-next_2[1:n]
    } else if (l >= n) {
        next_2<-next_2[1:n]
    } else if (l < n) {
        print(l)
        print(n)
        next_1<-as.character(unlist(uniwords[,"word_1"]))
        next_1<-next_1[1:(n-l)]
        next_2<-c(next_2, next_1)
    }
    return(next_2)
}

retrieve_words <- function(sentence){
    words<-str_split(sentence, pattern=" ")
    words<-as.character(unlist(words))
    total<-length(words)
    if (total==1){
        w1<-NA
        w2<-words
    } else if (total>=2) {
        w1<-words[total-1]
        w2<-words[total]
    }
    return(c(w1,w2))
}

shinyServer(function(input, output) {

    output$w1 <- renderText({
        sentence<-input$sentence
        n<-input$alternative
        w1w2<-retrieve_words(sentence)
        w1<-w1w2[1]
        w2<-w1w2[2]
        print(w1)
    })
    output$w2 <- renderText({
        sentence<-input$sentence
        n<-input$alternative
        w1w2<-retrieve_words(sentence)
        w1<-w1w2[1]
        w2<-w1w2[2]
        print(w2)
    })
    output$primaryword <- renderText({
        n<-input$alternative
        sentence<-input$sentence
        w1w2<-retrieve_words(sentence)
        
        w1<-w1w2[1]
        w2<-w1w2[2]
        
        if (!is.na(w1)){
            prediction<-predict_3(w1,w2,n)
        } else if (is.na(w1))
            prediction<-predict_2(w2,n)
       prediction[1]
    })
    output$alternativeword <- renderText({
        n<-input$alternative
        sentence<-input$sentence
        w1w2<-retrieve_words(sentence)
        w1<-w1w2[1]
        w2<-w1w2[2]
        if (!is.na(w1)){
            prediction<-predict_3(w1,w2,(n+1))
        } else if (is.na(w1))
            prediction<-predict_2(w2,(n+1))
        alternative<-prediction[2:length(prediction)]
        paste(alternative, collapse = "/")
    })

})
