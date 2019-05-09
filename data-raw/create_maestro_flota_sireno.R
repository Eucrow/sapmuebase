library(devtools)
original_wd <- getwd()
setwd("data-raw")
maestro_flota_sireno <- read.csv("maestro_flota_sireno.csv", sep = ";")
maestro_flota_sireno$BARCOD <- sprintf("%06d", maestro_flota_sireno$BARCOD)
# use_data() create the file in /data
usethis::use_data(maestro_flota_sireno, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, maestro_flota_sireno)
