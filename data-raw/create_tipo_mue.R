library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

tipo_mue <- read.csv("tipo_mue.csv", colClasses = c("factor", "factor", "factor"))

# use_data() create the file in /data (before, we have to copy manually, but not
# rigth now). The file created has extension .rda, instead of .Rdata.
usethis::use_data(tipo_mue, overwrite = TRUE)

# we have to make sure there aren't a .Rdata file with the same name than the
# .rda file just created, because R read firts the .Rdata and ignore the .rda

devtools::document()

setwd(original_wd)
rm(original_wd, tipo_mue)
