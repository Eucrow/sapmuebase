library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

cfpo2018 <- read.csv("CFPO_2018.csv", sep = ";")

# use_data() create the file in /data
usethis::use_data(cfpo2018, overwrite = TRUE)

setwd(original_wd)
rm(original_wd, cfpo2018)
