library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

cfpo2019 <- read.csv("CFPO_2019.csv", sep = ";")

# use_data() create the file in /data
usethis::use_data(cfpo2019, overwrite = TRUE)

setwd(original_wd)
rm(original_wd, cfpo2019)
