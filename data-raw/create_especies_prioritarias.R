library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

especies_prioritarias <- read.csv("especies_prioritarias.csv",
                                  colClasses = c("factor", "character", "factor",
                                                 "factor", "character", "factor",
                                                 "factor",  "character"),
                                  fileEncoding = "UTF-8",
                                  sep=";")

usethis::use_data(especies_prioritarias, overwrite = TRUE)

devtools::document()


setwd(original_wd)
rm(original_wd, especies_prioritarias)
