library(lubridate)

# Functions to work with date-times and time-spans: 
# fast and user friendly parsing of date-time data, 
# extraction and updating of components of
# a date-time (years, months, days, hours, minutes, 
# and seconds), algebraic manipulation on date-time 
# and time-span objects. 

# The 'lubridate' package has a consistent and 
# memorable syntax that makes working with dates 
# easy and fun.

# Authors: Garret Grolemund and Hadley Wickham

# Tidyverse Collection of R packages

library(magrittr)

# today()

Sys.Date()

Sys.Date() %>% class()

this_day <- today()

this_day

this_day %>% class()

y <- year(this_day)
y

m <- month(this_day)
m

d <-day(this_day)
d


wday(this_day)
wday(this_day, label = TRUE)


Sys.time()

this_moment <- now()

this_moment


this_hour <- hour(this_moment)
this_hour

this_min  <- minute(this_moment)
this_min

this_sec <- second(this_moment)
this_sec

################################

# lubridate offers a variety of functions for parsing date-times. 


this_date <- ymd("2016-04-01")   # 1st April 2016
this_date

this_date <- ymd("20160401")  # ok, but potentially problematic

this_date %>% class()

this_date <- dmy("01-04-2016")
this_date

this_date <- mdy("04-01-2016")
this_date
wday(this_date,label=TRUE)

this_date <- ymd("20160401")

this_date <- ymd("2016/04/01")
this_date

#Error
this_date <- ymd("2016\04\01")
this_date
