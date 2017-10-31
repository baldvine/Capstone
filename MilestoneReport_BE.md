# Data Scienist Milestone Report
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
corpora <- lapply(X = fileConnections, FUN = readLines, skipNul = TRUE)
lapply(X = fileConnections, FUN = close)
```

Let's do some basic inspection of the files and loaded objects:


File type   File name                               File Size (MB)   Object Size (MB)   Line count
----------  -------------------------------------  ---------------  -----------------  -----------
Blogs       ./data/final/en_US/en_US.blogs.txt             205,234            254,457      899,288
News        ./data/final/en_US/en_US.news.txt              200,988            255,624    1,010,242
Twitter     ./data/final/en_US/en_US.twitter.txt           163,189            308,630    2,360,148


# Exploratory Data Analysis

Before we start, we want to clean the data bit, such as

* change to lower case
* remove Internet links
* remove double entries
* remove superfluous whitespace
* remove punctuation
* remove numbers

In order to do this, let's have a look at the [Natural Langue Processing Task View](https://cran.r-project.org/web/views/NaturalLanguageProcessing.html). There are penty of packages to choose from, but for now let's start with [tm](https://cran.r-project.org/web/packages/tm/index.html)



Let's try out some cleaning and tokenizing on a subset of the data, in order to get things done faster. We pick out 5 % of entries from each type of data sources:

```r
set.seed(42)
subsetCorpora <- 
    c(sample(corpora$Blogs, size = 0.05*length(corpora$Blogs), replace = FALSE),
      sample(corpora$News, size = 0.05*length(corpora$News), replace = FALSE),
      sample(corpora$Twitter, size = 0.05*length(corpora$Twitter), replace = FALSE)
    )
```


Let's use the package `tokenizer`
