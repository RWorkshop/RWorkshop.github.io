
library(magrittr)

myColors <- colours()

length(myColors)

myColors[1:10] %>% tolower

grep("[G|g]reen",myColors,value=TRUE)

varNames <- c("Var Name 1","Var Name 2")

gsub(" ","",varNames)

paste("Var",91:105,sep="")
