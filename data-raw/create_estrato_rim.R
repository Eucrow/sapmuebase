library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

estrato_rim <- read.csv("estrato_rim.csv", fileEncoding = "UTF-8")

usethis::use_data(estrato_rim, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, estrato_rim)

