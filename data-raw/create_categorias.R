#' Categories in SIRENO
#'
#' A dataset containing the categories available in SIRENO. The original data
#' is obtained from SIRENO (report by project --> categories). This report have
#' this structure:
#' - first 6 rows with useless information
#' - the 8th row with this column names:
#'   COD CAT, CATEGORIA, COD PUERTO, PUERTO, COD ESP, ESPECIE, ALFA3, PROCESO

library(devtools)

original_wd <- getwd()
setwd("data-raw")
categorias <- read.csv("categorias_2022_10.csv",
                     sep=";",
                     skip = 6,
                     header = TRUE,
                     colClasses = c("factor"), fileEncoding = "windows-1252")
colnames(categorias) <- c("COD_CATEGORIA", "CATEGORIA", "COD_PUERTO", "PUERTO", "COD_ESP", "ESP", "A3_ESP", "PROCESO")

# Clean dataset
categorias <- categorias[, c("COD_PUERTO", "PUERTO", "COD_ESP", "ESP", "COD_CATEGORIA", "CATEGORIA", "PROCESO")]

# use_data() create the file in /data
usethis::use_data(categorias, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, categorias)
