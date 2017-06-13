# This dataset contain the variables suitable to humanize and its data related

library(devtools)

original_wd <- getwd()

setwd("data-raw")

variables_to_humanize <- read.csv("variables_to_humanize.csv")

save(variables_to_humanize, file = "variables_to_humanize.RData")

setwd(original_wd)

rm(original_wd, species)

devtools::use_data_raw()
# IMPORTANT: COPY FILE TO /data
# AND THEN: devtools::use_data()
