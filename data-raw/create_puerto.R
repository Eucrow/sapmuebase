library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

puerto <- read.csv("puerto.csv",
                   colClasses = c("factor", "factor", "factor"),
                   fileEncoding = "UTF-8")

usethis::use_data(puerto, overwrite = TRUE)

devtools::document()


setwd(original_wd)
rm(original_wd, puerto)
