library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

origen <- read.csv("origen.csv", colClasses = c("factor", "factor"))

# use_data() create the file in /data
usethis::use_data(origen, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, origen)
