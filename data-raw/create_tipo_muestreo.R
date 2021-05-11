library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

tipo_muestreo <- read.csv("tipo_muestreo.csv", colClasses = c("factor", "factor", "factor"))

usethis::use_data(tipo_muestreo, overwrite = TRUE)

devtools::document()


setwd(original_wd)
rm(original_wd, tipo_muestreo)
