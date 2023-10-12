###############
datM <- read_csv("./data/ptr_remeasurement.csv")
#datR <- read_csv("weighbridge_operator.csv")
datR <- read.csv("./data/log_ovality_richard_full.csv")
library(lubridate)
library(dplyr)
library(tidyr)
library(magrittr)
library(ggplot2)
library(readr)
########################
# Local Repository
# - prevent unnecessary data set getting load on to bitbucket.


## Code Vocabulary
### Working with the R Environment
# Use R Studio
# getwd()
getwd()
list.files()
getwd()
# list.files()
# notice : the backslash
sessionInfo() 
installed.packages()
# installed.packages()
# list.files()
# getwd() / setwd() - change the work directory
# history()
# Creating Data
# Very Simple Examples
# Object - a thing
A <- c(1,3,4,7,9,11,14,17)
# <- Assignment Symbol
# preferred method
# "=" also works
B = 6
B
# mode(object)
# class(object)
# length(object)
# inbuilt data set called "iris" - here "iris" is the object
# head(iris)
# dim(iris)
# nrow(iris)
# ncol(iris)
# 
# summary(iris)
length(iris)
dim(A)
dim(a)
# names(iris)
# rownames(iris)
# colnames(iris)
# inbuilt data set called "mtcars"
# summary(mtcars)
# summary(airquality)
# names() usually same output as colnames()
# rownames()....?
# rownames(iris)  is 1 to 150
# rownames(mtcars)  - name of each car
#### change  to R packages ####
library(dplyr)
library(magrittr)
# dplyr ; grammar of data manipulation
 Rstudio : tools : install package
# install.packages("dplyr")
# Dialogue Box should pop up
# Choose a country
# Choose Berkeley
install.packages("vcd")
glimpse(iris)
# command in "dplyr" : glimpse
# install.packages("dplyr)
# install.packages("dplyr")
# library(dplyr)
# install.packages("dplyr",repos= " URL ")
help(iris)
?iris
# ?iris
# help(iris)
#glimpse(iris)
#glimpse(mtcars)
# dbl
# int
# chr
# fct
# dbl : real number 
# int : integers
# chr : character
# fct : factor
# factor is very important in graphics
# ggplot2
Location <- c("Urban","Urban","Rural","Rural","Suburb")
mode(Location)
# Characters: names and text, not categories
# factors: are categories
# how to transform
Location <- factor(Location)
Location
levels(Location)
Location <- factor(Location, levels = c("Urban","Suburb","Rural"))
levels(Location)
# library : forcats - tidyverse
library(magrittr)
# iris %>% summary()
# iris %>% glimpse()
# %>% pipe: operator
# iris %>% head()
# important for writing long bits of code
# nested structure
# mode(summary(head(iris,20))))
# iris %>% head(5)
# iris %>% head(5) %>%
#   summary() 
# iris %>% head(5) %>%
#   summary() 
#   mode()
# iris %>% head(5) %>%
#   summary()  %>%
#   mode()
# Looking at Vignettes - Hadley Wickham's one in 
# particular, you will notice that approach
# Tidyverse
# Tidyverse.org
# family of R packages
# accessing columns of a data.frame
 # mtcars$vs
table(mtcars$vs)
# try out for "mtcars$am
# Automatic vs Manual
# Crosstabulation
table(mtcars$vs,mtcars$am)
table(mtcars$vs,mtcars$am) %>% addmargins()
table(mtcars$vs,mtcars$am) %>% prop.table()
table(mtcars$vs,mtcars$am) %>% prop.table() %>%
addmargins()
myXtab <- table(mtcars$vs,mtcars$am) %>% prop.table() %>%
addmargins()
# mode(myXtabs)
# dim(myXtabs)
# class(myXtabs)
# dim(myXtabs)
# Reason - prefer objects to be data frames
myXtab <- table(mtcars$vs,mtcars$am) %>% prop.table() %>%
addmargins() %>%
as.data.fram()
myXtab <- table(mtcars$vs,mtcars$am) %>% prop.table() 
myXtab <- myXtab %>% addmargins()
myXtab <- myXtab %>% as.data.frame()
myXtab
# adding in margins was a mistake
myXtab <- table(mtcars$vs,mtcars$am) %>% prop.table() 
myXtab <- myXtab %>% as.data.frame()
myXtab
history(200)
#dplyr 
#  tidyr 
# dplyr : set of verbs
# select
# filter
# arrange
# mutate
# sample_n and sample_frac
mtcars %>% select(1:2)  %>% head(3)
mtcars %>% select(2:4)  %>% head(3)
mtcars %>% select(2:drat)  %>% head(3)
mtcars %>% select(cyl:drat)  %>% head(3)
mtcars %>% select(cyl:drat,everything())  %>% head(3)
mtcars %>% select(1:2)
mtcars %>% select(1:4)  %>% head(3)
# mtcars %>% select(-1)  %>% head(3)
# mtcars %>% select(-mpg)  %>% head(3)
# mtcars %>% select(-(cyl:mpg))  %>% head(3)
# mtcars %>% select(-cyl, -mpg)  %>% head(3)
mtcars %>% select(-cyl, -mpg)  %>% head(3)
mtcars %>% select(-cyl, cyl)  %>% head(3)
# iris
iris %>% names()
iris %>% select( starts_with("Sep") )  %>% head()
iris %>% select( ends_with("idth") )  %>% head()
iris %>% select( contains("idth") )  %>% head()
# Google
# CRAN : Comprehensive R Archive Network
# dplyr page
# Vignetter : Tutorial pages on CRAN
# Vignettes : Tutorial pages on CRAN
# filter()
# selecting rows
iris %>% filter( sepal.length > 1) %>% head()
iris %>% filter( Sepal.length > 1) %>% head()
iris %>% filter( Sepal.Length > 1) %>% head()
iris %>% filter( Sepal.Length > 5) %>% head()
iris %>% filter( Sepal.Length > 5) %>% dim()
iris %>% filter( Sepal.Length > 5, Sepal.Width <= 4) %>%
dim()
mtcars %>% filter( vs == 1) %>% dim()
# "==" 
# "!=" 
# different from "<-" and "="
# >= 
# <= 
# logical / relational operators
# mtcars$cyl
# number of cylinders in car
table(mtcars$cyl)
# we want to pick out 4 and 8 cylinder cars
mtcars %>% filter( cyl != 6) %>% dim()
# set theory
A
# %in% : is this an element of this data set?
# logical test
5 %in% A
7 %in% A
mtcars %>% filter( cyl %in% c(4,8) ) %>% dim()
# Logical Operators
# "&" : logical AND
# "|" : logical OR
mtcars %>% filter( (cyl == 4) | (cyl == 8) ) %>% dim()
# iris : pick out Species Virgica and Versicolor
# where Sepal.Length is greater than 3.5
# table(iris$Species)
# remark : you can make one "filter" statement after another
iris %>% filter(Species %in% c("Versicolor","Virginica")) %>%
filter(Sepal.Length >3.5)
iris %>% filter(Species %in% c("Versicolor","Virginica")) %>%
filter(Sepal.Length >2.5)
filter(Sepal.Length >1.5)
iris %>% filter(Species %in% c("Versicolor","Virginica")) %>%
filter(Sepal.Length >1.5)
iris %>% filter(Species %in% c("Versicolor","Virginica")) %>%
filter(Sepal.Length < 1.5)
iris %>% filter(Species %in% c("Versicolor","Virginica")) %>% summary()
iris %>% filter(Species %in% c("versicolor","virginica")) %>% summary()
iris %>% filter(Species %in% c("versicolor","virginica")) %>% 
 filter(Sepal.Length > 5.5) %>% dim()
mtcars %>% group_by(vs) %>%
  summarize(mean(mpg))
mtcars %>% group_by(cyl) %>%
  summarize(mean(mpg))
mtcars %>% group_by(cyl) %>%
  summarize(mean.mpg = mean(mpg))
mtcars %>% group_by(vs,as) %>%
  summarize(mean.mpg = mean(mpg))
mtcars %>% group_by(vs,am) %>%
  summarize(mean.mpg = mean(mpg))
mtcars %>% group_by(cyl) %>%
  summarize(mean.mpg = mean(mpg),
median.mpg = median(mpg))
###
# var
# sd()
# max()
# min()
# sd()
# using with MASS
# summarize
history(300)

