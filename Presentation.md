Data Science Capstone - Final project
Predict the Next Word
========================================================
author: YH
date: 16/03/2020
autosize: true
Around the world, people are spending an increasing amount of time on their mobile devices for email, social networking, banking and a whole range of other activities. But typing on mobile devices can be a serious pain. SwiftKey, our corporate partner in this capstone, builds a smart keyboard that makes it easier for people to type on their mobile devices. One cornerstone of their smart keyboard is predictive text models. 





General workflow of the App
========================================================
<span style="font-weight:bold; color:red;">The main aim of this app is to predict the next word that is likely to come up</span>

The data used for this app is from three English sources: Blogs, News and Twitters.
We made use of the r package "quanteda" to explore and clean up the data, and build the App with [n-grams](https://en.wikipedia.org/wiki/N-gram) model

The general workflow is:
 1. Load in data
 2. Sampling data
 3. Tokenize 
 4. Builiding models

Example code for data clean up and tokenization
========================================================

```r
  corpus_all<-str_remove_all(corpus_all,"#|@|-")
  tokens<-tokens(tolower(corpus_all),
                 remove_punct = TRUE,
                 remove_numbers = TRUE,
                 remove_url = TRUE,
                 remove_symbols = TRUE)
  tokens_clean<-tokens_wordstem(tokens_tolower(tokens))
  rm(tokens)
  
#Generate n-grams and stored in variables
  tokens_1<-tokens_ngrams(tokens_clean, n=1)
  tokens_2<-tokens_ngrams(tokens_clean, n=2)
  tokens_3<-tokens_ngrams(tokens_clean, n=3)
  saveRDS(tokens_clean, "tokens_clean.RDS")
  rm(tokens_clean)
```

50 most frequently used 3-word combinations
========================================================

![plot of chunk unnamed-chunk-2](Presentation-figure/unnamed-chunk-2-1.png)

To use the App
========================================================
The app can be found at

<https://yh-shiny.shinyapps.io/PredictNextWord/>

It is easy and handy to use, just need to follow 3 steps
 1. Key in a sentence you would like to enquire on the left-hand side
 2. Slide the slide bar to indicate how many alternative options you would like to see
 3. You may see the prediction on the Main Panel
 
So, Enjoy!
