library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

caladero_origen <- read.table(file = "caladero_origen.csv",
                              head = TRUE,
                              sep = ";",
                              fill = TRUE,
                              colClasses = c("character", "factor", "character"),
                              fileEncoding = "UTF-8")

# use_data() create the file in /data
usethis::use_data(caladero_origen, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, caladero_origen)
