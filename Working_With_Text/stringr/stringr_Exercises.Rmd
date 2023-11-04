substring("kevin",1,1)
nchar("Kevin")

substring("kevin",nchar("kevin"))


substring("kevin",c(1,nchar("kevin")))

##############################
# Package Demo
library(stringr)
x <- c("abcdef", "ghifjk")
# The 3rd letter
str_sub(x, 3, 3)
#> [1] "c" "i"
# The 2nd to 2nd-to-last character
str_sub(x, 2, -2)
#> [1] "bcde" "hifj"
str_sub(x, -2, -1)
str_sub("Kevin", -2, -1)
str_sub("Kevin", -1, -1)
library(magrittr) %>% toupper
library(magrittr) 
str_sub("Kevin", -1, -1) %>% toupper
history(30)
