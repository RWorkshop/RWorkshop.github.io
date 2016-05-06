Generating Random Numbers
========================================================

We have numerous ways of generating a set of random numbers. As well as specifying how many numbers we want, we can specify the distribution we want the set to follow.
For the following examples, we will use 
- The Continuous Uniform Distribution
- The Normal Distribution
However, the general principles apply to most other distributions also.

### Uniformly distributed random numbers
For example, suppose we wish to randomly generate 4 uniformly distributed numbers.  
We must specify the uniform distribution (**U(a,b)**) parameters; the lower and upper bounds (a,b), Lets use 0 and 6, and call the data set "Set1".   
We use the **runif()** to generate random values from the uniform distribution.
(N.B  "**r**" for random and "**unif**" for uniform)

```r
Set1 = runif(4, 0, 6)
Set1
```

```
## [1] 3.968 1.149 5.000 4.006
```

#### Managing Precision
Recall, we can discretize these random values by using the **floor()** or the **ceiling()** commands.   We can also use the **round()** command, if we specify the precision to be 0.

### Normally distributed random numbers
We use the **rnorm()** command to generate normally distributed values.
We can specify the two parameters of the normal distribution.

-The normal mean "mean =".
-The normal standard deviation  "sd =".
  
For the next example, let us choose 5 and 2 respectively.


```r
X = rnorm(14, mean = 5, sd = 2)
X
```

```
##  [1] 7.050 5.498 5.092 2.392 5.436 6.801 6.620 4.609 2.730 5.047 2.731
## [12] 3.113 4.035 3.518
```

```r
summary(X)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    2.39    3.21    4.83    4.62    5.48    7.05
```

#### Standard Normal Distribution
If we do not specify a mean and standard deviation, *R* automatically assigns the values 0 and 1. 
This is the standard normal (Z) distribution.


```r
X <- rnorm(100)
X[1:14]  # First fourteen values
```

```
##  [1]  1.5379 -1.0559 -0.1578  2.1526  1.1708  0.6227 -0.4724  0.1060
##  [9]  2.7240 -2.1335 -0.5801  2.2189 -0.1204  1.5700
```

```r
summary(X)  # Summary (Max and Min?)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##  -2.530  -0.472   0.331   0.228   0.909   2.720
```

