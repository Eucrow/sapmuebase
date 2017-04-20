#file maestro_categorias.csv is obtained by a personal petition to SIRENO team
#with the next columns: ESPCOD;ESPDESTAX;PUECOD;PUEDES;ESPCAT;TIPPROCOD
#Usually, the petition is answered with a xls file, than must be exported to csv
#and coded in ANSI.

library(devtools)
original_wd <- getwd()
setwd("data-raw")
maestro_categorias <- read.csv("maestro_categorias.csv",
                               sep=";",
                               colClasses = c("factor"))
save(maestro_categorias, file = "maestro_categorias.RData")
setwd(original_wd)
rm(original_wd, maestro_categorias)
devtools::use_data_raw()
# IMPORTANT: COPY FILE TO /data
# AND THEN: devtools::use_data()
