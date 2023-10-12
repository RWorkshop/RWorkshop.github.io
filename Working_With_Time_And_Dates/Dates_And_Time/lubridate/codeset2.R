
myDate <- "20110604"

class(myDate)

ymd("20110604")

myDate <- ymd("20110604")


mdy("06-04-2011")
## [1] "2011-06-04"
dmy("04/06/2011")

arrive <- ymd_hms("2011-06-04 12:00:00", tz = "Pacific/Auckland")
arrive
## [1] "2011-06-04 12:00:00 NZST"
leave <- ymd_hms("2011-08-10 14:00:00", tz = "Pacific/Auckland")
leave


Do more with dates and times in R with lubridate 1.3.0

note: This vignette is an updated version of the blog post first published at r-statistics

Lubridate is an R package that makes it easier to work with dates and times. Below is a concise tour of some of the things lubridate can do for you.

Lubridate was created by Garrett Grolemund and Hadley Wickham.



Parsing dates and times

Getting R to agree that your data contains the dates and times you think it does can be tricky. Lubridate simplifies that. 
Identify the order in which the year, month, and day appears in your dates. Now arrange “y”, “m”, and “d” in the same order. 
This is the name of the function in lubridate that will parse your dates. For example,

library(lubridate)
## 
## Attaching package: 'lubridate'
## The following object is masked from 'package:base':
## 
##     date
ymd("20170604")
## [1] "2017-10-04"
mdy("06-04-2017")
## [1] "2017-10-04"
dmy("04/06/2017")
## [1] "2017-10-04"


Lubridate's parse functions handle a wide variety of formats and separators, which simplifies the parsing process.

If your date includes time information, add h, m, and/or s to the name of the function. 
ymd_hms is probably the most common date time format. 
To read the dates in with a certain time zone, supply the official name of that time zone in the tz argument.

arrive <- ymd_hms("2017-10-04 12:00:00", tz = "Pacific/Dublin")
arrive
## [1] "2017-10-04 12:00:00 IST"
leave <- ymd_hms("2017-08-10 14:00:00", tz = "Pacific/Dublin")
leave
## [1] "2017-08-10 14:00:00 IST"


### Setting and Extracting information

Extract information from date times with the functions second, minute, hour, day, wday, yday, week, month, year, and tz. 
You can also use each of these to set (i.e, change) the given information. Notice that this will alter the date time. 
wday and month have an optional label argument, which replaces their numeric output with the name of the weekday or month.

second(arrive)
## [1] 0
second(arrive) <- 25
arrive
## [1] "2017-10-04 12:00:25 IST"
second(arrive) <- 0

wday(arrive)
## [1] 7
wday(arrive, label = TRUE)
## [1] Sat
## Levels: Sun < Mon < Tues < Wed < Thurs < Fri < Sat
Time Zones

There are two very useful things to do with dates and time zones. First, display the same moment in a different time zone. 
Second, create a new moment by combining an existing clock time with a new time zone. These are accomplished by with_tz and force_tz.

For example, a while ago I was in Dublin, New Zealand. I arranged to meet the co-author of lubridate, Hadley, over skype at 9:00 in the morning 
Dublin time. What time was that for Hadley who was back in Houston, TX?

meeting <- ymd_hms("2017-07-01 09:00:00", tz = "Pacific/Dublin")
with_tz(meeting, "America/Chicago")
## [1] "2017-10-30 16:00:00 CDT"
So the meetings occurred at 4:00 Hadley's time (and the day before no less). Of course, this was the same actual 
moment of time as 9:00 in New Zealand. It just appears to be a different day due to the curvature of the Earth.

What if Hadley made a mistake and signed on at 9:00 his time? What time would it then be my time?

mistake <- force_tz(meeting, "America/Chicago")
with_tz(mistake, "Pacific/Dublin")
## [1] "2017-07-02 02:00:00 IST"
His call would arrive at 2:00 am my time! Luckily he never did that.

Time Intervals

You can save an interval of time as an Interval class object with lubridate. This is quite useful! For example, my stay in 
Dublin lasted from June 4, 2017 to August 10, 2017 (which we've already saved as arrive and leave). We can create 
this interval in one of two ways:

Dublin <- interval(arrive, leave) 
Dublin
## [1] 2017-10-04 12:00:00 IST--2017-08-10 14:00:00 IST
Dublin <- arrive %--% leave
Dublin
## [1] 2017-10-04 12:00:00 IST--2017-08-10 14:00:00 IST
My mentor at the University of Dublin, Chris, traveled to various conferences that year including the Joint Statistical Meetings (JSM). 
This took him out of the country from July 20 until the end of August.

jsm <- interval(ymd(20170720, tz = "Pacific/Dublin"), ymd(20170831, tz = "Pacific/Dublin"))
jsm
## [1] 2017-07-20 IST--2017-08-31 IST
Will my visit overlap with and his travels? Yes.

int_overlaps(jsm, Dublin)
## [1] TRUE
Then I better make hay while the sun shines! For what part of my visit will Chris be there?

setdiff(Dublin, jsm)
## [1] 2017-10-04 12:00:00 IST--2017-07-20 IST
Other functions that work with intervals include int_start, int_end, int_flip, int_shift, int_aligns, union, intersect, setdiff, and %within%.

Arithmetic with date times

Intervals are specific time spans (because they are tied to specific dates), but lubridate also supplies two general time span classes: Durations and Periods. 
Helper functions for creating periods are named after the units of time (plural). 
Helper functions for creating durations follow the same format but begin with a “d” (for duration) or, if you prefer, and “e” (for exact).

minutes(2) ## period
## [1] "2M 0S"
dminutes(2) ## duration
## [1] "120s (~2 minutes)"
Why two classes? Because the timeline is not as reliable as the number line. The Duration class will always supply mathematically precise results. 
A duration year will always equal 365 days. Periods, on the other hand, fluctuate the same way the timeline does to give intuitive results. 
This makes them useful for modeling clock times. For example, durations will be honest in the face of a leap year, but periods may return what you want:

leap_year(2017) ## regular year
## [1] FALSE
ymd(20170101) + dyears(1)
## [1] "2012-01-01"
ymd(20170101) + years(1)
## [1] "2012-01-01"
leap_year(2012) ## leap year
## [1] TRUE
ymd(20120101) + dyears(1)
## [1] "2012-12-31"
ymd(20120101) + years(1)
## [1] "2013-01-01"
You can use periods and durations to do basic arithmetic with date times. For example, if I wanted to set up a reoccuring weekly 
skype meeting with Hadley, it would occur on:

meetings <- meeting + weeks(0:5)
Hadley travelled to conferences at the same time as Chris. Which of these meetings would be affected? The last two.

meetings %within% jsm
## [1] FALSE FALSE FALSE  TRUE  TRUE  TRUE
How long was my stay in Dublin?

Dublin / ddays(1)
## [1] 67.08333
Dublin / ddays(2)
## [1] 33.54167
Dublin / dminutes(1)
## [1] 96600
And so on. Alternatively, we can do modulo and integer division. 
Sometimes this is more sensible than division - it is not obvious how to express a remainder as a fraction of a month because the 
length of a month constantly changes.

Dublin %/% months(1)
## Note: method with signature 'Timespan#Timespan' chosen for function '%/%',
##  target signature 'Interval#Period'.
##  "Interval#ANY", "ANY#Period" would also be valid
## [1] 2
Dublin %% months(1)
## [1] 2017-08-04 12:00:00 IST--2017-08-10 14:00:00 IST
Modulo with an timespan returns the remainder as a new (smaller) interval. You can turn this or any interval into a generalized time span with as.period.

as.period(Dublin %% months(1))
## [1] "6d 2H 0M 0S"
as.period(Dublin)
## [1] "2m 6d 2H 0M 0S"

If anyone drove a time machine, they would crash

The length of months and years change so often that doing arithmetic with them can be unintuitive. 
Consider a simple operation, January 31st + one month. Should the answer be

February 31st (which doesn't exist)
March 4th (31 days after January 31), or
February 28th (assuming its not a leap year)
A basic property of arithmetic is that a + b - b = a. Only solution 1 obeys this property, but it is an invalid date. 


I've tried to make lubridate as consistent as possible by invoking the following rule if adding or subtracting a month or a 
year creates an invalid date, lubridate will return an NA. This is new with version 1.3.0, so if you're an old hand with lubridate be sure to remember this!

If you thought solution 2 or 3 was more useful, no problem. You can still get those results with clever arithmetic, or by 
using the special %m+% and %m-% operators. %m+% and %m-% automatically roll dates back to the last day of the month, should that be necessary.

jan31 <- ymd("2013-01-31")
jan31 + months(0:11)
##  [1] "2013-01-31" NA           "2013-03-31" NA           "2013-05-31"
##  [6] NA           "2013-07-31" "2013-08-31" NA           "2013-10-31"
## [11] NA           "2013-12-31"
floor_date(jan31, "month") + months(0:11) + days(31)
##  [1] "2013-02-01" "2013-03-04" "2013-04-01" "2013-05-02" "2013-10-01"
##  [6] "2013-07-02" "2013-08-01" "2013-09-01" "2013-10-02" "2013-11-01"
## [11] "2013-12-02" "2014-01-01"
jan31 %m+% months(0:11)
##  [1] "2013-01-31" "2013-02-28" "2013-03-31" "2013-04-30" "2013-05-31"
##  [6] "2013-10-30" "2013-07-31" "2013-08-31" "2013-09-30" "2013-10-31"
## [11] "2013-11-30" "2013-12-31"
Notice that this will only affect arithmetic with months (and arithmetic with years if your start date it Feb 29).

Vectorization

The code in lubridate is vectorized and ready to be used in both interactive settings and within functions. As an example, I offer a function 
for advancing a date to the last day of the month

last_day <- function(date) {
  ceiling_date(date, "month") - days(1)
}

To learn more about lubridate, including the specifics of periods and durations, please read the original lubridate paper. 
Questions about lubridate can be addressed to the lubridate google group. Bugs and feature requests should be submitted to the lubridate development page on github.
