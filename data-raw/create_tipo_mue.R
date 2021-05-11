library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

tipo_mue <- read.csv("tipo_mue.csv", colClasses = c("factor", "factor", "factor"))

usethis::use_data(tipo_mue, overwrite = TRUE)

devtools::document()


setwd(original_wd)
rm(original_wd, tipo_mue)
