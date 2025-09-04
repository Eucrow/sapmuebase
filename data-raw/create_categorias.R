#' Categories in SIRENO
#'
#' A data set containing the categories available in SIRENO. The original data
#' is obtained from SIRENO (report by project --> categories). This report have
#' this structure:
#' - first 6 rows with useless information
#' - the 8th row with this column names:
#'   COD CAT, CATEGORIA, COD PUERTO, PUERTO, COD ESP, ESPECIE, ALFA3, PROCESO

library(devtools)

original_wd <- getwd()
setwd("data-raw")
<<<<<<< HEAD
categorias <- read.csv("IEOCATPUE3MARCO_2025_06.TXT",
  sep = ";",
  skip = 6,
  header = TRUE,
  colClasses = c("factor"), fileEncoding = "windows-1252"
)
=======
categorias <- read.csv("IEOCATPUE3ACANDELARIO_2025_09.TXT",
                     sep=";",
                     skip = 6,
                     header = TRUE,
                     colClasses = c("factor"), fileEncoding = "windows-1252")
>>>>>>> 5958d71e489afa8934e5ac5903c58ae69e337995
colnames(categorias) <- c("COD_CATEGORIA", "CATEGORIA", "COD_PUERTO", "PUERTO", "COD_ESP", "ESP", "A3_ESP", "PROCESO")

# Clean dataset
categorias <- categorias[, c("COD_PUERTO", "PUERTO", "COD_ESP", "ESP", "COD_CATEGORIA", "CATEGORIA", "PROCESO")]

# use_data() create the file in /data
usethis::use_data(categorias, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, categorias)
