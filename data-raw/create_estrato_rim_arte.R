library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

estrato_rim_arte <- read.csv("estrato_rim_arte.csv",
                              colClasses = c("factor", "factor", "factor"),
                              encoding = "UTF-8")

# use_data() create the file in /data
usethis::use_data(estrato_rim_arte, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, estrato_rim_arte)
