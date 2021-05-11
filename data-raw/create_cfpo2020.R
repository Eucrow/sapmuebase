library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

cfpo2020 <- read.csv("./data_source_private/CFPO_2020.csv", sep = ";")

# use_data() create the file in /data
usethis::use_data(cfpo2020, overwrite = TRUE)

setwd(original_wd)
rm(original_wd, cfpo2020)
