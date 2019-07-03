#file maestro_categorias.csv is obtained by a personal petition to SIRENO team
#with the next columns: ESPCOD;ESPDESTAX;PUECOD;PUEDES;ESPCAT;TIPPROCOD (can be more)
#Usually, the petition is answered with a xls file, than must be exported to csv
#and coded in ANSI.

library(devtools)
original_wd <- getwd()
setwd("data-raw")
maestro_categorias <- read.csv("maestro_categorias.csv",
                               sep=";",
                               colClasses = c("factor"))


# use_data() create the file in /data
usethis::use_data(maestro_categorias, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, maestro_categorias)
