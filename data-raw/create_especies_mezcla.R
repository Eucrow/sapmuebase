library(devtools)
original_wd <- getwd()
setwd("data-raw")
especies_mezcla <- read.csv("especies_mezcla.csv")


# use_data() create the file in /data
usethis::use_data(especies_mezcla, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, especies_mezcla)

