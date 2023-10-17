options(digits.secs = 5)

# Using POSIXct date types (stored as large integers basically)
datetime.ct <- as.POSIXct(c("2016-09-01 20:28:19.00", "2017-12-13 00:00:00.01"))

# Notice anything a bit strange here?
datetime.ct

# Using POSIXlt date types (stored in a decimal format)
datetime.lt <- as.POSIXlt(c("2016-09-01 20:28:19.00", "2017-12-13 00:00:00.01"))

# Nothing too unusual here though, right?
datetime.lt 

# This makes sense for what I defined, but not what is being displayed...
datetime.lt - datetime.ct 

# But I am sure R is right so lets try something simple, say addition...

# lets add 1 second
datetime.ct + 1
datetime.lt + 1

# Hold on now the lt has also forgotten about that all important .01?

# lets add a fraction of a second, because that is what I actually need...
datetime.ct + 0.01
datetime.lt + 0.01

# so datetime.ct now displays as it should have in the beginning, nothing appears to have changed in 
# datetime.lt though...

# lets try to see if we can figure out when then...
datetime.ct + 0.01 + 0.00000011920929
datetime.lt + 0.01 + 0.00000011920929

# ah wait maybe it would be better to express things in its fractional form
datetime.ct + (1 / 100)
datetime.lt + (1 / 100)

datetime.ct + (2 / 100)
datetime.lt + (2 / 100)

# My question is what the f*uck is going on here?
