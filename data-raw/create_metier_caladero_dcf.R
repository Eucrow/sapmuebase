library(devtools)

usethis::use_data_raw()

original_wd <- getwd()
setwd("data-raw")

metier_caladero_dcf <- read.csv("metier_caladero_dcf.csv",
                                header = T,
                                colClasses = c("factor", "factor", "factor",
                                               "factor"),
                                sep = ";", fileEncoding = "UTF-8")
colnames(metier_caladero_dcf) <- c("METIER_DCF", "CALADERO_DCF", "ESTRATO_RIM",
                                   "COD_ORIGEN")
# use_data() create the file in /data
usethis::use_data(metier_caladero_dcf, overwrite = TRUE)

devtools::document()

setwd(original_wd)
rm(original_wd, metier_caladero_dcf)
