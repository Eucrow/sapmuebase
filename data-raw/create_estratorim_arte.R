library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

estratorim_arte <- read.csv("estratorim_arte.csv",
                              colClasses = c("factor", "factor", "factor",
                                             "logical", "logical"),
                              encoding = "UTF-8")

# use_data() create the file in /data
usethis::use_data(estratorim_arte, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, estratorim_arte)
