library(devtools)
original_wd <- getwd()
setwd("data-raw")
relacion_variables <- read.table(file = "relacion_variables.csv",
                                row.names = NULL,
                                header = TRUE,
                                sep = ";",
                                fill = TRUE,
                                as.is = T)
save(relacion_variables, file = "relacion_variables.RData")
setwd(original_wd)
rm(original_wd, relacion_variables)
devtools::use_data_raw()
# IMPORTANT: COPY FILE TO /data
# AND THEN: devtools::use_data()
