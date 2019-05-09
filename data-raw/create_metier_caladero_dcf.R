library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

metier_caladero_dcf <- read.csv("metier_caladero_dcf.csv",
                                header = T,
                                colClasses = c("factor", "factor", "factor",
                                               "factor","logical", "logical"),
                                sep = ";")
colnames(metier_caladero_dcf) <- c("ESTRATO_RIM", "METIER_DCF", "CALADERO_DCF",
                                   "COD_ORIGEN", "RIM", "OAB")
# use_data() create the file in /data
usethis::use_data(metier_caladero_dcf, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, metier_caladero_dcf)
