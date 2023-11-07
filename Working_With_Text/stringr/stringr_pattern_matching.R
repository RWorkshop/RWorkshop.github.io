
#### Pattern matching

The vast majority of stringr functions work with patterns. These are parameterised by the task they perform and the types of patterns they match.

#### Tasks

Each pattern matching function has the same first two arguments, a character vector of strings to process and a single pattern to match. stringr provides pattern matching functions to detect, locate, extract, match, replace, and split strings. Iâll illustrate how they work with some strings and a regular expression designed to match (US) phone numbers:
  
  
```{r}
strings <- c(
  "apple", 
  "219 733 8965", 
  "329-293-8753", 
  "Work: 579-499-7527; Home: 543.355.3679"
)
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"
```


<tt>str_detect()</tt> detects the presence or absence of a pattern and returns a logical vector (similar to grepl()). str_subset() returns the elements of a character vector that match a regular expression (similar to grep() with value = TRUE)`.


```{r}   
# Which strings contain phone numbers?
str_detect(strings, phone)
#> [1] FALSE  TRUE  TRUE  TRUE
str_subset(strings, phone)
#> [1] "219 733 8965"  
#> [2] "329-293-8753"  
#> [3] "Work: 579-499-7527; Home: 543.355.3679"
str_count() counts the number of matches:


```{r}
# How many phone numbers in each string?
str_count(strings, phone)
#> [1] 0 1 1 2

```

str_locate() locates the first position of a pattern and returns a numeric matrix with columns start and end. str_locate_all() locates all matches, returning a list of numeric matrices. Similar to regexpr() and gregexpr().

```{r}  
# Where in the string is the phone number located?
(loc <- str_locate(strings, phone))
#>  start end
#> [1,]NA  NA
#> [2,] 1  12
#> [3,] 1  12
#> [4,] 7  18
```

```{r}
str_locate_all(strings, phone)
#> [[1]]
#>  start end
#> 
#> [[2]]
#>  start end
#> [1,] 1  12
#> 
#> [[3]]
#>  start end
#> [1,] 1  12
#> 
#> [[4]]
#>  start end
#> [1,] 7  18
#> [2,]27  38
```




`str_extract()` extracts text corresponding to the first match, returning a character vector. str_extract_all() extracts all matches and returns a list of character vectors.

```{r}
# What are the phone numbers?
str_extract(strings, phone)
#> [1] NA "219 733 8965" "329-293-8753" "579-499-7527"
str_extract_all(strings, phone)
```

```{r}


#> [[1]]
#> character(0)
#> 
#> [[2]]
#> [1] "219 733 8965"
#> 
#> [[3]]
#> [1] "329-293-8753"
#> 
#> [[4]]
#> [1] "579-499-7527" "543.355.3679"
str_extract_all(strings, phone, simplify = TRUE)
#>  [,1]   [,2]  
#> [1,] "" ""
#> [2,] "219 733 8965" ""
#> [3,] "329-293-8753" ""
#> [4,] "579-499-7527" "543.355.3679"
```

str_match() extracts capture groups formed by () from the first match. It returns a character matrix with one column for the complete match and one column for each group. str_match_all() extracts capture groups from all matches and returns a list of character matrices. Similar to regmatches().

# Pull out the three components of the match
```{r}
str_match(strings, phone)
#>  [,1]   [,2]  [,3]  [,4]  
#> [1,] NA NANANA
#> [2,] "219 733 8965" "219" "733" "8965"
#> [3,] "329-293-8753" "329" "293" "8753"
#> [4,] "579-499-7527" "579" "499" "7527"
```

```{r}

str_match_all(strings, phone)
#> [[1]]
#>  [,1] [,2] [,3] [,4]
#> 
#> [[2]]
#>  [,1]   [,2]  [,3]  [,4]  
#> [1,] "219 733 8965" "219" "733" "8965"
#> 
#> [[3]]
#>  [,1]   [,2]  [,3]  [,4]  
#> [1,] "329-293-8753" "329" "293" "8753"
#> 
#> [[4]]
#>  [,1]   [,2]  [,3]  [,4]  
#> [1,] "579-499-7527" "579" "499" "7527"
#> [2,] "543.355.3679" "543" "355" "3679"
```


str_replace() replaces the first matched pattern and returns a character vector. str_replace_all() replaces all matches. Similar to sub() and gsub().


str_replace(strings, phone, "XXX-XXX-XXXX")
#> [1] "apple" 
#> [2] "XXX-XXX-XXXX"  
#> [3] "XXX-XXX-XXXX"  
#> [4] "Work: XXX-XXX-XXXX; Home: 543.355.3679"
str_replace_all(strings, phone, "XXX-XXX-XXXX")
#> [1] "apple" 
#> [2] "XXX-XXX-XXXX"  
#> [3] "XXX-XXX-XXXX"  
#> [4] "Work: XXX-XXX-XXXX; Home: XXX-XXX-XXXX"


str_split_fixed() splits the string into a fixed number of pieces based on a pattern and returns a character matrix. str_split() splits a string into a variable number of pieces and returns a list of character vectors.
```{r}
str_split("a-b-c", "-")
#> [[1]]
#> [1] "a" "b" "c"
str_split_fixed("a-b-c", "-", n = 2)
#>  [,1] [,2] 
#> [1,] "a"  "b-c"
```

### Fixed matches

fixed(x) only matches the exact sequence of bytes specified by x. This is a very limited âpatternâ, but the restriction can make matching much faster. Beware using fixed() with non-English data. It is problematic because there are often multiple ways of representing the same character. For example, there are two ways to define âÃ¡â: either as a single character or as an âaâ plus an accent:

```{r}  
  a1 <- "\u00e1"
a2 <- "a\u0301"
c(a1, a2)
#> [1] "Ã¡" "aÌ"
a1 == a2
#> [1] FALSE
```

They render identically, but because theyâre defined differently, fixed() doesnât find a match. Instead, you can use coll(), defined next, to respect human character comparison rules:
  
```{r}  
  str_detect(a1, fixed(a2))
#> [1] FALSE
str_detect(a1, coll(a2))
#> [1] TRUE
```

### Collation search

coll(x) looks for a match to x using human-language collation rules, and is particularly important if you want to do case insensitive matching. Collation rules diffe around the world, so youâll also need to supply a locale parameter.



```{r}
i <- c("I", "Ä°", "i", "Ä±")
i
#> [1] "I" "Ä°" "i" "Ä±"

```

```{r}

str_subset(i, coll("i", ignore_case = TRUE))
#> [1] "I" "i"
str_subset(i, coll("i", ignore_case = TRUE, locale = "tr"))
#> [1] "Ä°" "i"
```

The downside of coll() is speed; because the rules for recognising which characters are the same are complicated, coll() is relatively slow compared to regex() and fixed(). Note that will both fixed() and regex() have ignore_case arguments, they perform a much simpler comparison than coll().



```

```{r}
x <- "This is a sentence."
str_split(x, boundary("word"))
#> [[1]]
#> [1] "This" "is"   "a""sentence"
str_count(x, boundary("word"))
#> [1] 4
str_extract_all(x, boundary("word"))
#> [[1]]
#> [1] "This" "is"   "a""sentence"

```

```{r}
str_split(x, "")
#> [[1]]
#>  [1] "T" "h" "i" "s" " " "i" "s" " " "a" " " "s" "e" "n" "t" "e" "n" "c"
#> [18] "e" "."
str_count(x, "")
#> [1] 19

```
