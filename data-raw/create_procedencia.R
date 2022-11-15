library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

procedencia <- read.csv("procedencia.csv",
                        colClasses = c("factor"),fileEncoding = "UTF-8")

usethis::use_data(procedencia, overwrite = TRUE)

devtools::document()


setwd(original_wd)
rm(original_wd, procedencia)
