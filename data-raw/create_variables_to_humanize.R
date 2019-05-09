# This dataset contain the variables suitable to humanize and its data related

library(devtools)

original_wd <- getwd()

setwd("data-raw")

variables_to_humanize <- read.csv("variables_to_humanize.csv")

# use_data() create the file in /data
usethis::use_data(variables_to_humanize, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, variables_to_humanize)
