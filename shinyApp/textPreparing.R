# Clean text, smilarly to the corpora:
prepareWordString <- function(someText) {
    # Lower case
    someText <- tolower(someText)
    # Remove ftp or http links:
    someText <- gsub("(f|ht)tp(s?)://(.*)[.][a-z]+","",someText)
    # Remove twitter handles (i.e. anything which has @ symbol followed by non-blank spaces:
    gsub("@[^\\s]+","",someText)
    # Remove numbers:
    someText <- gsub("[0-9]+","",someText)
    # Remove punctuation:
    someText <- gsub("[',\\.!,?]","",someText)
    # Remove whitespace:
    someText <- trimws(someText, "both")
    someText <- gsub(" +", " ", someText)
    return(someText)
}


# Assumes that a single space separates words 
getLastNWords <- function(wordString, N = 1) {
    # Convert to class "character":
    wordString <- as.character(wordString)
    # Extract a vector of the words
    wordSample <- unlist(strsplit(wordString, " "))
    # Handle length issues: Return vector of length N filled with NA's
    wordSample <- wordSample[(length(wordSample) - N + 1):length(wordSample)]
    return(paste(wordSample))
}

# Get text ready for grepping with in an n-gram:
text4ngram <- function(someText, n = 1) {
    paste0("^",
           paste0(getLastNWords(prepareWordString(someText),n),collapse = " ")
    )
}