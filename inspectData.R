
fileDir <- "./data/final/"

fileLang <- list(English = "en_US", Finnish = "fi_FI",
                     German = "de_DE", Russian = "ru_RU")

# This gets appended to the `fileDir.lang`
fileNameSuffix <- list(Blogs = '.blogs.txt',
                       News = '.news.txt',
                       Twitter = '.twitter.txt')

# Count number of lines, and max length of lines
numLines <- list()

tweety <- file(paste0(fileDir,fileLang$English, "/", fileLang$English,fileNameSuffix$Twitter))
us.twitter <- readLines(con = tweety)
close(tweety)

grep("biostats",us.twitter,value=TRUE)
# "i know how you feel.. i have biostats on tuesday and i have yet to study =/"

grep("A computer once beat me at chess, but it was no match for me at kickboxing",us.twitter,value=TRUE)
# Gives three results