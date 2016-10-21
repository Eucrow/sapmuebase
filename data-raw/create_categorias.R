library(devtools)
original_wd <- getwd()
setwd("data-raw")
maestro_categorias <- read.csv("maestro_categorias.csv",
                               sep=";",
                               colClasses = c("factor", NA, "factor", NA, "factor", NA, NA, NA))
save(maestro_categorias, file = "maestro_categorias.RData")
setwd(original_wd)
rm(original_wd, maestro_categorias)
devtools::use_data_raw()
# IMPORTANT: COPY FILE TO /data
# AND THEN: devtools::use_data()
