library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

arte <- read.csv("arte.csv",
                 colClasses = c("factor", "factor"),
                 fileEncoding = "UTF-8")

usethis::use_data(arte, overwrite = TRUE)

devtools::document()


setwd(original_wd)
rm(original_wd, arte)
