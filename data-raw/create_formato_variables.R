library(devtools)
original_wd <- getwd()
setwd("data-raw")
formato_variables <- read.table(file = "formato_variables.csv",
                                row.names = NULL,
                                header = TRUE,
                                sep = ";",
                                fill = TRUE,
                                as.is = T)
save(formato_variables, file = "formato_variables.RData")
setwd(original_wd)
rm(original_wd, formato_variables)
devtools::use_data_raw()
# IMPORTANT: COPY FILE TO /data
# AND THEN: devtools::use_data()
