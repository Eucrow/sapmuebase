library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

arte <- read.csv("arte.csv", colClasses = c("factor", "factor", "logical",
                                            "logical"))

usethis::use_data(arte, overwrite = TRUE)

devtools::document()


setwd(original_wd)
rm(original_wd, arte)
