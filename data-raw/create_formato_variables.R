library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")
formato_variables <- read.table(file = "formato_variables.csv",
                                row.names = NULL,
                                header = TRUE,
                                sep = ";",
                                fill = TRUE,
                                as.is = T,
                                fileEncoding = "windows-1252")

# use_data() create the file in /data. The file created has extension .rda
usethis::use_data(formato_variables, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, formato_variables)

