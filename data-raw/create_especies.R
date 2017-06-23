# This dataset is obtained from the file maestro_categorias.csv (wich is obtained
# by a personal petition to SIRENO team) with the next columns:
# ESPCOD;ESPDESTAX;PUECOD;PUEDES;ESPCAT;TIPPROCOD
# Usually, the petition is answered with a xls file, than must be exported to csv
# and coded in ANSI.

library(devtools)
original_wd <- getwd()
setwd("data-raw")
especies <- read.csv("maestro_categorias.csv",
                               sep=";",
                               colClasses = c("factor", "factor", "factor", "factor", "factor", "factor"))
especies <- especies[, c("ESPCOD", "ESPDESTAX")]
especies <- unique(especies)
colnames(especies) <- c("COD_ESP", "ESP")

save(especies, file = "especies.RData")
setwd(original_wd)
rm(original_wd, species)
devtools::use_data_raw()
# IMPORTANT: COPY FILE TO /data
# AND THEN: devtools::use_data()
