


1. Database
SQLITE
Installing
Selecting
Inserting
MySQL
Installing
Linux
Windows
Selecting
PostgreSQL
RODBC
Read MS Excel Files
Reading and Writing Data
Connections
Examples
Data Frames
Determining Size
Date/Time
Parse a Date
Dates and data.frames
Format a Date
Time Intervals
Time Sequences
Formulas
Graphics
Simple Plot
Plot Multiple Timeseries
Pause between Plots
Plot a filled countour
Examples
Plot Least Squares Fit
Plot ESRI Shapefile
Clustering
Package ''flexclust''
Machine Learning/Statistical Learning
Spatial data
Work with shapefiles
Timeseries
Create a Timeseries
Extending a Timeseries
Debugging
browser
debug/undebug
Random Data
Generate a Random Matrix

#### 1. Database

SQLITE
Access to sqlite is provided via the RSQLite package.

Installing

sudo R install.packages("RSQLite")

Selecting
Note: To fetch all rows of a resultset, append n=-1 to your fetch statement.
library(RSQLite) driver = dbDriver("SQLite") con <- dbConnect(driver,dbname="some_sqlite.db") dbListTables(con) # show tables rs <- dbSendQuery(con, "SELECT * from sensordata limit 10") # send a query data <- fetch(rs,n=3) # fetch 3 rows from result (use -1 to fetch all rows) dbHasCompleted(rs) # checks if other rows left and returns true/false #cleanup dbClearResult(rs) dbDisconnect(con) dbUnloadDriver(driver)

Inserting
library(RSQLite); driver = dbDriver("SQLite"); con <- dbConnect(driver, dbname="/home/soma/Desktop/testdata.db"); data(USArrests); #prepare some data frame dbWriteTable(con,"arrests", USArrests); # insert it as a table #cleanup dbClearResult(rs); dbDisconnect(con); dbUnloadDriver(driver);

MySQL

Installing

Linux
sudo aptitude install r-cran-rmysql

Windows
Set system variable MYSQL_HOME (RMYSQL directory in R-directory e.g. C:\Programme\R\R-2.8.1\library\RMySQL)
Directory defined above has to contain the client DLL for MySQL-Servers. A specific structure of subdirectories has to be created.

#### Selecting
library(RMySQL) roadid = 1234 laneid = 1 drv = dbDriver("MySQL") con = dbConnect(drv,dbname="flow_timeseries",user="123",pass="123",host="10.10.10.10") sql <- paste("SELECT * from timeseries WHERE roadid = ",roadid,"AND laneid = ",laneid,"ORDER BY day") res <- dbSendQuery(con,sql) data <- fetch(res, n = -1) dbDisconnect(con)

#### PostgreSQL
Install the r-base postgres server dependencies

sudo apt-get install r-base-dev postgresql-server-dev-8.3 sudo R
In an R shell, install the necessary packages

rS="http://www.bioconductor.org/packages/release/bioc/" install.packages("Rdbi", repos=rS, dependencies=TRUE) install.packages("RdbiPgSQL", repos=rS, dependencies=TRUE)
Talk to a postgres from within R:
library(RdbiPgSQL) drv <- PgSQL() con <- dbConnect(drv, dbname="advanced", user="1234", password="1234", host="10.10.10.10") res <- dbSendQuery(con, "SELECT * FROM ...") data <- dbGetResult(res) dbDisconnect(con)

RODBC
Package RODBC on CRAN provides an interface to database sources supporting an ODBC interface. This is very widely available, and allows the same R code to access different database systems. RODBC runs on both Unix/Linux and Windows, and almost all database systems provide support for ODBC.

Read MS Excel Files
As a simple example of using ODBC under Windows with a Excel spreadsheet, we can read from a spreadsheet by
library(RODBC) channel <- odbcConnectExcel("bdr.xls") ## list the spreadsheets > sqlTables(channel)
TABLE_CAT TABLE_SCHEM TABLE_NAME TABLE_TYPE REMARKS 1 C:\\bdr NA Sheet1$ SYSTEM TABLE NA 2 C:\\bdr NA Sheet2$ SYSTEM TABLE NA 3 C:\\bdr NA Sheet3$ SYSTEM TABLE NA 4 C:\\bdr NA Sheet1$Print_Area TABLE NA
sh1 <- sqlFetch(channel, "Sheet1") sh1 <- sqlQuery(channel, "select * from [Sheet1$]")



##### Examples
Skip last lines of a data file (e.g. last two lines):
con <- textConnection(rev(rev(readLines('data.txt'))[-(1:2)])) data <- read.table(con) close(con)
Read data from gzip-compressed file:
gz <- gzfile("datafile.csv.gz", "r") raw <- textConnection(readLines(gz)) close(gz) dataset <- read.table(raw, sep=";", as.is=TRUE, header=TRUE) close(raw)

#### Data Frames

Determining Size
df = data.frame(...) row_count = nrow(df) col_count = ncol(df) dim(df)


#### Formulas
Formulas in R can be thought of as a "little language" since they obey a different structure and syntax from expressions. Expressions when evaluated produce some result such as a number, vector or list which is then displayed by the print function. Formulas on the other hand are used as a concise and intuitive way of specifying a statistical model. For example, consider a multiple linear regression of y on a numeric variable x1 and its squared value, x1^2 and a categorical variable x2. Note that in R categorical variables are called factors. This regression is specified by:
y ~ x1 + I(x1^2) + x2
and could be fit using the lm function (linear model, regression):
lm(y ~ x1 + I(x1^2) + x2)

In the formula notation, "~" means the left-hand-side is the independent variable or response and the right-hand-side are the dependent variables. The I(x1^2) means interpret the inside expression as a regular expression in R. Including a factor variable like x2 is very convenient since we don't have to be bothered about specifying all the indicator variables as we would have to do in other statistical software.

[http://cran.r-project.org/doc/manuals/R-intro.html#Formulae-for-statistical-models Defining statistical models; formulae]
