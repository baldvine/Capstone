
# Set the directory and language file name conventions:
fileDir <- "./data/final/"
fileLanguage <- list(English = "en_US", Finnish = "fi_FI",
                     German = "de_DE", Russian = "ru_RU")

# This gets appended to the `fileDir.lang`
fileNameSuffix <- list(Blogs = '.blogs.txt',
                       News = '.news.txt',
                       Twitter = '.twitter.txt')

tweety <- file(paste0(fileDir,fileLanguage$English, "/", fileLanguage$English,fileNameSuffix$Twitter))
us.twitter <- readLines(con = tweety, skipNul = TRUE)
close(tweety)

grep("biostats",us.twitter,value=TRUE)
# "i know how you feel.. i have biostats on tuesday and i have yet to study =/"

grep("A computer once beat me at chess, but it was no match for me at kickboxing",us.twitter,value=TRUE)
# Gives three results

sum(grepl("love",us.twitter)) / sum(grepl("hate",us.twitter))
# Approx 4.1

max(sapply(us.twitter, nchar))
# 140

rm(us.twitter); invisible(gc())


newsy <- file(paste0(fileDir,fileLanguage$English, "/", fileLanguage$English,fileNameSuffix$News))
us.news <- readLines(con = newsy, skipNul = TRUE)
close(newsy)

max(sapply(us.news, nchar))
# 11,384
rm(us.news); invisible(gc())



blogsy <- file(paste0(fileDir,fileLanguage$English, "/", fileLanguage$English,fileNameSuffix$Blogs))
us.blogs <- readLines(con = blogsy, skipNul = TRUE)
close(blogsy)

max(sapply(us.blogs, nchar))
# 40,833
rm(us.blogs); invisible(gc())
