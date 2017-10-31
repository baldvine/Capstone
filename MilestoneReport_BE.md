# Data Science Capstone Milestone Report
Baldvin Einarsson  
10/30/2017  



This is a milestone report for the Data Scientist Specialization Capstone project from [Coursera](https://www.coursera.org). Below, we'll give code which downloads the data, loads it in, and performs basic exploratory data analysis. This will form the basis for a predictive model, which we intend to create a Shiny app for.

# Download and load data

The data comes from the following location:
[https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip). Let's download it (if necessary!):


```r
fileURL <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/"
fileZip <- "./data/Coursera-SwiftKey.zip"

if (!file.exists(fileZip)){
    cat("Downloading. This may take a while...")
    download.file(url=fileURL, destfile = fileZip, method='curl', quiet = TRUE)
}
```

Next, we do some (manual) inspecting of the files in the `.zip` file. We see (again, manually), that all the zipped files are stored in a folder called `final/`. Let's unzip the files if that directory does not exist:


```r
# Get the file names of the files in the zip:
zippedFiles <- unzip(zipfile = fileZip, list=TRUE)

# Obtain the directory name:
zipDir <- strsplit(zippedFiles$Name[1],split="/")[[1]][1]

if (!dir.exists(paste0("./data/",zipDir))) {
    unzip(zipfile = fileZip, exdir = "./data")
}
```

Now, in order to load into `R`, let's make our lives easier and create an object called `fileNames.US` which contains the file names. It's value is the following:

```
Blogs: ./data/final/en_US/en_US.blogs.txt
News: ./data/final/en_US/en_US.news.txt
Twitter: ./data/final/en_US/en_US.twitter.txt
```

We are now in a position to read in the files:

```r
fileConnections <- lapply(X = fileNames.US, FUN = file)
corpus <- lapply(X = fileConnections, FUN = readLines, skipNul = TRUE)
```

```
Warning in FUN(X[[i]], ...): incomplete final line found on './data/final/
en_US/en_US.news.txt'
```

```r
lapply(X = fileConnections, FUN = close)
```

# Exploratory Data Analysis

Let's do some basic inspection of the files and loaded objects. Note that the word count comes from package `tokenizers`:

File type   File name                               File Size (MB)   Object Size (MB)   Line count   Word (from 'tokenizers'
----------  -------------------------------------  ---------------  -----------------  -----------  ------------------------
Blogs       ./data/final/en_US/en_US.blogs.txt             205,234            254,457      899,288                   360,784
News        ./data/final/en_US/en_US.news.txt              200,988             19,640       77,259                    89,335
Twitter     ./data/final/en_US/en_US.twitter.txt           163,189            308,630    2,360,148                   383,567

We want to clean the data bit, such as

* change to lower case
* remove Internet links
* remove double entries
* remove superfluous whitespace
* remove punctuation
* remove numbers

In order to do this, let's have a look at the [Natural Langue Processing Task View](https://cran.r-project.org/web/views/NaturalLanguageProcessing.html). There are plenty of packages to choose from, but for now let's start with [tm](https://cran.r-project.org/web/packages/tm/index.html).

In order to get things done faster, we pick out 2 % of entries from each type of data sources:

```r
set.seed(42)
useRatio <- 0.02
subsetCorpus <- 
    c(sample(corpus$Blogs, size = useRatio*length(corpus$Blogs), replace = FALSE),
      sample(corpus$News, size = useRatio*length(corpus$News), replace = FALSE),
      sample(corpus$Twitter, size = useRatio*length(corpus$Twitter), replace = FALSE)
    )
rm(corpus); invisible(gc())
```


```r
subsetCorpus <- VCorpus(VectorSource(subsetCorpus))
toRemove <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
subsetCorpus <- tm_map(subsetCorpus, toRemove, "(f|ht)tp(s?)://(.*)[.][a-z]+")
subsetCorpus <- tm_map(subsetCorpus, toRemove, "@[^\\s]+")
subsetCorpus <- tm_map(subsetCorpus, tolower)
subsetCorpus <- tm_map(subsetCorpus, removeWords, stopwords("en"))
subsetCorpus <- tm_map(subsetCorpus, removePunctuation)
subsetCorpus <- tm_map(subsetCorpus, removeNumbers)
subsetCorpus <- tm_map(subsetCorpus, stripWhitespace)
subsetCorpus <- tm_map(subsetCorpus, PlainTextDocument)
```



```r
unigramTokenizer <- function(x) {
        NGramTokenizer(x, Weka_control(min = 1, max = 1))
}
unigrams <- 
    DocumentTermMatrix(subsetCorpus, 
                       control = list(tokenize = unigramTokenizer))

BigramTokenizer <- function(x) {
        NGramTokenizer(x, Weka_control(min = 2, max = 2))
}
bigrams <- DocumentTermMatrix(us_files, control = list(tokenize = BigramTokenizer))

TrigramTokenizer <- function(x) {
        NGramTokenizer(x, Weka_control(min = 3, max = 3))
}
trigrams <- DocumentTermMatrix(us_files, control = list(tokenize = TrigramTokenizer))
```


```r
unigrams_frequency <- sort(colSums(as.matrix(unigrams)),decreasing = TRUE)[1:32]
unigrams_freq_df <- data.frame(word = names(unigrams_frequency), freq = unigrams_frequency)

ggplot(data=head(unigrams_freq_df, n=32), aes(x=reorder(word, freq), y=freq)) + geom_bar(stat="identity") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + coord_flip()
```

