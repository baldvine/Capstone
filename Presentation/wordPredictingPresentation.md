Text Prediction
========================================================
author: Baldvin Einarsson
date: December 2 2017
autosize: true

Application information
========================================================
A cool shiny app for text prediction can be found here:

 <https://baldvine.shinyapps.io/wordpredictionapp/>

The code is on the following 
github page:

 <https://github.com/baldvine/Capstone>

Model Information
========================================================
Used text from Twitter, news and blogs, found here:
 <https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip>

With the above dataset, we built a simple n-gram model, using up to 4 words.
* This allows us to predict based on as much as three words.

If an unknown words is encountered, we simply predict the most common unigram, "just".

Balance of Speed and Accuracy
========================================================
Most words have low frequency. In fact, in order to get 95% of all unigram frequencies, we only need about 19% of the words.

*Similar story for bi-, tri- and quadgrams, although we throw out a higher proportion of n-grams.*

We sacrifice some predictive power for speed.

Mind your language
========================================================
We removed profanity based on the list found here:
 <https://raw.githubusercontent.com/LDNOOBW/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words/master/en>

*Follow link above at your own risk* :)

This list is used by several companies, including Shutterfly. 

**Have fun!**



