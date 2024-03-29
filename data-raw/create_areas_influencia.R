library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

areas_influencia <- read.csv("areas_influencia.csv",
                             colClasses = "factor",
                             fileEncoding = "UTF-8")

usethis::use_data(areas_influencia, overwrite = TRUE)

devtools::document()


setwd(original_wd)
rm(original_wd, areas_influencia)

