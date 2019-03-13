# This is the correct way to create datasets.

library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")
estratorim_origen <- read.csv("estratorim_origen.csv",
                              colClasses = c("factor", "factor",
                                             "logical", "logical"),
                              encoding = "UTF-8")

# use_data() create the file in /data (before, we have to copy manually, but not
# rigth now). The file created has extension .rda, instead of .Rdata.
usethis::use_data(estratorim_origen, overwrite = TRUE)

# we have to make sure there aren't a .Rdata file with the same name than the
# .rda file just created, because R read firts the .Rdata and ignore the .rda

devtools::document()

setwd(original_wd)
rm(original_wd, estratorim_origen)
