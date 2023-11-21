library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")
relacion_variables <- read.table(file = "relacion_variables.csv",
                                row.names = NULL,
                                header = TRUE,
                                sep = ";",
                                fill = TRUE,
                                as.is = T)

# use_data() create the file in /data (before, we have to copy manually, but not
# right now). The file created has extension .rda, instead of .Rdata.
usethis::use_data(relacion_variables, overwrite = TRUE)

# we have to make sure there aren't a .Rdata file with the same name than the
# .rda file just created, because R read first the .Rdata and ignore the .rda

devtools::document()

setwd(original_wd)
rm(original_wd, relacion_variables)

