
# Set the working directory to the main folder
# setwd("")

fileURL <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/"
fileZip <- "./data/Coursera-SwiftKey.zip"

if (!file.exists(fileZip)){
    download.file(url=fileURL, destfile = fileZip, method='curl')
}
# Get the file names of the files in the zip:
zippedFiles <- unzip(zipfile = fileZip, list=TRUE)
print(zippedFiles)
# Obtain the directory name:
zipDir <- strsplit(zippedFiles$Name[1],split="/")[[1]][1]
print(zipDir)

if (!dir.exists(paste0("./data/",zipDir))) {
    unzip(zipfile = fileZip, exdir = "./data")
}
