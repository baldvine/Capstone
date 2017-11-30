predictWord <- function(wordString) {
    # Extract the (cleaned) words:
    words <- 
        prepareWordString(wordString) %>% 
        strsplit(., " ") %>% 
        unlist
    # This should now be a vector of words
    numWords <- length(words)
    
    myPrediction <- character()
    
    if (numWords >= 3) {
        myPrediction <- predictFromQuadGram(tail(words, n = 3))
    }
    if (numWords == 2) {
        myPrediction <- predictFromTriGram(words)
    }
    if (numWords == 1) {
        myPrediction <- predictFromBiGram(words)
    }
    
    #return(revertPreparation(myPrediction))
    return(myPrediction)
    
}



predictFromQuadGram <- function(words) {
    # Words should be a vector of length 3
    #words <- tail(words, n = 3)
    
    tmp <- quadgrams[grep(paste0("^",paste0(words,collapse = " ")," "), Term)]
    if (nrow(tmp) > 0) {
        return(getLastNWords(tmp$Term[1], N = 1))
    } else {
        return(predictFromTriGram(words[-1]))
    }
    
}

predictFromTriGram <- function(words) {
    # Words should be a vector of length 2
    
    tmp <- trigrams[grep(paste0("^",paste0(words,collapse = " ")," "), Term)]
    if (nrow(tmp) > 0) {
        return(getLastNWords(tmp$Term[1], N = 1))
    } else {
        return(predictFromBiGram(words[-1]))
    }
}

predictFromBiGram <- function(words) {
    # Words should be a vector of length 1
    tmp <- bigrams[grep(paste0("^",paste0(words,collapse = " ")," "), Term)]
    if (nrow(tmp) > 0) {
        return(getLastNWords(tmp$Term[1], N = 1))
    } else {
        return(unigrams$Term[1])
    }
}

