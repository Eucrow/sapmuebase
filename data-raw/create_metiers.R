library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

metiers <- read.csv("metiers.csv",
                    header = T,
                    colClasses = c("factor", "factor", "character"),
                    sep = ";",
                    fileEncoding = "UTF-8")

usethis::use_data(metiers, overwrite = TRUE)

devtools::document()

setwd(original_wd)

rm(original_wd, metiers)
